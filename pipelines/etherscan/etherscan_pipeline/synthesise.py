import json
import os

import pandas as pd

from api import get_transactions
from ingest import get_token_collection


MAX_ATTEMPTS = 10


def get_schemas() -> dict:

    with open("./data/config.json", mode="r", encoding="utf-8") as file:
        config = json.load(file)

    schemas = config["schemas"]

    return schemas


def read_responses(dataset: str, name: str) -> pd.DataFrame:

    json_list = []
    for file_name in os.listdir(f'./data/{name}/{dataset}/'):
        with open(f'./data/{name}/{dataset}/{file_name}') as file:
            json_list += json.load(file)

    data = pd.DataFrame(json_list)

    return data


def persist_data(data: pd.DataFrame, collection: str, label: str):

    data.to_parquet(
        f'./data/{collection}/{label}.parquet',
        engine="pyarrow",

    )
    data.to_csv(
        f'./data/{collection}/{label}.csv',
        index=False
    )


def clean_data():

    collections = get_token_collection()
    datasets = get_schemas().keys()

    for collection in collections:

        name = collection["name"]

        for dataset in datasets:

            data = read_responses(dataset, name)
            persist_data(data, name, dataset)


def join_data():

    collections = get_token_collection()

    for collection in collections:

        name = collection["name"]

        token_transfers = pd.read_parquet(
            f'./data/{name}/token_transfers.parquet',
            engine="pyarrow"
        )

        transactions = pd.read_parquet(
            f'./data/{name}/transactions.parquet',
            engine="pyarrow"
        )

        data = token_transfers.merge(
            transactions,
            on="hash",
            how="left"
        )

        persist_data(data, name, "data")


def pull_data():

    collections = get_token_collection()

    for collection in collections:

        name = collection["name"]

        data = pd.read_parquet(
            f'./data/{name}/data.parquet',
            engine="pyarrow"
        )

        transaction_block_hashes = data[[
            "to_x",
            "hash",
            "blockHash_x",
            "blockHash_y"
        ]]

        missing_transaction_blocks = transaction_block_hashes[
            transaction_block_hashes["blockHash_y"].isna()
        ][["to_x", "hash", "blockHash_x"]]

        missing_transactions = pd.DataFrame()

        for index, row in missing_transaction_blocks.iterrows():

            for attempt in range(MAX_ATTEMPTS):

                missing_transaction = pd.DataFrame(
                    get_transactions(
                        row["to_x"],
                        row["blockHash_x"],
                        row["blockHash_x"],
                        page=attempt+1
                    )
                )

                if missing_transaction.shape[0] == 0:
                    break

                missing_transaction = missing_transaction[
                    missing_transaction["hash"] == row["hash"]
                ]

                if missing_transaction.shape[0] > 0:
                    break

            if missing_transaction.shape[0] > 0:

                missing_transactions = missing_transactions.append(
                    pd.DataFrame(missing_transaction)
                )

                persist_data(
                    missing_transactions,
                    name,
                    f"missing_transactions/transactions_{index}"
                )

        data = data.merge(
            missing_transactions,
            on="hash",
            how="left"
        )

        persist_data(data, name, "data_synthesised")


if __name__ == "__main__":

    clean_data()
    join_data()
    pull_data()
