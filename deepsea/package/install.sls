# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}
 
    {%- if deepsea.pkg.use_upstream_repo %}
include:
  - .repo
    {%- endif %}

      {%- if deepsea.pkg.deps %}

deepsea-package-install-deps-pkg-installed:
  pkg.installed:
    - names: {{ deepsea.pkg.deps|json }}

      {%- endif %}

deepsea-package-install-pkg-installed:
  pkg.installed:
    - name: {{ deepsea.pkg.name }}
