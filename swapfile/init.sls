{% from "swapfile/map.jinja" import conf with context %}

{{ conf.swapfile }}:
  file.append:
    - name: /etc/fstab
    - text: |
        {{ conf.fstab }}
  cmd.run:
    - name: {{ conf.name }}
    - unless: test -f {{ conf.swapfile }}
    - require:
      - file: {{ conf.swapfile }}
{% if grains['os_family'] == 'Debian' %}
  mount.swap:
    - require:
      - cmd: {{ conf.swapfile }}
{% endif %}
