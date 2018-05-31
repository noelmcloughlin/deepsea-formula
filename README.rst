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

Meta-state runs all other states (except remove).

Afterwards, consult official DeepSea documentation at <https://github.com/SUSE/DeepSea.git> and <https://www.suse.com/documentation/suse-enterprise-storage-5/singlehtml/book_storage_deployment/book_storage_deployment.html#ses.deployment>

``install``

Install DeepSea software on GNU Linux. Support git repo (default) or package repo (suse only). Includes the `config` and `service` states.

``deepsea.config``
-----------------

Deepsea DEV_ENV=[true|false] support.

``deepsea.services``
-----------------

Enable services needed by DeepSea, and disable services incompatible with DeepSea.

``deepsea.remove``
-----------------

Basic remove state (suse only)



Testing
================

DeepSea deployment verification on GNU Linux: Ubuntu, Centos, and Fedora with python2.  TODO: DeepSea runtime verification (ensure deepsea commands work).


Integration with other salt formulae
===============================

The following formulae pillars support DeepSea-

- `firewalld-formula
<https://github.com/saltstack-formulas/firewalld-formula>`_

.. code-block:: yaml

extends:
  firewalld:
    services:
      deepsea-formula:
        short: deepsea
        description: DeepSea firewall rules
        ports:
          tcp:
            - 4505
            - 4506 
          udp:
            - 4505
            - 4506
    zones:
      public:
        services:
          - deepsea


- `packages-formula
<https://github.com/saltstack-formulas/packages-formula>`_

.. code-block:: bash

extends:
  packages:
    pips:
      wanted:
        - tox
        - click
    pkgs:
      unwanted:
        - unattended-upgrades    {# recommendation #}
      wanted:
        - python-setuptools
        - salt-api      
        - git
        - make
     {% if grains.os_family == 'Debian' %}
        - python-pip
     {% elif grains.os_family == 'RedHat' %}
        - python2-pip
        - python-click
        - python-tox
    {% elif grains.os_family == 'Suse' %}
        - python-pip
    {% elif grains.os_family == 'Arch' %}
        - python2-pip
    {% endif %}


