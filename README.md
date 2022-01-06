# NFT Analyzer

NFT Analytics Toolkit for sales, community, and social media insights on NFTs.

## Proposed workflow

1. Collect raw datasets.
2. Transform raw data to satisfy schema constraints.
3. Write analytic function using schema-passing data as input.

The proposed workflow ensures new NFT collection data is compatible with our analytics.

## Input schemas

### Token Owners

| Feature             | Data type  |
| ------------------- | ---------- |
| Token address       | `string`   |
| Token ID            | `string`   |
| Token count         | `number`   |
| Owner address       | `string`   |
| Block number        | `string`   |
| Block number minted | `string`   |
| Contract type       | `string`   |
| Token URI           | `string`   |
| Metadata            | `object`   |
| Synced at           | `string`   |
| Collection name     | `string`   |
| Token symbol        | `string`   |

### Token Ownership

| Feature             | Data type  |
| ------------------- | ---------- |
| Collection name     | `string`   |
| Owner address       | `string`   |
| Token count         | `number`   |

### Token Transactions

| Feature             | Data type  |
| ------------------- | ---------- |
| Token address       | `string`   |
| Token ID            | `string`   |
| Token count         | `number`   |
| Owner address       | `string`   |
| Block number        | `string`   |
| Block number minted | `string`   |
| Contract type       | `string`   |
| Token URI           | `string`   |
| Metadata            | `object`   |
| Synced at           | `string`   |
| Collection name     | `string`   |
| Token symbol        | `string`   |

### Twitter Growth

| Feature             | Data type  |
| ------------------- | ---------- |
| Token address       | `string`   |
| Token ID            | `string`   |
| Token count         | `number`   |
| Owner address       | `string`   |
| Block number        | `string`   |
| Block number minted | `string`   |
| Contract type       | `string`   |
| Token URI           | `string`   |
| Metadata            | `object`   |
| Synced at           | `string`   |
| Collection name     | `string`   |
| Token symbol        | `string`   |

### Twitter Tweets

| Feature             | Data type  |
| ------------------- | ---------- |
| Token address       | `string`   |
| Token ID            | `string`   |
| Token count         | `number`   |
| Owner address       | `string`   |
| Block number        | `string`   |
| Block number minted | `string`   |
| Contract type       | `string`   |
| Token URI           | `string`   |
| Metadata            | `object`   |
| Synced at           | `string`   |
| Collection name     | `string`   |
| Token symbol        | `string`   |