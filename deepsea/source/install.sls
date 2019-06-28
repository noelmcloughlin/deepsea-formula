# -*- coding: utf-8 -*-
# vim: ft=sls

{#- Get the `tplroot` from `tpldir` #}
{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import deepsea with context %}
{%- from tplroot ~ "/jinja/macros.jinja" import format_kwargs with context %}

deepsea-package-source-install-file-directory:
  file.directory:
    - names:
      - {{ deepsea.pkg.source.name }}
      - /etc/salt/master.d
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - require_in:
      - source: deepsea-package-source-install-source-extracted
    - recurse:
        - user
        - group
        - mode
    {%- if deepsea.pkg.deps %}
  pkg.installed:
    - names: {{ deepsea.pkg.deps }}
    - require_in:
      - archive: deepsea-package-source-install-source-extracted
    {%- endif %}

deepsea-package-source-install-source-extracted:
  archive.extracted:
    {{- format_kwargs(deepsea.pkg.source) }}
    - retry:
        attempts: 3
        until: True
        interval: 60
        splay: 10
    - user: root
    - group: root
    - recurse:
        - user
        - group

deepsea-package-source-install-cmd-run-make-install:
  cmd.run:
    - cwd: {{ deepsea.pkg.source.name }}
    - name: make install
    - unless:
      - test -f /usr/local/bin/deepsea
    - require:
      - archive: deepsea-package-source-install-source-extracted
