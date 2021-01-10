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


.. _ug_installation:

************
Installation
************

The most convenient way how to install an Ansible role is to use
:index:`Ansible Galaxy` CLI ``ansible-galaxy``. The utility comes with the
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

Below is a simple playbook that calls this role (10) at a single host
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
   needed to evaluate :index:`OS-specific options` of the role. For example, to
   install packages, the variable ``ansible_os_family`` is needed to
   select the appropriate Ansible module.

.. seealso::
   * For details see `Connection Plugins <https://docs.ansible.com/ansible/latest/plugins/connection.html>`__ (4-5)
   * See also `Understanding Privilege Escalation <https://docs.ansible.com/ansible/latest/user_guide/become.html#understanding-privilege-escalation>`__ (6-8)


.. _ug_debug:

*****
Debug
*****

Many tasks will display additional information when the variable
:index:`lp_debug` is enabled. Enable debug output either in the
configuration

.. code-block:: yaml
   :emphasize-lines: 1

   lp_debug: true

, or set the extra variable in the command

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux_postinstall.yml -e "lp_debug=true"

.. note:: The debug output of this role is optimized for the **yaml**
   callback plugin. Set this plugin for example in the environment
   ``shell> export ANSIBLE_STDOUT_CALLBACK=yaml``.

.. seealso:: * `Playbook Debugger <https://docs.ansible.com/ansible/latest/user_guide/playbooks_debugger.html>`_


.. _ug_tags:

****
Tags
****

The :index:`tags` provide the user with a very useful tool to run selected
tasks of the role. To see what tags are available list the tags of the
role with the command

.. include:: tags-list.rst


Examples
========

* Display the list of the variables and their values with the tag
  ``lp_debug`` (when the :index:`debug` is enabled ``lp_debug: true``)

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux_postinstall.yml -t lp_debug

* See what packages will be installed

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux_postinstall.yml -t lp_packages --check

* Install packages and exit the play

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux_postinstall.yml -t lp_packages


.. _ug_tasks:

*****
Tasks
*****

The description of the tasks is not complete. The `role <https://galaxy.ansible.com/vbotka/linux_postinstall/>`_ and the documentation is work in progess. Feel free to `share your feedback and report issues <https://github.com/vbotka/ansible-linux-postinstall/issues>`_.

`Contributions are welcome <https://github.com/firstcontributions/first-contributions>`_.

.. seealso::
   * `Documentation source at GitHub <https://github.com/vbotka/ansible-linux-postinstall/tree/master/docs>`_
   * `Tasks source at GitHub <https://github.com/vbotka/ansible-linux-postinstall/tree/master/tasks>`_
   * Annotated source code :ref:`as_main.yml`

Development and testing
=======================

In order to deliver an Ansible project it's necessary to test the code
and configuration. The tags provide the administrators with a tool to
test single tasks' files and single tasks. For example, to test single
tasks at single remote host *test_01*, create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Customize configuration in ``host_vars/test_01/lp-*.yml`` and :index:`check the syntax`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml --syntax-check

Then :index:`dry-run` the selected task and see what will be
changed. Replace <tag> with valid tag or with a comma-separated list
of tags

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t <tag> --check --diff

When all seems to be ready run the command. Run the command twice and
make sure the playbook and the configuration is :index:`idempotent`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t <tag>

.. seealso::
   * Periodically run playbooks from cron by *ansible-runner*
     `ansible-cron-audit.bash <https://github.com/vbotka/ansible-runner/blob/master/contrib/ansible-cron-audit.bash>`_
   * *ansible-runner* wrapper
     `arwrapper.bash <https://github.com/vbotka/ansible-runner/blob/master/contrib/arwrapper.bash>`_
   

.. _ug_task_netplan:
.. include:: task-netplan.rst
.. toctree::
   :name: netplan_toc

   task-netplan-ex1
   task-netplan-ex2

.. _ug_task_netplan_ex1:
.. include:: task-netplan-ex1.rst
.. _ug_task_netplan_ex2:
.. include:: task-netplan-ex2.rst


.. _ug_task_networkmanager:
.. include:: task-networkmanager.rst
.. toctree::
   :name: networkmanager_toc

   task-networkmanager-ex1

.. _ug_task_networkmanager_ex1:
.. include:: task-networkmanager-ex1.rst


