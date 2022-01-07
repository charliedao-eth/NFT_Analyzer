import json
import requests


MAX_BLOCK = 999999999

def get_api_details() -> tuple:

    with open("./data/config.json", mode="r", encoding="utf-8") as file:
        config = json.load(file)

    api_url = config["api"]["url"]
    api_key = config["api"]["key"]

    return api_url, api_key


def get_ingest_parameters() -> tuple:

    with open("./data/config.json", mode="r", encoding="utf-8") as file:
        config = json.load(file)

    batch_size = config["parameters"]["batch_size"]
    iteration_limit = config["parameters"]["iteration_limit"]

    return batch_size, iteration_limit


def get_transactions(
    address: str,
    start_block: int = 0,
    end_block: int = MAX_BLOCK,
    page: int = 1
) -> dict:

    api_url, api_key = get_api_details()
    batch_size, _ = get_ingest_parameters()

    parameters = {
        "module": "account",
        "action": "txlist",
        "address": address,
        "startblock": start_block,
        "endblock": end_block,
        "page": page,
        "offset": batch_size,
        "sort": "asc",
        "apikey": api_key
    }

    response = requests.get(
        url=api_url,
        params=parameters
    ).json()["result"]

    return response


def get_token_transfers(
    address: str,
    start_block: int = 0,
    end_block: int = MAX_BLOCK,
    page: int = 1
) -> dict:

    api_url, api_key = get_api_details()
    batch_size, _ = get_ingest_parameters()

    parameters = {
        "module": "account",
        "action": "tokennfttx",
        "contractaddress": address,
        "startblock": start_block,
        "endblock": end_block,
        "page": page,
        "offset": batch_size,
        "sort": "asc",
        "apikey": api_key
    }

    response = requests.get(
        url=api_url,
        params=parameters
    ).json()["result"]

    return response
