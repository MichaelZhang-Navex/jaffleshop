{{
  config(
    materialized = 'incremental',
    unique_key = 'id',
    )
}}

select 
    id,customer,ordered_at,store_id,subtotal,tax_paid,order_total
from {{ source('ecom', 'raw_orders') }}
{% if is_incremental() %}
where ordered_at > (select max(ordered_at) from {{ this }})
{% endif %}
order by ordered_at
limit 1000
