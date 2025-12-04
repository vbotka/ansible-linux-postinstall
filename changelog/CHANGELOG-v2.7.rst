==========================================
vbotka.linux_postinstall 2.7 Release Notes
==========================================

.. contents:: Topics


2.7.3
=====

Release Summary
---------------
Update tasks/sysctl incl. docs.

Major Changes
-------------

Minor Changes
-------------
* Update tasks/sysctl; configure /etc/sysctl.d; added handler "Load
  sysctl system" and template sysctl-conf.j2
* Update docs.


2.7.2
=====

Release Summary
---------------
Docs update.

Major Changes
-------------

Minor Changes
-------------
* Docs update version release in index.rst
* Docs build also epub and pdf.


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
