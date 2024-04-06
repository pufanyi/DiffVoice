# Copyright 2020 The HuggingFace Datasets Authors and the current dataset script contributor.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
"""
MIMIC-IT offers a diverse and extensive dataset of 2.8M multimodal instruction-response pairs, designed to enhance the performance of Vision-Language Models (VLMs) in real-life scenarios, enabling VLMs to excel in perception, reasoning, and planning while also catering to a multilingual audience.
"""


import json
import os
import pandas
import base64
import datasets


# Find for instance the citation on arxiv or on the dataset repo/website
_CITATION = """\
@article{li2023mimicit,
    title={MIMIC-IT: Multi-Modal In-Context Instruction Tuning},
    author={Bo Li and Yuanhan Zhang and Liangyu Chen and Jinghao Wang and Fanyi Pu and Jingkang Yang and Chunyuan Li and Ziwei Liu},
    year={2023},
    eprint={2306.05425},
    archivePrefix={arXiv},
    primaryClass={cs.CV}
}
"""

# You can copy an official description
_DESCRIPTION = """\
MIMIC-IT offers a diverse and extensive dataset of 2.8M multimodal instruction-response pairs, designed to enhance the performance of Vision-Language Models (VLMs) in real-life scenarios, enabling VLMs to excel in perception, reasoning, and planning while also catering to a multilingual audience.
"""

_HOMEPAGE = "https://otter-ntu.github.io"

_LICENSE = "MIT"


def get_builder_config(VERSION):
    builder_config = [
        datasets.BuilderConfig(
            name=f"DocVQA",
            version=VERSION,
            description=f"DocVQA",
        )
    ]
    return builder_config


class DiffVoice(datasets.GeneratorBasedBuilder):
    """
    MIMIC-IT offers a diverse and extensive dataset of 2.8M multimodal instruction-response pairs, designed to enhance the performance of Vision-Language Models (VLMs) in real-life scenarios, enabling VLMs to excel in perception, reasoning, and planning while also catering to a multilingual audience.
    MIMIC-IT enables the application of egocentric visual assistant model that can serve that can answer your questions like Hey, Do you think I left my keys on the table?. Harness the power of MIMIC-IT to unlock the full potential of your AI-driven visual assistant and elevate your interactive vision-language tasks to new heights.
    MIMIC-IT provides multilingual instructions, supporting English, Chinese, Korean, Japanese, German, French, Spanish, and Arabic, thereby allowing a larger global audience to altogether enjoy from the convenience brought about by advancements in artificial intelligence.
    """

    VERSION = datasets.Version("1.0.0")

    BUILDER_CONFIGS = get_builder_config(VERSION)

    def _info(self):
        features = datasets.Features(
            {
                # meanfreq,sd,median,Q25,Q75,IQR,skew,kurt,sp.ent,sfm,mode,centroid,meanfun,minfun,maxfun,meandom,mindom,maxdom,dfrange,modindx,sentence,gender,accent,id
                "id": datasets.Value("int32"),
                "meanfreq": datasets.Value("float32"),
                "sd": datasets.Value("float32"),
                "median": datasets.Value("float32"),
                "Q25": datasets.Value("float32"),
                "Q75": datasets.Value("float32"),
                "IQR": datasets.Value("float32"),
                "skew": datasets.Value("float32"),
                "kurt": datasets.Value("float32"),
                "sp.ent": datasets.Value("float32"),
                "sfm": datasets.Value("float32"),
                "mode": datasets.Value("float32"),
                "centroid": datasets.Value("float32"),
                "meanfun": datasets.Value("float32"),
                "minfun": datasets.Value("float32"),
                "maxfun": datasets.Value("float32"),
                "meandom": datasets.Value("float32"),
                "mindom": datasets.Value("float32"),
                "maxdom": datasets.Value("float32"),
                "dfrange": datasets.Value("float32"),
                "modindx": datasets.Value("float32"),
                # "common_voice_id": datasets.Value("string"),
                # "sentence": datasets.Value("string"),
                "gender": datasets.Value("string"),
                "accent": datasets.Value("string"),
            }
        )
        return datasets.DatasetInfo(
            # This is the description that will appear on the datasets page.
            description=_DESCRIPTION,
            # This defines the different columns of the dataset and their types
            features=features,  # Here we define them above because they are different between the two configurations
            # If there's a common (input, target) tuple from the features, uncomment supervised_keys line below and
            # specify them. They'll be used if as_supervised=True in builder.as_dataset.
            # supervised_keys=("sentence", "label"),
            # Homepage of the dataset for documentation
            homepage=_HOMEPAGE,
            # License for the dataset if available
            license=_LICENSE,
            # Citation for the dataset
            citation=_CITATION,
        )

    def _split_generators(self, dl_manager):
        # If several configurations are possible (listed in BUILDER_CONFIGS), the configuration selected by the user is in self.config.name

        # dl_manager is a datasets.download.DownloadManager that can be used to download and extract URLS
        # It can accept any type or nested list/dict and will give back the same structure with the url replaced with path to local files.
        # By default the archives will be extracted and a path to a cached folder where they are extracted is returned instead of the archive
        voice_path = "data/clips"
        test_path = "test.csv"
        train_path = "train.csv"
        val_path = "dev.csv"
        return [
            datasets.SplitGenerator(
                name=datasets.Split.TRAIN,
                gen_kwargs={
                    "filepath": train_path,
                },
            ),
            datasets.SplitGenerator(
                name=datasets.Split.VALIDATION,
                gen_kwargs={
                    "filepath": val_path,
                },
            ),
            datasets.SplitGenerator(
                name=datasets.Split.TEST,
                gen_kwargs={
                    "filepath": test_path,
                },
            ),
        ]

    # method parameters are unpacked from `gen_kwargs` as given in `_split_generators`
    def _generate_examples(self, filepath):
        data = pandas.read_csv(filepath)
        print(data.head())
        for index, row in data.iterrows():
            row = dict(row)
            # row["common_voice_id"] = row["id"]
            row["id"] = index
            del row["sentence"]
            yield index, row
