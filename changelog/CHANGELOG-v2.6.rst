==========================================
vbotka.linux_postinstall 2.6 Release Notes
==========================================

.. contents:: Topics


2.6.2
=====

Release Summary
---------------
Ansible 2.17 maintenance and bugfix release including docs update.

Major Changes
-------------
* Run service.yml last before reboot.
* Update lists lp_service_all and lp_service_auto.
* Default lp_ufw_enable changed to false.
* Default lp_netplan_mode: "0600" removed from vars.
* Update udev task, handlers, lp_udev_* defaults and vars.
* Add Ubuntu 24.04 Noble vars.
* Requires collection: +ansible.utils

Minor Changes
-------------
* Bump docs version.
* Update docs.
* Update README.
* Add default my_date=`date +"%b %d %T"` in template wpa-action.sh.j2
* Add distro facts to tasks debug.
* Add templates udev-rules-lists.j2 and udev-rules-strings.j2
* Add default lp_udev_debug2=false
* Add docs: guide-task-wpagui, guide-tasks/wpasupplicant-ex2
* Add contrib: wpa_ctl
* Update ansible-lint, travis, and readthedoc configurations.
* Update tasks acpi. Job type 'reload' not available for service acpid.
* Update timesyncd. Add variables lp_timesyncd_*. By default,
  lp_timesyncd_service doesn't have to exist
  (lp_timesyncd_service_exists_fatal=false). By default, create backup
  of original conf (lp_timesyncd_conf_file_orig=true). Update
  template.
* Update tasks: service, rc-local, repos, resolvconf, sysctl, wpasupplicant
* Update defaults: wpasupplicant,
* Update vars: defaults.incr/Ubuntu-noble.yml
* Update vars: defaults/Ubuntu-noble.yml
* Update docs: introduction, installation, wpasupplicant, netplan-ex2,
  wpasupplicant-ex1
* Update templates: wpa-action.sh
* Formatting of tasks and handlers
* Deprecated ansible.netcommon changed to ansible.utils.ipaddr
* Deprecated ansible.builtin.systemd changed to ansible.builtin.systemd_service
* Remove variable my_dev from wpasupplicant.

Bugfixes
--------
* Fix handler 'reconfigure wpasupplicant'. Add default dictionary
  lp_wpasupplicant_service_change
* Fix lp_udev_module variable.
* Fix docs indexes and formatting.

Breaking Changes / Porting Guide
--------------------------------
* vars/defaults.incr/Debian.yml moved to vars/defaults.incr/Ubuntu.yml
* Update task networkmanager. Use systemd_service to mask services


2.6.1
=====

Release Summary
---------------
Update acpi. Update service.

Major Changes
-------------
* Add acpi handlers
* Add defaults acpi.yml. Add vars lp_acpi_*
* Run service.yml last before reboot.
* Update lists lp_service_all and lp_service_auto

Minor Changes
-------------
* Update debug.yml
* Update packages.yml
* Add debug in vars_incremental.yml
* Update docs version 2.6.1


2.6.0
=====

Release Summary
---------------
Update Ansible 2.16

Major Changes
-------------

Minor Changes
-------------
* Bump docs 2.6.0
* Update docs requirements readthedocs-sphinx-search==0.3.2

Bugfixes
--------

Breaking Changes / Porting Guide
--------------------------------
