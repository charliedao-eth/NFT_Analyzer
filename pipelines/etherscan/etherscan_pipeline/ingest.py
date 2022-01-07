import json
import os
import time

from api import (
    get_ingest_parameters,
    get_transactions,
    get_token_transfers
)


def get_token_collection() -> dict:

    with open("./data/config.json", mode="r", encoding="utf-8") as file:
        config = json.load(file)

    collections = config["collections"]

    return collections


def run_ingest(api_call, label: str):

    collections = get_token_collection()
    batch_size, iteration_limit = get_ingest_parameters()

    start_block = 0

    for collection in collections:

        name = collection["name"]
        address = collection["address"]

        for iteration in range(iteration_limit):

            data = api_call(address, start_block)

            if not os.path.exists(f"./data/{name}/{label}/"):
                os.makedirs(f"./data/{name}/{label}/")

            with open(f"./data/{name}/{label}/{label}_{iteration}.json", mode="w") as file:
                json.dump(data, file)

            blocks = [int(event["blockNumber"]) for event in data]

            if len(blocks) < batch_size:
                break

            start_block = max(blocks)

            time.sleep(0.2)


if __name__ == "__main__":
    run_ingest(get_transactions, "transactions")
    run_ingest(get_token_transfers, "token_transfers")
