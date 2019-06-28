# -*- coding: utf-8 -*-
# vim: ft=sls
{% from "deepsea/map.jinja" import deepsea with context %}

     {%- for svc in deepsea.services.running %}
deepsea-{{ svc }}-running:
  service.running:
    - name: {{ svc }}
    - enable: True
     {% endfor %}

     {%- for svc in deepsea.services.dead %}
deepsea-{{ svc }}-notrunning:
  service.dead:
    - name: {{ svc }}
    - enable: False
     {% endfor %}
