==========================================
vbotka.linux_postinstall 2.5 Release Notes
==========================================

.. contents:: Topics


2.5.0
=====

Release Summary
---------------
Update meta Ansible 2.15. Add support for Ubuntu 23.04(Lunar) and
23.10(Mantic). Update gnupg.

Major Changes
-------------
* Update gpg. Unify configuration and templates.

Minor Changes
-------------
* update docs.

Bugfixes
--------

Breaking Changes / Porting Guide
--------------------------------
* Unify gnupg configuration in lp_gpg_conf and template
  gpg.conf.j2. Removed templates: gpg-agent.conf.j2,
  gpg-dirmngr.conf.j2. Add variable: lp_gpg_conf_template
