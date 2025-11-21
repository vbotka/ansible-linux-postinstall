==========================================
vbotka.linux_postinstall 2.7 Release Notes
==========================================

.. contents:: Topics


2.7.2
=====

Release Summary
---------------
Maintenance update

Major Changes
-------------

Minor Changes
-------------


2.7.1
=====

Release Summary
---------------
Update Ansible 2.20

Major Changes
-------------

Minor Changes
-------------
* Update tasks/networkmanager; test masked services.
* Update tasks/sysctl; create /etc/sysctl.conf if missing.
* Update tasks/service; add var lp_service_debug2 (default=false);
  remove resolvconf, udev, and speechd services from auto.


2.7.0
=====

Release Summary
---------------
Update Ansible 2.19

Major Changes
-------------

Minor Changes
-------------
* Updated documentation. Updated annotation templates.
* Add template wpa-supplicant.conf-v2.j2; Use tab instead of spaces.

Bugfixes
--------

Breaking Changes / Porting Guide
--------------------------------
Use ansible core 2.19.4 or higher for critical bug-fixes.
