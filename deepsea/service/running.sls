# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}

deepsea-service-running-service-unmasked:
  service.unmasked:
    - name: {{ deepsea.service.name }}
    - onlyif: systemctl list-unit-files | grep {{ deepsea.service.name }} >/dev/null 2>&1

deepsea-service-running-service-running:
  service.running:
    - name: {{ deepsea.service.name }}
    - enable: True
    - onlyif: systemctl list-unit-files | grep {{ deepsea.service.name }} >/dev/null 2>&1
