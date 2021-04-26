{% macro cast_text_to_date(text_column) %}
    {# Check that date string is in proper format (YYYY-MM-DD) before casting to date

    Example usage:
        SELECT
            {{ cast_text_to_date('mt.aloitus_pvm') }} AS aloitus_pvm
        FROM
            my_table AS mt
    #}

    CASE
        WHEN trim(both from {{ text_column }}) ~ '^\d{4}-(0\d|1[012])-([012]\d|3[01])$'
        THEN {{ text_column }}::DATE
        ELSE NULL
    END
{% endmacro %}
