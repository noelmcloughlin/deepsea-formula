# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- set sls_source_install = tplroot ~ '.source.install' %}
{%- set sls_package_install = tplroot ~ '.package.install' %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}
{%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_source_install if deepsea.pkg.use_upstream_source else sls_package_install }}

deepsea-config-file-file-managed-environ_file:
  file.managed:
    - name: {{ deepsea.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='deepsea-config-file-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: root
    - group: {{ deepsea.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ deepsea.environ|yaml }}
    - require:
      - sls: {{ sls_source_install if deepsea.pkg.use_upstream_source else sls_package_install }}
