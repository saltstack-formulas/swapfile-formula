{% from "swapfile/map.jinja" import conf with context %}

{{ conf.swapfile }}:
  cmd.run:
    - name: {{ conf.name }}
    - unless: test -f {{ conf.swapfile }}

{% if grains['os_family'] == 'Debian' %}
  mount.swap:
    - require:
      - cmd: {{ conf.swapfile }}
{% endif %}
