{{ config(materialized='table') }}

SELECT
    oi.order_item_id,
    o.order_id,
    o.customer_id,
    oi.product_id,
    o.ordered_on,
    o.status,
    oi.quantity,
    oi.unit_price_usd,
    oi.line_revenue

FROM {{ ref('stg_orders') }} AS o

JOIN {{ ref('stg_order_items') }} AS oi
    ON o.order_id = oi.order_id