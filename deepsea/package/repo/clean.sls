# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}

deepsea-package-repo-clean-pkgrepo-absent:
  pkgrepo.absent:
    - name: {{ deepsea.pkg.repo.name }}
