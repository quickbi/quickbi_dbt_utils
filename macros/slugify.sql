-- Slugify given column.
--
-- Requires Postgres extension! Run this in psql before using the macro:
--
--     CREATE EXTENSION IF NOT EXISTS unaccent;
--
-- Logic has been copied from
-- https://gist.github.com/abn/779166b0c766ce67351c588489831852.
--
-- 1. trim trailing and leading whitespaces from text
-- 2. remove accents (diacritic signs) from a given text
-- 3. lowercase unaccented text
-- 4. replace non-alphanumeric (excluding hyphen, underscore) with a hyphen
-- 5. trim leading and trailing hyphens
{% macro slugify(col) %}
    trim(
        BOTH '-' FROM regexp_replace(
            lower(
                unaccent(
                    trim({{ col }})
                )
            ),
            '[^a-z0-9\\-_]+',
            '-',
            'gi'
        )
    )
{% endmacro %}