.. _ug_task_passwords:
.. include:: task-passwords.rst
.. _ug_task_passwords_passwordstore:
.. include:: task-passwords-passwordstore.rst
.. toctree::
   :name: passwords_passwordstore_toc

   task-passwords-passwordstore-ex1
   task-passwords-passwordstore-ex2
   task-passwords-passwordstore-ex3

.. _ug_task_passwords_passwordstore_ex1:
.. include:: task-passwords-passwordstore-ex1.rst
.. _ug_task_passwords_passwordstore_ex2:
.. include:: task-passwords-passwordstore-ex2.rst
.. _ug_task_passwords_passwordstore_ex3:
.. include:: task-passwords-passwordstore-ex3.rst


.. _ug_task_service:
.. include:: task-service.rst
.. toctree::
   :name: service_toc

   task-service-ex1
   task-service-ex2

.. _ug_service_ex1:
.. include:: task-service-ex1.rst
.. _ug_service_ex2:
.. include:: task-service-ex2.rst


.. _ug_task_systemd:
.. include:: task-systemd.rst
.. toctree::
   :name: systemd_toc

   task-systemd-ex1
   task-systemd-ex2
   task-systemd-ex3
   task-systemd-ex4

.. _ug_ssytemd_ex1:
.. include:: task-systemd-ex1.rst
.. _ug_ssytemd_ex2:
.. include:: task-systemd-ex2.rst
.. _ug_ssytemd_ex3:
.. include:: task-systemd-ex3.rst
.. _ug_ssytemd_ex4:
.. include:: task-systemd-ex4.rst


.. _ug_task_wpasupplicant:
.. include:: task-wpasupplicant.rst
.. toctree::
   :name: wpasupplicant_toc

   task-wpasupplicant-ex1

.. _ug_wpasupplicant_ex1:
.. include:: task-wpasupplicant-ex1.rst


.. _ug_task_zfs:
.. include:: task-zfs.rst
.. toctree::
   :name: zfs_toc

   task-zfs-ex1
   task-zfs-ex2

.. _ug_zfs_ex1:
.. include:: task-zfs-ex1.rst
.. _ug_zfs_ex2:
.. include:: task-zfs-ex2.rst


.. _ug_vars:

*********
Variables
*********

.. seealso::
   * `Ansible variable precedence: Where should I put a variable?
     <https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable>`_

.. _ug_vars_defaults:
.. include:: vars-defaults.rst
.. _ug_vars_os_defaults:
.. include:: vars-os-defaults.rst
.. _ug_vars_os_custom:
.. include:: vars-os-custom.rst
.. _ug_vars_flavors:
.. include:: vars_flavors.rst


.. _ug_bp:

*************
Best practice
*************

.. _ug_bp_firstboot:

Recommended configuration after the installation of OS
======================================================

Test syntax

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml --syntax-check

See what variables will be included

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_debug -e 'lp_debug=True'

:index:`Dry-run`, display differences and display variables

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -e 'lp_debug=True' --check --diff

Configure hostname, users, sudoers, network and reboot

.. code-block:: sh
   :emphasize-lines: 1-8

   shell> ansible-playbook linux-postinstall.yml -t lp_hostname
   shell> ansible-playbook linux-postinstall.yml -t lp_users
   shell> ansible-playbook linux-postinstall.yml -t lp_sudoers
   shell> ansible-playbook linux-postinstall.yml -t lp_udev
   shell> ansible-playbook linux-postinstall.yml -t lp_netplan
   shell> ansible-playbook linux-postinstall.yml -t lp_wpasupplicant
   shell> ansible-playbook linux-postinstall.yml -t lp_reboot \
          -e "lp_reboot=true lp_reboot_force=true"

Configure firewall

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_iptables

Test the installation of packages

.. code-block:: sh
   :emphasize-lines: 1-2

   shell> ansible-playbook linux-postinstall.yml -t lp_packages \
          -e "lp_package_install_dryrun=True"

Install packages

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_packages

Run the playbook

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml

Test the :index:`idem-potency`. The role and the configuration data shall be
idempotent. Once the installation and configuration have passed there
should be no changes reported by *ansible-playbook* when running the
playbook repeatedly. Disable debug, and install to speedup the
playbook and run the playbook again.

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-playbook linux-postinstall.yml

.. _ug_bp_flavors:

Flavors
=======

 <TBD>
