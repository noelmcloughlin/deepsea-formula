# -*- coding: utf-8 -*-
# vim: ft=yaml

{%- from "deepsea/map.jinja" import deepsea with context %}

deepsea-cleanup:
  file.absent:
    name: {{ deepsea.tmpdir }}
  pkgrepo.absent:
    name: deepsea-{{ deepsea.release }}
    - gpgautoimport: True
  pkg.purged:
    - pkgs: {{ deepsea.packages.required }}

