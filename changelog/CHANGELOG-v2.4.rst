==========================================
vbotka.linux_postinstall 2.4 Release Notes
==========================================

.. contents:: Topics


2.4.10
======

Release Summary
---------------
Update docs and README.

Minor changes
-------------
* Update README
* Update docs guide-task-packages


2.4.9
=====

Release Summary
---------------
Update docs. Update tasks packages. Import install_package.yml from
vbotka.linux_lib.

Minor changes
-------------
* Update tasks packages
* Update tasks passwords local installation of packages.
* Update tasks which install packages. Import install_package.yml from
  vbotka.linux_lib
* Add dynamic variables in defaults/main/packages.yml
* Add debug to tasks. Add variables lp_*_debug to defaults
* Remove tasks: packages_auto.yml, fn/install-package.yml,
  fn/remove-package.yml
* Update annotated source service.yml
* Update docs tasks packages.


2.4.8
=====

Release Summary
---------------
Update debug and docs.

Minor changes
-------------
* Add variables: +lp_service_all, lp_services_all
* Debug; add Jinja template for lp_service_all and lp_services_all
* Update docs. Section debug.


2.4.7
=====

Release Summary
---------------
Update loop labels. Unify service management.

Minor changes
-------------
* Update loop labels.
* Unify service start/stop and enable/disable.
* Update apparmor.


2.4.6
=====

Release Summary
---------------
Add lp_<service_name>_state; Update docs.

Minor changes
-------------

* Add lp_<service_name>_state
* Update docs
* Update README
* Update vars/samples


2.4.5
=====

Release Summary
---------------
Update docs.


2.4.4
=====

Release Summary
---------------
Update docs, defaults, vars. Fixes.

Minor changes
-------------
* Update docs. Services, annotation lists, annotation service.yml,
  guide service.
* Update lp_smart_* defaults and vars.
* Fix tags in 'service: Flush handlers'

2.4.3
=====

Release Summary
---------------
Rename lp_service_enable to lp_service_auto


2.4.2
=====

Release Summary
---------------
Update tasks/service.yml; Require collection ansible.utils; Add changelog. Fixes.

Minor changes
-------------
* Add changelog.
* Update service.yml

  * Update automatic and manual management of listed services
  * Add sanity. Test lp_service names are defined,
    lp_service_enable items are defined, and valid lp_service_module
  * Add variables: lp_service_module, lp_service_module_valid; Add
    dynamic variables: my_services_all, my_services_regex,
    my_services_alias, my_services_names, my_services_undef
  * Default lp_smart_state=stopped; lp_udev_state=started;
  * Rename variable lp_udev_enable_module to lp_udev_module (default
    service)
  * Add handler reexec systemd daemon
  
Bugfixes
-------
* Fix default lp_udev_debug2|d(false)|bool


2.4.1
=====

Release Summary
---------------
Add .readthedocs.yaml


2.4.0
=====

Release Summary
---------------
Update meta Ansible 2.14; OS versions and License. Remove
.yamllint. Add support for Ubuntu 22.04 (Jammy).

Major Changes
-------------
* Add variable lp_smart_install (default: false)
* Add variable lp_sysctl_extra_space
* Apply tags lp_*_packages on importing fn/install-package.yml. Add
  missing variables lp_*_install.
* In chrony, end of host if fails. Flush handlers. Add variables
  lp_swap_flush_handlers, lp_swap_*
* In chrony, rescue end of the host if not ansible_check_mode;
  clear_host_errors
* In swap, end of host if fails. Flush handlers. Add sanity. Add
  variables lp_swap_sanity, lp_swap_f$
* No network-manager.service in Jammy
* Run timesyncd before chrony. Crony will fail if timesyncd not
  disabled.
* Update Ansible 2.14, meta, license
* Update LaTeX packages and reference.
* Update autofs block/rescue, end of host if fails. Install
  package. Flush handlers.
* Update chrony debug.
* Update docs. Centos support commented.
* Update lp_packages_auto. Install list. Formatting debug.
* Update packages block/rescue. Add variable
  lp_packages_rescue_end_host (default=true).
* Update postfix block/rescue, end of host if fails. Install
  package. Flush handlers. Add variables $
* Update sphinx_rtd_theme and guzzle_sphinx_theme
* Update vars Ubuntu-focal and add Ubuntu-jammy

Minor Changes
-------------
* Update README
* Formatting: gpg, grub debug, handlers, main.yml, groups, modules,
  sysctl
* Debug udev. Add debug2. udev not idempotent #75542. Add Note.
* Debug packages, repos, ufw, zfs. Add missing variables

Bugfixes
-------
* lp_gpsd_install
* lp_udev_debug2|d(false)|bool
* postfix debug.
* gpg. Create directories .gnupg
* lp_packages_auto  ansible.builtin.varnames
* packages_auto local_pkg_lists. Formatting packages_auto debug.
* README
* create /etc/bluetooth/rfcomm.conf if missing.
* gpg handlers.
* lp_ufw_packages and lp_chrony_service
* router1-iptables.j2; Rename lp_iptables_INPUT_if to lp_iptables_input_if
* systemd tags.
* ufw for Centos. Tested OK
* ansible.builtin.command; formatting.

Breaking Changes / Porting Guide
--------------------------------
