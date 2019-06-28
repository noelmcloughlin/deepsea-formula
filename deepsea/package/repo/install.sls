# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}

  {%- if deepsea.pkg.use_upstream_repo %}
      {%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

deepsea-package-repo-install-pkgrepo-managed:
  pkgrepo.managed:
    {{- format_kwargs(deepsea.pkg.repo) }}

  {%- endif %}
