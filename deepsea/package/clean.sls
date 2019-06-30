# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_config_clean = tplroot ~ '.config.clean' %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}

include:
  - {{ sls_config_clean }}
    {%- if deepsea.pkg.use_upstream_repo %}
  - .repo.clean
    {%- endif %}

    {%- if deepsea.pkg.deps %}

deepsea-package-install-deps-pkg-removed:
  pkg.removed:
    - names: {{ deepsea.pkg.deps }}

    {%- endif %}

deepsea-package-clean-pkg-removed:
  pkg.removed:
    - name: {{ deepsea.pkg.name }}
    - require:
      - sls: {{ sls_config_clean }}
