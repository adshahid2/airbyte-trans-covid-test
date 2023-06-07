{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('covidcovid_epidemiology_ab1') }}
select
    cast({{ adapter.quote('date') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('date') }},
    cast(new_recovered as {{ dbt_utils.type_float() }}) as new_recovered,
    cast(new_tested as {{ dbt_utils.type_float() }}) as new_tested,
    cast(total_deceased as {{ dbt_utils.type_float() }}) as total_deceased,
    cast(new_deceased as {{ dbt_utils.type_float() }}) as new_deceased,
    cast(new_confirmed as {{ dbt_utils.type_float() }}) as new_confirmed,
    cast(total_confirmed as {{ dbt_utils.type_float() }}) as total_confirmed,
    cast(total_tested as {{ dbt_utils.type_float() }}) as total_tested,
    cast(total_recovered as {{ dbt_utils.type_float() }}) as total_recovered,
    cast({{ adapter.quote('key') }} as {{ dbt_utils.type_string() }}) as {{ adapter.quote('key') }},
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('covidcovid_epidemiology_ab1') }}
-- covidcovid_epidemiology
where 1 = 1

