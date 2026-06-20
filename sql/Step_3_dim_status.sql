SET search_path TO analytics;


CREATE TABLE dim_status (
    status_key INT PRIMARY KEY,
    status_label VARCHAR(20),
    is_terminal BOOLEAN
);


INSERT INTO dim_status (status_key, status_label, is_terminal)
VALUES
    (1, 'new', FALSE),
    (2, 'paid', FALSE),
    (3, 'shipped', FALSE),
    (4, 'delivered', TRUE),
    (5, 'cancelled', TRUE);


ALTER TABLE fct_orders
ADD COLUMN status_key INT;


UPDATE fct_orders
SET status_key =
CASE order_status
    WHEN 'new' THEN 1
    WHEN 'paid' THEN 2
    WHEN 'shipped' THEN 3
    WHEN 'delivered' THEN 4
    WHEN 'cancelled' THEN 5
END;


ALTER TABLE fct_orders
ADD CONSTRAINT fk_fct_status
FOREIGN KEY (status_key)
REFERENCES dim_status(status_key);


ALTER TABLE fct_orders
DROP COLUMN order_status;


SELECT
    pg_size_pretty(pg_total_relation_size('analytics.dim_status')) AS dim_status_size,
    pg_size_pretty(pg_total_relation_size('analytics.fct_orders')) AS fct_orders_size;