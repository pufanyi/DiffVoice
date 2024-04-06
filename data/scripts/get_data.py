from datasets import load_dataset

if __name__ == "__main__":
    dataset_name = "pufanyi/DiffVoice"
    dataset = load_dataset(dataset_name, cache_dir=".cache")

    train_dataset = dataset["train"]
    test_dataset = dataset["test"]
    val_dataset = dataset["validation"]

    train_dataset.to_csv("train.csv")
    test_dataset.to_csv("test.csv")
    val_dataset.to_csv("val.csv")
