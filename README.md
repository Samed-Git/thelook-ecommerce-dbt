# TheLook E-commerce Analytics Engineering Project

An analytics engineering project built with **dbt** and **Google BigQuery**, using the public **TheLook eCommerce** dataset. The project transforms raw e-commerce data into clean staging models and structured analytical models for customers, products, and orders.

## Project Overview

The goal of this project is to demonstrate an analytics engineering workflow: declaring source data, transforming it with modular SQL models, organizing the resulting data into staging and marts layers, and adding data quality tests and model documentation.

## Tech Stack

- **dbt Core / dbt Cloud** — data transformation and model management
- **Google BigQuery** — cloud data warehouse
- **SQL** — data cleaning, transformation, joins, aggregations, and business logic
- **YAML** — source definitions, model documentation, and tests

## Data Source

The project uses the public `thelook_ecommerce` dataset in the `bigquery-public-data` project.

Source tables:
- `orders`
- `order_items`
- `products`
- `users`

## Project Structure

```text
models/
├── staging/
│   └── thelook_ecommerce/
│       ├── _thelook__sources.yml
│       ├── _thelook__models.yml
│       ├── stg_thelook_ecommerce__orders.sql
│       ├── stg_thelook_ecommerce__order_items.sql
│       ├── stg_thelook_ecommerce__products.sql
│       └── stg_thelook_ecommerce__users.sql
└── marts/
    ├── core/
    │   ├── dim_users.sql
    │   ├── dim_users.yml
    │   ├── fct_orders.sql
    │   └── fct_orders.yml
    └── products/
        ├── dim_products.sql
        └── dim_products.yml
```

## Transformation Layers

### 1. Staging

The staging models select from the declared BigQuery sources and prepare the raw data for downstream use. Transformations include:

- Renaming source fields to consistent, descriptive names.
- Trimming text fields and standardizing selected values.
- Converting empty strings to `NULL`.
- Casting timestamp fields and rounding monetary values.
- Separating customer, order, product, and order-item attributes into individual models.

Staging models:
- `stg_thelook_ecommerce__users`
- `stg_thelook_ecommerce__orders`
- `stg_thelook_ecommerce__products`
- `stg_thelook_ecommerce__order_items`

### 2. Marts

The marts layer combines and enriches staging data to create models that are easier to use for analysis.

| Model | Description |
|---|---|
| `dim_users` | Customer dimension with customer details, age groups, and monthly signup cohorts. |
| `dim_products` | Product dimension with unit profit, profit margin percentage, price tiers, and a profitability flag. |
| `fct_orders` | Order-level fact model with item counts, order amounts, shipping and delivery durations, and return status. |

## Data Quality and Documentation

YAML files are used to document models and define data tests. The current project includes:

- `unique` and `not_null` tests for selected primary-key fields.
- Tests for the order identifier in the `fct_orders` model.
- Column-level metadata and descriptions for the fact model.

## Running the Project

1. Clone this repository:
   ```bash
   git clone https://github.com/Samed-Git/thelook-ecommerce-dbt.git
   cd thelook-ecommerce-dbt
   ```

2. Install the dbt packages:
   ```bash
   dbt deps
   ```

3. Configure your BigQuery connection in your local dbt profile (`profiles.yml`) using your own credentials.

4. Build the models and run the configured tests:
   ```bash
   dbt build
   ```

> A working BigQuery connection and a correctly configured dbt profile are required to run the project. Do not commit credentials or private service-account keys to the repository.

## Repository

[View the project on GitHub](https://github.com/Samed-Git/thelook-ecommerce-dbt)
