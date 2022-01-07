# NFT Analyzer

NFT Analytics Toolkit for sales, community, and social media insights on NFTs.

## Proposed workflow

1. Collect raw datasets.
2. Transform raw data to satisfy schema constraints.
3. Write analytic function using schema-passing data as input.

The proposed workflow ensures new NFT collection data is compatible with our analytics.

## Input schemas

### Tokens

| Feature                | Data type | Variable name      | Keyable |
| ---------------------- | --------- | ------------------ | ------- |
| Token collection name  | `string`  | `collection_name`  | Yes     |
| Token contract address | `string`  | `contract_address` | Yes     |
| Token ID               | `string`  | `token_id`         | Yes     |
| Token symbol           | `string`  | `token_symbol`     |         |
| Token URI              | `string`  | `token_uri`        |         |
| Token metadata         | `object`  | `token_metadata`   |         |
| Contract type          | `string`  | `contract_type`    |         |
| Block number minted    | `string`  | `block_minted`     | Yes     |

### Token owners

| Feature                | Data type | Variable name      | Keyable |
| -------------------    | --------- | ------------------ | ------- |
| Token contract address | `string`  | `contract_address` | Yes     |
| Token ID               | `string`  | `token_id`         | Yes     |
| Owner address          | `string`  | `owner_address`    | Yes     |
| Ownership timestamp    | `string`  | `owned_at`         |         |

### Token transactions

| Feature               | Data type | Variable name      | Keyable |
| --------------------- | --------- | ------------------ | ------- |
| Timestamp             | `string`  | `timestamp`        |         |
| Block number          | `string`  | `block_number`     | Yes     |
| Hash                  | `string`  | `hash`             | Yes     |
| Nonce                 | `string`  | `nonce`            |         |
| Contract address      | `string`  | `contract_address` | Yes     |
| From address          | `string`  | `from_address`     | Yes     |
| To address            | `string`  | `to_address`       | Yes     |
| Token collection name | `string`  | `collection_name`  | Yes     |
| Token ID              | `string`  | `token_id`         | Yes     |
| Value                 | `number`  | `value`            |         |
| Gas amount            | `number`  | `gas`              |         |
| Gas unit rate         | `number`  | `gas_rate`         |         |
| Gas used              | `number`  | `gas_used`         |         |
| Cumulative gas used   | `number`  | `gas_total`        |         |
| Confirmation count    | `number`  | `confirmations`    |         |

### Twitter growth

| Feature         | Data type  | Variable name  | Keyable |
| --------------- | ---------- | -------------- | ------- |
| Account name    | `string`   | `account_name` | Yes     |
| Date            | `string`   | `date`         |         |
| Follower count  | `number`   | `followers`    |         |
| Following count | `number`   | `following`    |         |
| Tweet count     | `number`   | `tweets`       |         |
| Favourite count | `number`   | `favourites`   |         |

### Twitter tweets

| Feature         | Data type  | Variable name  | Keyable |
| --------------- | ---------- | -------------- | ------- |
| Account name    | `string`   | `account_name` | Yes     |
| Time stamp      | `string`   | `timestamp`    |         |
| Tweet content   | `string`   | `content`      |         |
| Favourite count | `number`   | `favourites`   |         |
| Retweet count   | `number`   | `retweets`     |         |
| Like count      | `number`   | `likes`        |         |
