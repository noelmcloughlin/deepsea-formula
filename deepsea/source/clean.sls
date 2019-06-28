# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}

    {%- if deepsea.pkg.deps %}

deepsea-package-source-clean-deps-pkg-absent:
  pkg.absent:
    - names: {{ deepsea.pkg.deps }}
    - require_in:
      - archive: deepsea-package-source-install-source-extracted

    {%- endif %}

deepsea-package-source-clean-file-absent:
  file.absent:
    - names:
      - {{ deepsea.pkg.source.name }}
