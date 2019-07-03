# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}

  {%- if deepsea.service.dead %}

deepsea-service-dead-service-dead:
  service.dead:
    - names: {{ deepsea.service.dead }}
    - enable: False
    - onlyif: systemctl list-unit-files | grep {{ deepsea.service.name }} >/dev/null 2>&1

  {%- endif %}
