-- Timestamp is needed as a workaround for index creation failing every second
-- time (https://github.com/fishtown-analytics/dbt/issues/1945#issuecomment-576714925).
{% macro index(this, column) %}

CREATE INDEX IF NOT EXISTS "{{ this.name }}__index_on_{{ column }}_{{ run_started_at.strftime('%s') }}" ON {{ this }} ("{{ column }}")

{% endmacro %}
