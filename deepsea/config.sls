# -*- coding: utf-8 -*-
# vim: ft=yaml

{%- from "deepsea/map.jinja" import deepsea with context %}

deepsea-config-global:
  file.line:
    - name: {{ deepsea.config.global }}
    - mode: ensure
    - indent: True
    - content: DEV_ENV={{ deepsea.config.dev_env }}
    - onlyif: test -f {{ deepsea.config.global }}
