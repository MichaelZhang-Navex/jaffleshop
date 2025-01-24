{{
  config(
    materialized = 'incremental',
    unique_key = 'id',
    )
}}

select 
    id,user_id,tweeted_at,content
from {{ source('ecom', 'raw_tweets') }}
{% if is_incremental() %}
where tweeted_at > (select max(tweeted_at) from {{ this }})
{% endif %}
order by tweeted_at
limit 1000
