import os
import numpy as np
import audioread
import json
import librosa
import pandas as pd
import scipy.stats as stats

from tqdm import tqdm
from concurrent.futures import ProcessPoolExecutor


def load_audio_with_audioread(file_name):
    with audioread.audio_open(file_name) as f:
        audio_data = []
        for buf in f:
            audio_data.append(np.frombuffer(buf, dtype=np.int16))
        audio = np.concatenate(audio_data)
    # Normalize audio to float values (audioread loads data as int16 by default)
    audio = audio.astype(np.float32) / np.iinfo(np.int16).max
    # Note: audioread does not provide sample rate conversion, so you need to handle the original sample rate
    return audio, f.samplerate


def spectral_entropy(signal, sr, n_fft=2048, hop_length=512, normalize=False):
    """
    Calculate the spectral entropy of an audio signal.

    Parameters:
    - signal: Audio time series
    - sr: Sampling rate of `signal`
    - n_fft: Length of the FFT window
    - hop_length: Number of samples between successive frames
    - normalize: Normalize the spectral entropy to the range [0, 1]

    Returns:
    - spectral_entropy: The spectral entropy of the signal
    """
    # Compute the power spectrogram
    S = np.abs(librosa.stft(signal, n_fft=n_fft, hop_length=hop_length)) ** 2
    # Normalize the power spectrogram
    S_norm = librosa.util.normalize(S, axis=0)
    # Compute the spectral entropy
    spectral_entropy = -np.sum(S_norm * np.log2(S_norm + 1e-6), axis=0)

    if normalize:
        # Normalize to the range [0, 1]
        spectral_entropy /= np.log2(S.shape[0])

    return spectral_entropy


def extract_audio_features(file_name):
    # Load the audio file
    audio, sample_rate = load_audio_with_audioread(file_name)
    # Extract features
    mfccs = librosa.feature.mfcc(y=audio, sr=sample_rate, n_mfcc=40)
    spec_cent = librosa.feature.spectral_centroid(y=audio, sr=sample_rate)
    meanfreq = np.mean(spec_cent)
    # print(spec_cent)
    # input()
    sd = np.std(spec_cent)
    median = np.median(spec_cent)
    Q25 = np.percentile(spec_cent, 25)
    Q75 = np.percentile(spec_cent, 75)
    IQR = Q75 - Q25
    skewness = np.mean(stats.skew(mfccs, axis=1))
    kurtosis = np.mean(stats.kurtosis(mfccs, axis=1))
    sp_ent = np.mean(spectral_entropy(audio, sample_rate, normalize=True))
    sfm = np.mean(librosa.feature.spectral_flatness(y=audio))
    mode = np.mean(stats.mode(spec_cent))
    centroid = meanfreq
    pitches, magnitudes = librosa.piptrack(y=audio, sr=sample_rate)
    meanfun = np.mean(pitches)
    minfun = np.min(pitches[np.nonzero(pitches)])
    maxfun = np.max(pitches)
    meandom = np.mean(magnitudes)
    mindom = np.min(magnitudes[np.nonzero(magnitudes)])
    maxdom = np.max(magnitudes)
    dfrange = maxdom - mindom
    modindx = np.mean(librosa.feature.spectral_rolloff(y=audio, sr=sample_rate))

    # Return the extracted features
    res = {
        "meanfreq": meanfreq,
        "sd": sd,
        "median": median,
        "Q25": Q25,
        "Q75": Q75,
        "IQR": IQR,
        "skew": skewness,
        "kurt": kurtosis,
        "sp.ent": sp_ent,
        "sfm": sfm,
        "mode": mode,
        "centroid": centroid,
        "meanfun": meanfun,
        "minfun": minfun,
        "maxfun": maxfun,
        "meandom": meandom,
        "mindom": mindom,
        "maxdom": maxdom,
        "dfrange": dfrange,
        "modindx": modindx,
    }
    for key, value in res.items():
        if isinstance(value, np.float32):
            res[key] = float(value)
    return res


if __name__ == "__main__":
    folder = "data/clips"
    data = pd.read_csv("data/dev.tsv", sep="\t")
    files = list(data["path"])

    failed = []
    success = {}

    def get(file_name):
        id = file_name
        file_name = os.path.join(folder, file_name + ".mp3")
        try:
            return id, extract_audio_features(file_name)
        except Exception as e:
            return id, str(e)

    with ProcessPoolExecutor(max_workers=30) as executor:
        for file, result in tqdm(
            executor.map(get, files), total=len(files), desc="Extracting features"
        ):
            if isinstance(result, dict):
                success[file] = result
            else:
                failed.append({"file": file, "error": result})
    # for file in tqdm(files, desc="Extracting features"):

    print(f"Failed to extract features from {len(failed)} files")
    print(f"Successfully extracted features from {len(success)} files")

    with open("features.json", "w") as f:
        json.dump(success, f)
    with open("failed.json", "w") as f:
        json.dump(failed, f)
