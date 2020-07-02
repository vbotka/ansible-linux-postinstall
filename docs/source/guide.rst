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

.. include:: tags-list.rst

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

Test single tasks at single remote host *test_01*. Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Customize configuration in ``host_vars/test_01/lp-*.yml`` and check the syntax

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml --syntax-check

Then dry-run the selected task and see what will be changed

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_task --syntax-check --diff

When all seems to be ready run the command. Run the command twice and
make sure the playbook and the configuration is idempotent

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_task


.. _ug_task_netplan:
.. include:: task-netplan.rst
.. toctree::
   :name: netplan_toc

   task-netplan-ex1

.. _ug_task_netplan_ex1:
.. include:: task-netplan-ex1.rst

.. _ug_task_passwords:
.. include:: task-passwords.rst
.. toctree::
   :name: passwords_toc

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
