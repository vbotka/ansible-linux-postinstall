==========================================
vbotka.linux_postinstall 2.8 Release Notes
==========================================

.. contents:: Topics

2.8.3
=====

Release Summary
---------------
Fix the tarball. Remove and ignore the .ansible directory.


2.8.2
=====

Release Summary
---------------
Maintenance update.

Major Changes
-------------

Minor Changes
-------------
* Update lint configuration.
* Update License years.
* Fix lint errors in contrib/wpa_supplicant
* Add template wpa_supplicant.conf-v4.j2
* Add template wpa_supplicant.conf-v5.j2 sort by SSID
* Fixed role's absolute path.


2.8.1
=====

Release Summary
---------------
Add contrib wpa_supplicant configuration.

Major Changes
-------------

Minor Changes
-------------
* Add contrib/wpa_supplicant
* Add templates/wpa-supplicant.conf-v3.j2
* Add templates/wpa_supplicant.conf-v3.j2
* Add templates/wpa_supplicant.conf-v2.j2

2.8.0
=====

Release Summary
---------------
Ansible 2.20 upgrade.

Major Changes
-------------
* Meta: Update to Ansible 2.20; update platforms.

Minor Changes
-------------
* Convert ansible_* variables to ansible_facts
