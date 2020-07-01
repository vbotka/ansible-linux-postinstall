.. _ug:

############
User's guide
############
.. contents:: Table of Contents
   :depth: 4


.. _ug_introduction:

************
Introduction
************

* Ansible role: `linux_postinstall <https://galaxy.ansible.com/vbotka/linux_postinstall/>`_
* Supported systems: `Ubuntu <http://releases.ubuntu.com/>`_
* Requirements: `ansible_lib <https://galaxy.ansible.com/vbotka/ansible_lib>`_

  <TBD>


.. _ug_installation:

************
Installation
************

The most convenient way how to install an Ansible role is to use
Ansible Galaxy CLI ``ansible-galaxy``. The utility comes with the
standard Ansible package and provides the user with a simple interface
to the Ansible Galaxy's services. For example, take a look at the
current status of the role

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-galaxy info vbotka.linux_postinstall

and install it

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-galaxy install vbotka.linux_postinstall

Install the library of tasks

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-galaxy install vbotka.ansible_lib

.. seealso::
   * To install specific versions from various sources see `Installing content <https://galaxy.ansible.com/docs/using/installing.html>`_.
   * Take a look at other roles ``shell> ansible-galaxy search --author=vbotka``


.. _ug_playbook:

********
Playbook
********

Below is a simple playbook that calls this role at a single host
srv.example.com (2)

.. code-block:: bash
   :emphasize-lines: 1
   :linenos:

   shell> cat linux-postinstall.yml
   - hosts: srv.example.com
     gather_facts: true
     connection: ssh
     remote_user: admin
     become: yes
     become_user: root
     become_method: sudo
     roles:
       - vbotka.linux_postinstall

.. note:: ``gather_facts: true`` (3) must be set to gather facts
          needed to evaluate OS-specific options of the role. For
          example to install packages the variable ``ansible_os_family``
          is needed to select the appropriate Ansible module.

.. seealso::
   * For details see `Connection Plugins <https://docs.ansible.com/ansible/latest/plugins/connection.html>`__ (4-5)
   * See also `Understanding Privilege Escalation <https://docs.ansible.com/ansible/latest/user_guide/become.html#understanding-privilege-escalation>`__ (6-8)


.. _ug_debug:

*****
Debug
*****

To see additional debug information enable debug output in the
configuration

.. code-block:: yaml
   :emphasize-lines: 1

   lp_debug: true

, or set the extra variable in the command

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux_postinstall.yml -e 'lp_debug=true'

.. note:: The debug output of this role is optimized for the **yaml**
   callback plugin. Set this plugin for example in the environment
   ``shell> export ANSIBLE_STDOUT_CALLBACK=yaml``.

.. seealso:: * `Playbook Debugger <https://docs.ansible.com/ansible/latest/user_guide/playbooks_debugger.html>`_


.. _ug_tags:

****
Tags
****

The tags provide the user with a very useful tool to run selected
tasks of the role. To see what tags are available list the tags of the
role with the command

