import os
import argparse
import pandas as pd
from typing import Set


def get_outliers(file: str) -> Set[int]:
    df = pd.read_csv(file).squeeze()
    return set(list(df))

if __name__ == "__main__":
    argsparser = argparse.ArgumentParser()
    argsparser.add_argument("--input", "-i", type=str, required=True, help="Folder containing the outliers files")
    argsparser.add_argument("--output", "-o", type=str, help="Output file to save the merged outliers", default="./outliers/outliers.csv")
    args = argsparser.parse_args()
    outlier_files = [f for f in os.listdir(args.input) if f.endswith(".csv")]
    outliers = set()
    for file in outlier_files:
        outliers.update(get_outliers(os.path.join(args.input, file)))
    output_base_folder = os.path.dirname(args.output)
    os.makedirs(output_base_folder, exist_ok=True)
    pd.Series(sorted(list(outliers))).to_csv(args.output, index=False)
    print(f"Outliers merged and saved in {args.output}")
