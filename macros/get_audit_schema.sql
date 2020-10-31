-- Set schema name for package "fishtown-analytics/logging"
-- (https://github.com/fishtown-analytics/dbt-event-logging).
--
-- Note that in the main dbt package there needs to be a macro like this:
--
-- {% macro get_audit_schema() %}
--     {{ return(quickbi_dbt_utils.get_audit_schema()) }}
-- {% endmacro %}
{% macro get_audit_schema() %}
    {{ return(target.schema ~ '_warehouse_meta') }}
{% endmacro %}
