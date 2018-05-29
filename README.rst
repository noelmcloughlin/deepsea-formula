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

Install DeepSea software on GNU Linux. Support git repo (default) or package repo (suse only). Includes the `config` state.

Afterwards, consult the DeepSea documentation at <https://github.com/SUSE/DeepSea.git> and <https://www.suse.com/documentation/suse-enterprise-storage-5/singlehtml/book_storage_deployment/book_storage_deployment.html#ses.deployment>

``deepsea.config``
-----------------

Deepsea DEV_ENV=[true|false] support.

``deepsea.remove``
-----------------

Basic remove state (suse only)



Testing
================

Verified on GNU Linux: Ubuntu, Centos, and Fedora with python2.

