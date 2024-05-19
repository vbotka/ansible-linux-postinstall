==========================================
vbotka.linux_postinstall 2.6 Release Notes
==========================================

.. contents:: Topics


2.6.2
=====

Release Summary
---------------
Update service.

Major Changes
-------------
* Run service.yml last before reboot.
* Update lists lp_service_all and lp_service_auto.
* Default lp_ufw_enable changed to false.
* Default lp_netplan_mode: "0600" removed from vars.

Minor Changes
-------------
* Bump docs version.
* Update docs.
* Update README.
* Add default my_date=`date +"%b %d %T"` in template wpa-action.sh.j2
* Deprecated ansible.netcommon changed to ansible.utils.ipaddr


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
