{% macro get_audit_schema() %}
    {{ return(target.schema ~ '_warehouse_meta') }}
{% endmacro %}
