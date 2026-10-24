==========================================
vbotka.linux_postinstall 2.9 Release Notes
==========================================

.. contents:: Topics

2.9.0
=====

Release Summary
---------------
Ansible 2.21 upgrade.

Major Changes
-------------
* Meta: Ansible 2.21; update platforms.
* Modules ansible.builtin.apt_* replaced by ansible.builtin.deb822_repository
* Remove variable lp_virtualbox_keys

Minor Changes
-------------
* Remove .ansible-lint.local
* Docs. Add sphinx_rtd_dark_mode and coppybutton.
* Docs. Update Quick Start Guide. Add Index to main menu.

Breaking Changes / Porting Guide
--------------------------------
* Modules ansible.builtin.apt_repository and ansible.builtin.apt_key replaced by
  ansible.builtin.get_url, ansible.builtin.copy, and
  ansible.builtin.deb822_repository. See vars/samples/repos.yml.sample.
* Variable lp_virtualbox_keys removed. Use lp_repos_keys instead.
