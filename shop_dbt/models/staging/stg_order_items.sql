WITH source AS (

    SELECT *
    FROM {{ source('raw', 'order_item') }}

),

renamed AS (

    SELECT
        order_item_id,
        order_id,
        product_id,
        quantity,

        unit_price_at_sale::NUMERIC(12,2) AS unit_price_usd,

        quantity * unit_price_at_sale::NUMERIC(12,2) AS line_revenue

    FROM source
    WHERE quantity > 0

)

SELECT *
FROM renamed