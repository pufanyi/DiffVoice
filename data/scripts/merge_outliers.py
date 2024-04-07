import os
import argsparse
import pandas as pd
from typing import Set


def get_outliers(file: str) -> Set[int]:
    df = pd.read_csv(file).squeeze()
    return set(list(df))

if __name__ == "__main__":
    argsparser = argparse.ArgumentParser()
    argsparser.add_argument("--folder", "-f", type=str, required=True, help="Folder containing the outliers files")
    args = argsparser.parse_args()
    outlier_files = [f for f in os.listdir(args.folder) if f.endswith(".csv")]
    
