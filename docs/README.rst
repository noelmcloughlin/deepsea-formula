.. _readme:

deepsea-formula
===============

|img_travis| |img_sr|

.. |img_travis| image:: https://travis-ci.com/saltstack-formulas/deepsea-formula.svg?branch=master
   :alt: Travis CI Build Status
   :scale: 100%
   :target: https://travis-ci.com/saltstack-formulas/deepsea-formula
.. |img_sr| image:: https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg
   :alt: Semantic Release
   :scale: 100%
   :target: https://github.com/semantic-release/semantic-release

Salt formula to deploy DeepSea (software defined storage) framework on GNU Linux.

.. contents:: **Table of Contents**

General notes
-------------

See the full `SaltStack Formulas installation and usage instructions
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

If you are interested in writing or contributing to formulas, please pay attention to the `Writing Formula Section
<https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#writing-formulas>`_.

If you want to use this formula, please pay attention to the ``FORMULA`` file and/or ``git tag``,
which contains the currently released version. This formula is versioned according to `Semantic Versioning <http://semver.org/>`_.

See `Formula Versioning Section <https://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html#versioning>`_ for more details.

Contributing to this repo
-------------------------

**Commit message formatting is significant!!**

Please see :ref:`How to contribute <CONTRIBUTING>` for more details.

Available states
----------------

.. contents::
   :local:

``deepsea``
^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

This installs the deepsea package,
manages the deepsea configuration file and then
starts the associated deepsea service.

``deepsea.package``
^^^^^^^^^^^^^^^^^^^

This state will install the deepsea package only.

``deepsea.package.repo``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will install the deepsea package repository.

``deepsea.source``
^^^^^^^^^^^^^^^^^^

This state will install deepsea from source only.

``deepsea.config``
^^^^^^^^^^^^^^^^^^

This state configures deepsea defaults and depends on ``deepsea.install``
via include list.

``deepsea.service``
^^^^^^^^^^^^^^^^^^^

This state will start the deepsea service and has a dependency on ``deepsea.config``
via include list.

``deepsea.clean``
^^^^^^^^^^^^^^^^^

*Meta-state (This is a state that includes other states)*.

this state will undo everything performed in the ``deepsea`` meta-state in reverse order, i.e.
stops the service,
removes the configuration file and
then uninstalls the package.

``deepsea.service.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will stop the deepsea service and disable it at boot time.

``deepsea.config.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the configuration of the deepsea service and has a
dependency on ``deepsea.service.clean`` via include list.

``deepsea.package.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the deepsea package and has a depency on

``deepsea.package.repo.clean``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the deepsea package repository.

``deepsea.source.clean``
^^^^^^^^^^^^^^^^^^^^^^^^

This state will remove the deepsea package and has a depency on
``deepsea.config.clean`` via include list.

DeepSea Integration
-------------------

See official documentation at https://github.com/SUSE/DeepSea/blob/master/README.md

For example on Ubuntu 18.04-

