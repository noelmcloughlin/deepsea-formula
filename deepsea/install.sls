# -*- coding: utf-8 -*-
# vim: ft=yaml

{% from "deepsea/map.jinja" import deepsea with context -%}

include:
  - deepsea.config
  - deepsea.service
   {% if deepsea.packages.managed %}
  - deepsea.packages
   {% endif %}

deepsea-directories:
  file.directory:
    - names:
       - /etc/salt/master.d
       - {{ deepsea.tmpdir }}
    - force: True
    - mode: 0755
    - user: {{ deepsea.user }}
    - group: {{ deepsea.group }}
    - recurse:
       - user
       - group
       - mode

deepsea-software:
   {% if deepsea.use_upstream_pkgrepo %}
        {# using upstream pkgrepo #}
  pkgrepo.managed:
    - name: deepsea-{{ deepsea.release }}
    - humanname: {{ deepsea.repo.name }}
    - baseurl: {{ deepsea.repo.base_url }}
    - key_url: {{ deepsea.repo.key_url }}
    - gpgcheck: 1
    - gpgautoimport: True
    - require:
      - file: deepsea-directories
  pkg.installed:
    - pkgs: {{ deepsea.packages.required }}
    - require:
      - pkgrepo: deepsea-software
   {% else %}
        {# using gitrepo not upstream pkgrepo #}
  pkgrepo.absent:
    - name: deepsea-{{ deepsea.release }}
    - require_in:
      - file: deepsea-software
  file.absent:
    - name: {{ deepsea.tmpdir }}/DeepSea
    - require_in:
      - git: deepsea-software
  git.latest:
    - name: {{ deepsea.repo.git_url }}
    - target: {{ deepsea.tmpdir }}/DeepSea
    - rev: {{ deepsea.repo.get('git_rev', 'master') }}
    - force_checkout: True
    - force_clone: True
    - force_fetch: True
    - force_reset: True
    - require_in:
      - cmd: deepsea-software
  cmd.run:
    - name: make install
    - cwd: {{ deepsea.tmpdir }}/DeepSea
   {% endif %}
    - require:
      - file: deepsea-directories
      - pkgrepo: deepsea-software
    - require_in:
      - file: deepsea-config-global
