{% macro cast_text_to_date(text_column) %}
    {# Check the format of the date string before casting to date

    Supports date strings in the following formats:
        - 'YYYY-MM-DD' => '2022-07-25'
        - 'DD.MM.YYYY' => '25.07.2022', ('1.7.2022' also works)
    Unsupported strings are converted to null

    example usage:
        select
            {{ cast_text_to_date('start_date_string') }} as start_date
        from
            my_table
    #}

    case
        when trim(both from {{ text_column }}) ~ '^\d{4}-(0\d|1[012])-([012]\d|3[01])$'
        then {{ text_column }}::date
        when trim(both from {{ text_column }}) ~ '^([012]?\d|3[01]).(0?\d|1[012]).\d{4}$'
        then to_date({{ text_column }}, 'DD.MM.YYYY')
        else null
    end
{% endmacro %}