.. code-block:: bash

        root@ubuntu1804:~# salt-run state.orch ceph.stage.0
        
        [WARNING ] All minions are ready
        ubuntu1804.localdomain_master:
          Name: crc_method master - Function: salt.state - Result: Changed Started: - 17:52:31.051226 Duration: 361.594 ms
          Name: sync master - Function: salt.state - Result: Changed Started: - 17:52:31.412976 Duration: 1028.128 ms
          Name: salt-api - Function: salt.state - Result: Changed Started: - 17:52:32.441213 Duration: 5332.9 ms
          Name: repo master - Function: salt.state - Result: Clean Started: - 17:52:37.774260 Duration: 355.654 ms
          Name: metapackage master - Function: salt.state - Result: Clean Started: - 17:52:38.130062 Duration: 416.05 ms
          Name: prepare master - Function: salt.state - Result: Changed Started: - 17:52:38.546320 Duration: 298157.407 ms
          Name: filequeue.remove - Function: salt.runner - Result: Changed Started: - 17:57:36.704571 Duration: 5699.659 ms
          Name: filequeue.enqueue - Function: salt.runner - Result: Changed Started: - 17:57:42.404364 Duration: 227.791 ms
          Name: minions.ready - Function: salt.runner - Result: Changed Started: - 17:57:42.632279 Duration: 429.608 ms
          Name: crc_method minion - Function: salt.state - Result: Changed Started: - 17:57:43.062130 Duration: 1479.336 ms
          Name: set apparmor - Function: salt.state - Result: Changed Started: - 17:57:44.541611 Duration: 9515.847 ms
          Name: repo - Function: salt.state - Result: Clean Started: - 17:57:54.057601 Duration: 328.778 ms
          Name: metapackage minions - Function: salt.state - Result: Clean Started: - 17:57:54.386546 Duration: 408.039 ms
          Name: common packages - Function: salt.state - Result: Changed Started: - 17:57:54.794863 Duration: 100374.387 ms
          Name: sync - Function: salt.state - Result: Changed Started: - 17:59:35.169364 Duration: 1385.293 ms
          Name: mines - Function: salt.state - Result: Changed Started: - 17:59:36.554764 Duration: 382.213 ms
          Name: updates - Function: salt.state - Result: Clean Started: - 17:59:36.937185 Duration: 26453.162 ms
          Name: No Ceph cluster - Function: test.nop - Result: Clean Started: - 18:00:03.390498 Duration: 0.368 ms
        
        Summary for ubuntu1804.localdomain_master
        -------------
        Succeeded: 18 (changed=12)
        Failed:     0
        -------------
        Total states run:     18
        Total run time:  452.336 s


        root@ubuntu1804:~# salt-run state.orch ceph.stage.1

        [WARNING ] All minions are ready
        ubuntu1804.localdomain_master:
          Name: minions.ready - Function: salt.runner - Result: Changed Started: - 18:08:30.748189 Duration: 380.759 ms
          Name: refresh_pillar0 - Function: salt.state - Result: Changed Started: - 18:08:31.129184 Duration: 283.682 ms
          Name: populate.proposals - Function: salt.runner - Result: Changed Started: - 18:08:31.413219 Duration: 2859.894 ms
        
        Summary for ubuntu1804.localdomain_master
        ------------
        Succeeded: 3 (changed=3)
        Failed:    0
        ------------
        Total states run:     3
        Total run time:   3.524 s
        
        root@ubuntu1804:~# curl -o /srv/pillar/ceph/proposals/policy.cfg https://raw.githubusercontent.com/SUSE/DeepSea/master/doc/examples/policy.cfg-rolebased
        root@ubuntu1804:~# vi /srv/pillar/ceph/proposals/policy.cfg
        root@ubuntu1804:~# vi /srv/pillar/ceph/proposals/config/stack/default/ceph/cluster.yml


        root@ubuntu1804:~# salt-run state.orch ceph.stage.2

        [WARNING ] role-ubuntu1804.localdomain/cluster/ubuntu1804.localdomain*.sls matched no files
        [WARNING ] role-mon/cluster/mon*.sls matched no files
        [WARNING ] role-mgr/cluster/mon*.sls matched no files
        [WARNING ] role-mds/cluster/mds*.sls matched no files
        [WARNING ] role-igw/cluster/igw*.sls matched no files
        [WARNING ] role-rgw/cluster/rgw*.sls matched no files
        [WARNING ] role-ganesha/cluster/ganesha*.sls matched no files
        [WARNING ] role-storage/cluster/data*.sls matched no files
        deepsea_minions          : valid
        yaml_syntax              : valid
        [WARNING ] role-ubuntu1804.localdomain/cluster/ubuntu1804.localdomain*.sls matched no files
        [WARNING ] role-mon/cluster/mon*.sls matched no files
        [WARNING ] role-mgr/cluster/mon*.sls matched no files
        [WARNING ] role-mds/cluster/mds*.sls matched no files
        [WARNING ] role-igw/cluster/igw*.sls matched no files
        [WARNING ] role-rgw/cluster/rgw*.sls matched no files
        [WARNING ] role-ganesha/cluster/ganesha*.sls matched no files
        [WARNING ] role-storage/cluster/data*.sls matched no files
        public network           : 192.168.1.0/24
        cluster network          : 10.0.2.0/24
        ubuntu1804.localdomain_master:
          Name: push.proposal - Function: salt.runner - Result: Changed Started: - 18:16:31.747204 Duration: 251.938 ms
          Name: refresh_pillar1 - Function: salt.state - Result: Changed Started: - 18:16:31.999265 Duration: 278.968 ms
          Name: advise.networks - Function: salt.runner - Result: Changed Started: - 18:16:32.278340 Duration: 553.336 ms
          Name: install ceph packages - Function: salt.state - Result: Clean Started: - 18:16:32.831855 Duration: 4164.183 ms
          Name: admin key - Function: salt.state - Result: Changed Started: - 18:16:36.996254 Duration: 421.106 ms
          Name: osd key - Function: salt.state - Result: Changed Started: - 18:16:37.417542 Duration: 434.585 ms
          Name: mon key - Function: salt.state - Result: Changed Started: - 18:16:37.852339 Duration: 455.217 ms
        ----------
                  ID: mgr key
            Function: salt.state
              Result: False
             Comment: Run failed on minions: ubuntu1804.localdomain
             Started: 18:16:38.307711
            Duration: 465.578 ms
             Changes:   
                      ubuntu1804.localdomain:
                          Data failed to compile:
                      ----------
                          Rendering SLS 'base:ceph.mgr.key.default' failed: Jinja error: 'select.minions'
                      KeyError: 'select.minions'
                      
                      ; line 5
                      
                      ---
                      prevent empty rendering:
                        test.nop:
                          - name: skip
                      
                      {% for host in salt.saltutil.runner('select.minions', cluster='ceph', roles='mgr', host=True) %}    <======================
                      {% set client = "mgr." + host %}
                      {% set keyring_file = salt['keyring.file']('mgr', host)  %}
                      {{ keyring_file}}:
                        file.managed:
                          - source:
                      [...]
                      ---
        
        Summary for ubuntu1804.localdomain_master
        ------------
        Succeeded: 7 (changed=6)
        Failed:    1
        ------------
        Total states run:     8
        Total run time:   7.025 s
        
        

Testing
-------

Linux testing is done with ``kitchen-salt``.

Requirements
^^^^^^^^^^^^

* Ruby
* Docker

.. code-block:: bash

   $ gem install bundler
   $ bundle install
   $ bin/kitchen test [platform]

Where ``[platform]`` is the platform name defined in ``kitchen.yml``,
e.g. ``debian-9-2019-2-py3``.

``bin/kitchen converge``
^^^^^^^^^^^^^^^^^^^^^^^^

Creates the docker instance and runs the ``deepsea`` main state, ready for testing.

``bin/kitchen verify``
^^^^^^^^^^^^^^^^^^^^^^

Runs the ``inspec`` tests on the actual instance.

``bin/kitchen destroy``
^^^^^^^^^^^^^^^^^^^^^^^

Removes the docker instance.

``bin/kitchen test``
^^^^^^^^^^^^^^^^^^^^

Runs all of the stages above in one go: i.e. ``destroy`` + ``converge`` + ``verify`` + ``destroy``.

``bin/kitchen login``
^^^^^^^^^^^^^^^^^^^^^

Gives you SSH access to the instance for manual testing.

