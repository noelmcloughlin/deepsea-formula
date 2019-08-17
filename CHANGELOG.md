# Changelog

# [0.3.0](https://github.com/saltstack-formulas/deepsea-formula/compare/v0.2.1...v0.3.0) (2019-08-17)


### Features

* **yamllint:** include for this repo and apply rules throughout ([e9c195f](https://github.com/saltstack-formulas/deepsea-formula/commit/e9c195f))

## [0.2.1](https://github.com/saltstack-formulas/deepsea-formula/compare/v0.2.0...v0.2.1) (2019-07-31)


### Bug Fixes

* **archlinux:** no python rados package; fix requisite ([2212491](https://github.com/saltstack-formulas/deepsea-formula/commit/2212491))
* **jinja:** json filter & use upstream makefile ([76ce0fc](https://github.com/saltstack-formulas/deepsea-formula/commit/76ce0fc))

# [0.2.0](https://github.com/saltstack-formulas/deepsea-formula/compare/v0.1.0...v0.2.0) (2019-07-08)


### Bug Fixes

* **deps:** ensure make is installed ([969f2b1](https://github.com/saltstack-formulas/deepsea-formula/commit/969f2b1))
* **deps:** skip python-boto package on Cent/Suse ([06158d3](https://github.com/saltstack-formulas/deepsea-formula/commit/06158d3))
* **example:** fix pillar.example version ([486f07d](https://github.com/saltstack-formulas/deepsea-formula/commit/486f07d))
* **gemfile:** use latest net-ssh gem ([07f4a75](https://github.com/saltstack-formulas/deepsea-formula/commit/07f4a75))
* **jinja:** pass dict as yaml to jinja renderer ([8464691](https://github.com/saltstack-formulas/deepsea-formula/commit/8464691))
* **makefile:** fix makefile cut+paste issue ([2676182](https://github.com/saltstack-formulas/deepsea-formula/commit/2676182))
* **map:** need osfingermap for debian ([c86f76a](https://github.com/saltstack-formulas/deepsea-formula/commit/c86f76a))
* **map:** update os mappings for centos/fedora ([5bd353b](https://github.com/saltstack-formulas/deepsea-formula/commit/5bd353b))
* **packages:** corrected dependency packages & user:group ([20b6c31](https://github.com/saltstack-formulas/deepsea-formula/commit/20b6c31))
* **python:** avoid downgrade to python2 ([d3e9f03](https://github.com/saltstack-formulas/deepsea-formula/commit/d3e9f03))
* **redhat:** correct python rados package; update kitchen ([905d85b](https://github.com/saltstack-formulas/deepsea-formula/commit/905d85b))
* **source:** fixes for building from source ([5f7ba72](https://github.com/saltstack-formulas/deepsea-formula/commit/5f7ba72))
* **travis:** use newer image and ruby ([6786612](https://github.com/saltstack-formulas/deepsea-formula/commit/6786612))


### Code Refactoring

* **jinja:** tidyup indention on jinja rendering ([86211e0](https://github.com/saltstack-formulas/deepsea-formula/commit/86211e0))


### Documentation

* **contribs:** update contributing.rst ([d005fb0](https://github.com/saltstack-formulas/deepsea-formula/commit/d005fb0))
* **readme:** add FreeBSD to readme ([96e275a](https://github.com/saltstack-formulas/deepsea-formula/commit/96e275a))
* **readme:** note basic post-formula integration ([b4bb933](https://github.com/saltstack-formulas/deepsea-formula/commit/b4bb933))


### Features

* **integration:** update ceph release-name & packages ([2db3acc](https://github.com/saltstack-formulas/deepsea-formula/commit/2db3acc))
* **template:** migrate to template-formula v3.0.0 ([4d9e571](https://github.com/saltstack-formulas/deepsea-formula/commit/4d9e571))


### Tests

* **matrix:** use opensuse15 (no py3 on cent6) ([26b126f](https://github.com/saltstack-formulas/deepsea-formula/commit/26b126f))
* **travis:** trigger new job ([f271ba3](https://github.com/saltstack-formulas/deepsea-formula/commit/f271ba3))
* **travis:** update .travis.yml adding "dist: xenial" ([3035ab7](https://github.com/saltstack-formulas/deepsea-formula/commit/3035ab7))
