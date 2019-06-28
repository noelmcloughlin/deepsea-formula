# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}
{%- set sls_source_clean = tplroot ~ '.source.clean' %}
{%- set sls_package_clean = tplroot ~ '.package.clean' %}
{%- set sls_service_clean = tplroot ~ '.service.clean' %}

include:
  - {{ sls_service_clean }}
  - {{ sls_source_clean if deepsea.pkg.use_upstream_source else sls_package_clean }}

deepsea-config-clean-file-absent:
  file.absent:
    - names:
      - {{ deepsea.environ_file }}
    - require:
      - sls: {{ sls_service_clean }}
      - sls: {{ sls_source_clean if deepsea.pkg.use_upstream_source else sls_package_clean }}
