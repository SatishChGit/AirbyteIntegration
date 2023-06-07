{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    tags = [ "top-level-intermediate" ]
) }}
select
    CAST (_airbyte_data.JSONExtract('$.id')  AS VARCHAR(200))  as id,
    CAST (_airbyte_data.JSONExtract('$.login')   AS VARCHAR(200)) as username,
     CAST (_airbyte_data.JSONExtract('$.node_id')    AS VARCHAR(200))  as nodeid,
     CAST (_airbyte_data.JSONExtract('$.avatar_url')  AS VARCHAR(200)) as avatarurl,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('airbyte_dbt_docker', '_airbyte_raw_assignees') }} as table_alias
-- data_stream
where 1 = 1