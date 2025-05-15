{{
  config(
    materialized = 'incremental',
    unique_key = 'order_item_id',
    on_schema_change = 'sync_all_columns',
    merge_exclude_columns = ['created_at'],
    )
}}


with source as (select * from {{ source('ecom', 'raw_items') }}),

renamed as (
    select
        id as order_item_id,
        order_id,
        sku as product_id,
        'dbt' as update_by,
        dateadd(
            day,
            uniform(0, datediff(day, '2025-01-01', '2025-05-01'), random()),
            to_date('2025-01-01')
        ) as created_at,
        current_timestamp() as updated_at

    from source
)

select * from
    renamed
    {% if is_incremental() %}
        sample (1)
    {% endif %}
