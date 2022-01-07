# NFT Analyzer

NFT Analytics Toolkit for sales, community, and social media insights on NFTs.

## Proposed workflow

1. Collect raw datasets.
2. Transform raw data to satisfy schema constraints.
3. Write analytic function using schema-passing data as input.

The proposed workflow ensures new NFT collection data is compatible with our analytics.

## Input schemas

### Tokens

| Feature                | Data type | Variable name      |
| ---------------------- | --------- | ------------------ |
| Token collection name  | `string`  | `collection_name`  |
| Token contract address | `string`  | `contract_address` |
| Token ID               | `string`  | `token_id`         |
| Token symbol           | `string`  | `token_symbol`     |
| Token URI              | `string`  | `token_uri`        |
| Token metadata         | `object`  | `token_metadata`   |
| Contract type          | `string`  | `contract_type`    |
| Block number minted    | `string`  | `block_minted`     |

### Token owners

| Feature                | Data type | Variable name      |
| -------------------    | --------- | ------------------ |
| Token contract address | `string`  | `contract_address` |
| Token ID               | `string`  | `token_id`         |
| Owner address          | `string`  | `owner_address`    |
| Ownership timestamp    | `string`  | `owned_at`         |

### Token transactions

| Feature               | Data type | Variable name      |
| --------------------- | --------- | ------------------ |
| Timestamp             | `string`  | `timestamp`        |
| Block number          | `string`  | `block_number`     |
| Hash                  | `string`  | `hash`             |
| Nonce                 | `string`  | `nonce`            |
| Contract address      | `string`  | `contract_address` |
| From address          | `string`  | `from_address`     |
| To address            | `string`  | `to_address`       |
| Token collection name | `string`  | `collection_name`  |
| Token ID              | `string`  | `token_id`         |
| Value                 | `number`  | `value`            |
| Gas amount            | `number`  | `gas`              |
| Gas unit rate         | `number`  | `gas_rate`         |
| Gas used              | `number`  | `gas_used`         |
| Cumulative gas used   | `number`  | `gas_total`        |
| Confirmation count    | `number`  | `confirmations`    |

### Twitter growth

| Feature         | Data type  | Variable name  |
| --------------- | ---------- | -------------- |
| Account name    | `string`   | `account_name` |
| Date            | `string`   | `date`         |
| Follower count  | `number`   | `followers`    |
| Following count | `number`   | `following`    |
| Tweet count     | `number`   | `tweets`       |
| Favourite count | `number`   | `favourites`   |

### Twitter tweets

| Feature         | Data type  | Variable name  |
| --------------- | ---------- | -------------- |
| Account name    | `string`   | `account_name` |
| Time stamp      | `string`   | `timestamp`    |
| Tweet content   | `string`   | `content`      |
| Favourite count | `number`   | `favourites`   |
| Retweet count   | `number`   | `retweets`     |
| Like count      | `number`   | `likes`        |
