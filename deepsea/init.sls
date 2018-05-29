# -*- coding: utf-8 -*-
# vim: ft=yaml

{% from "deepsea/map.jinja" import deepsea with context -%}

deepsea-user-group:
  group.present:
    - name: {{ deepsea.group }}
    - system: True
  user.present:
    - name: {{ deepsea.user }}
    - groups:
      - {{ deepsea.group }}
    - system: True
    - require:
      - group: deepsea-user-group
    - require_in:
      - pkg: deepsea-requirements

deepsea-requirements:
   {% if not deepsea.packages.formula %}
  pkg.installed:
    - pkgs: {{ deepsea.packages.required }}
    - require_in:
      - file: deepsea-requirements
   {% endif %}
  file.managed:
    names:
     -  /etc/salt/master.d
     - {{ deepsea.tmpdir }}
    mode: 0755
    user: {{ deepsea.user }}
    group: {{ deepsea.group }}
    recurse:
      - user
      - group
      - mode

deepsea-installation:
   {% if deepsea.use_upstream_pkgrepo %}
  pkg.installed:
    - pkgs: {{ deepsea.packages.required }}
   {% else %}
  git.latest:
    - name: {{ deepsea.repo.giturl }}
    - target: {{ deepsea.tmpdir }}/DeepSea
    - rev: {{ deepsea.repo.get('git_rev', 'master') }}
    - force_checkout: True
    - force_clone: True
    - force_fetch: True
    - force_reset: True
   {% endif %}
    - require:
      - pkg: deepsea-requirements

