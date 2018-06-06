========
deepsea
========

Salt formula to deploy DeepSea (software defined storage) framework on GNU Linux.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``deepsea``
------------

Meta-state runs all other states (except packages & remove). Afterwards, consult official DeepSea documentation at <https://github.com/SUSE/DeepSea.git> and <https://www.suse.com/documentation/suse-enterprise-storage-5/singlehtml/book_storage_deployment/book_storage_deployment.html#ses.deployment>

``deepsea.install``
-------------------

Install DeepSea software on GNU Linux. Support git repo (default) or package repo (suse only). Includes `config` and `service` states.

``deepsea.config``
-----------------

Deepsea DEV_ENV=[true|false] support.

``deepsea.services``
-----------------

Enable services needed by DeepSea, and disable services incompatible with DeepSea.

``deepsea.remove``
-----------------

Basic remove state (suse only)

``deepsea.packages``
-----------------

DeepSea should handle its own package dependencies so this state is disabled by default. Set `deepsea:packages:managed: True`  enables package mangement in this formula.



Testing
================

DeepSea deployment verification on GNU Linux: Ubuntu, Centos, and Fedora on python2/3.


Integration with other formulae
===============================

The following formulae pillars could be useful-

`firewalld-formula
      <https://github.com/saltstack-formulas/firewalld-formula>`_

.. code-block:: yaml
     
       - firewalld

    extends:
       firewalld:
         enabled: True
         services:
           saltstack:
             short: salt
             description: SaltStack rules
             ports:
               tcp:
                 - 4505
                 - 4506
           ceph:
             short: ceph
             description: Ceph firewall rules
             ports:
               tcp:
                 - 6789
                 - 6800:6810
         zones:
           public:
             short: Public
             services:
               - http
               - https
               - ssh
               - ntp
               - saltstack
               - ceph

             {%- if grains.os == 'Fedora' %}
           FedoraWorkstation:
             short: FedoraWorkstation
             services:
               - http
               - https
               - ssh
               - ntp
               - saltstack
               - ceph
             {%- endif %}
     
     
`packages-formula
     <https://github.com/saltstack-formulas/packages-formula>`_
     
.. code-block:: bash
     
       - packages

     extends:
       packages:
         # Should this formula manage package dependencies? True means yes. False no.
         # Ideally we let `DeepSea` (or `packages-formula`) manage packages.
         managed: False
         pips:
           wanted:
             - tox
             - click
         pkgs:
           unwanted:
             - unattended-upgrades
           wanted:
             - python-setuptools
             - salt-api
             - git
             - make
                 {% if grains.os_family in ('Debian', 'Suse',) %}
             - python-pip
                 {% elif grains.os_family == 'RedHat' %}
             - python2-pip
             - python-click
             - python-tox
                 {% elif grains.os_family == 'Arch' %}
             - python2-pip
                 {% endif %}

`ceph-formula
     <https://github.com/saltstack-formulas/ceph-formula>`_
     
.. code-block:: bash

       - ceph.repo
     
     extends:
       ceph:
         use_upstream_repo: true

