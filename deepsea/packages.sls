# -*- coding: utf-8 -*-
# vim: ft=yaml

{% from "deepsea/map.jinja" import deepsea with context -%}

deepsea-packages-common-dependencies:
  pkg.installed:
    - pkgs:
      - make
      {% for pkg in deepsea.packages.required %}
      - {{ pkg }}
      {% endfor %}
