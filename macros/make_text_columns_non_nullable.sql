{% macro make_text_columns_non_nullable(table) %}
    {% call statement('columns', fetch_result=True) %}

        SELECT column_name
        FROM information_schema.columns
        WHERE
            table_name = '{{ table.name }}' AND
            table_schema = '{{ schema }}' AND
            data_type IN ('text', 'character varying');

    {% endcall %}

    {% set columns = load_result('columns')['data'] %}

    {% if columns %}
        UPDATE {{ table }} SET
        {%- for col in columns %}
            {{ col[0] }} = coalesce({{ col[0] }}, '')
            {%- if not loop.last %},{% endif -%}
        {% endfor  %}
        ;
    {% endif %}

    {%- for col in columns  -%}
        ALTER TABLE {{ table }} ALTER COLUMN {{ col[0] }} SET NOT NULL;
    {% endfor -%}
{% endmacro %}
