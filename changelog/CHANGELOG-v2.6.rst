==========================================
vbotka.linux_postinstall 2.6 Release Notes
==========================================

.. contents:: Topics


2.6.2
=====

Release Summary
---------------
Maintenance and bugfix release including docs update.

Major Changes
-------------
* Run service.yml last before reboot.
* Update lists lp_service_all and lp_service_auto.
* Default lp_ufw_enable changed to false.
* Default lp_netplan_mode: "0600" removed from vars.
* Update udev task, handlers, lp_udev_* defaults and vars. 

Minor Changes
-------------
* Bump docs version.
* Update docs.
* Update README.
* Add default my_date=`date +"%b %d %T"` in template wpa-action.sh.j2
* Deprecated ansible.netcommon changed to ansible.utils.ipaddr
* Update ansible-lint, travis, and readthedoc configurations.
* Add distro facts to udev debug.

Bugfixes
--------
* Fix lp_udev_module variable.

Breaking Changes / Porting Guide
--------------------------------
* vars/defaults.incr/Debian.yml moved to vars/defaults.incr/Ubuntu.yml


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