.. code-block:: bash
   :emphasize-lines: 1

    shell> ansible-playbook linux-postinstall.yml --list-tags

    playbook: linux-postinstall.yml

    play #1 (srv.example.com): srv.example.com TAGS: []
    TASK TAGS: [always, lp_acpi, lp_acpi_actions, lp_acpi_events, lp_aliases,
    apparmor, lp_apparmor_disable, lp_apparmor_enforce, lp_apparmor_packages,
    lp_apparmor_profiles, lp_apparmor_service, lp_authorized_keys, lp_auto_upgrades,
    lp_autofs, lp_bluetooth, lp_cron, lp_cron_tab, lp_cron_var, lp_debsums,
    lp_debsums_debug, lp_debsums_default_conf, lp_debsums_ignore_conf,
    lp_debsums_packages, lp_debug, lp_fstab, lp_gpg, lp_gpsd, lp_gpsd_bt_rfcom,
    lp_gpsd_config, lp_gpsd_group, lp_gpsd_packages, lp_gpsd_service, lp_grub,
    lp_hostname, lp_hosts, lp_iptables, lp_kvm, lp_kvm_packages, lp_latex,
    lp_latex_dir, lp_latex_labels, lp_latex_macros, lp_latex_packages, lp_libvirt,
    lp_libvirt_conf, lp_libvirt_debug, lp_libvirt_guests_service,
    lp_libvirt_libvirtd_service, lp_libvirt_pkg, lp_lid, lp_logrotate, lp_modemmanager,
    lp_modules, lp_netplan, lp_nfsd, lp_nfsd_exports, lp_nfsd_packages, lp_nfsd_service,
    lp_packages, lp_packages_auto, lp_packages_install, lp_packages_remove,
    lp_packages_selections_postinstall, lp_packages_selections_preinstall,
    lp_passwords, lp_pm, lp_postfix, lp_postfix_conf, lp_postfix_service, lp_reboot,
    lp_repos, lp_repos_keys_manage, lp_repos_manage, lp_resolvconf,
    lp_resolvconf_confd_head, lp_resolvconf_debug, lp_resolvconf_packages,
    lp_resolvconf_service, lp_service, lp_service_auto, lp_service_debug,
    lp_service_general, lp_smart, lp_smart_conf, lp_smart_packages, lp_smart_service,
    lp_speechd, lp_ssh, lp_sshd, lp_sshd_config, lp_sshd_service, lp_sudoers, lp_swap,
    lp_swap_fstab, lp_swap_swapfile, lp_sysctl, lp_timesyncd, lp_timesyncd_conf,
    lp_timesyncd_debug, lp_timesyncd_service, lp_timezone, lp_tlp, lp_tlp_conf,
    lp_tlp_packages, lp_tlp_service, lp_udev, lp_udev_service, lp_ufw, lp_ufw_conf,
    lp_ufw_debug, lp_ufw_packages, lp_ufw_reload, lp_ufw_reset, lp_ufw_service,
    lp_users, lp_vars, lp_virtualbox, lp_virtualbox_keys, lp_virtualbox_pkg,
    lp_virtualbox_repos, lp_virtualbox_services, lp_wpa_action_script_dir,
    lp_wpa_action_script_file, lp_wpagui, lp_wpagui_disableNM, lp_wpagui_mask_NM,
    lp_wpagui_packages, lp_wpasupplicant, lp_wpasupplicant_conf, lp_wpasupplicant_debug,
    lp_wpasupplicant_packages, lp_xen, lp_xen_default_grub, lp_xen_global,
    lp_xen_packages, lp_xorg, lp_xorg_conf, lp_zeitgeist, lp_zfs, lp_zfs_debug,
    lp_zfs_manage, lp_zfs_mountpoints, lp_zfs_packages]

For example, display the list of the variables and their values with
the tag ``lp_debug`` (when the debug is enabled ``lp_debug: true``)

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux_postinstall.yml -t lp_debug

See what packages will be installed

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux_postinstall -t lp_packages --check

Install packages and exit the play

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux_postinstall.yml -t lp_packages


.. _ug_tasks:

*****
Tasks
*****

.. _ug_task_passwords:
.. include:: task-passwords.rst

.. toctree::

   task-passwords-passwordstore
   task-passwords-passwordstore-ex1
   task-passwords-passwordstore-ex2
   task-passwords-passwordstore-ex3

.. _ug_task_passwords_passwordstore:
.. include:: task-passwords-passwordstore.rst
	     
.. _ug_task_passwords_passwordstore_ex1:
.. include:: task-passwords-passwordstore-ex1.rst

.. _ug_task_passwords_passwordstore_ex2:
.. include:: task-passwords-passwordstore-ex2.rst

.. _ug_task_passwords_passwordstore_ex3:
.. include:: task-passwords-passwordstore-ex3.rst


.. _ug_vars:

*********
Variables
*********

In this chapter we describe role's default variables stored in the
directory **defaults**.

.. seealso:: * `Ansible variable precedence: Where should I put a variable? <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable>`_


.. _ug_defaults:

*****************
Default variables
*****************

  <TBD>

[`defaults/main.yml <https://github.com/vbotka/ansible-linux-postinstall/blob/master/defaults/main.yml>`_]

.. highlight:: yaml
    :linenothreshold: 5
.. literalinclude:: ../../defaults/main.yml
    :language: yaml
    :emphasize-lines: 2
    :linenos:

.. warning:: Default value of **lp_passwords_debug_classified** and
   **lp_wpasupplicant_debug_classified** is **False**. Passwords will be
   displayed if these variables are enabled.


.. _ug_bp:

*************
Best practice
*************

Display the variables for debug if needed. Then disable this task
``lp_debug: false`` to speedup the playbook

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_debug

Install packages automatically. Then disable this task
``lp_packages_auto: false`` to speedup the playbook

.. code-block:: sh
   :emphasize-lines: 1-2

   shell> ansible-playbook linux-postinstall.yml -t cl_packages \
                                                 -e 'lp_packages_auto=true'

The role and the configuration data in the examples are
idempotent. Once the installation and configuration have passed there
should be no changes reported by *ansible-playbook* when running the
playbook repeatedly. Disable debug, and install to speedup the
playbook

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux-postinstall.yml
