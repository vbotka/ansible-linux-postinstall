.. _ug_bp:

Best practice
=============


.. _ug_bp_firstboot:

Recommended configuration after the installation of OS
------------------------------------------------------

* Test the syntax

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml --syntax-check

* What variables will be included?

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_debug -e lp_debug=True

* Dry run, display differences and display variables

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -e lp_debug=True --check --diff

* Configure hostname, users, sudoers, network and reboot

.. code-block:: Bash
   :emphasize-lines: 1-8

   shell> ansible-playbook lp.yml -t lp_hostname
   shell> ansible-playbook lp.yml -t lp_users
   shell> ansible-playbook lp.yml -t lp_sudoers
   shell> ansible-playbook lp.yml -t lp_udev
   shell> ansible-playbook lp.yml -t lp_netplan
   shell> ansible-playbook lp.yml -t lp_wpasupplicant
   shell> ansible-playbook lp.yml -t lp_reboot \
                                  -e lp_reboot=true lp_reboot_force=true

* Configure firewall

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_iptables

* Test the installation of packages

.. code-block:: Bash
   :emphasize-lines: 1-2

   shell> ansible-playbook lp.yml -t lp_packages \
                                  -e lp_package_install_dryrun=True

* Install packages

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_packages

* Run the playbook

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml

* Test the idempotency. The role and the configuration data shall be
  idempotent. Once the installation and configuration have passed
  there should be no changes reported by *ansible-playbook* when
  running the playbook repeatedly. To speedup the playbook disable
  debug, and install, and run the playbook again.

.. code-block:: Bash
   :emphasize-lines: 1

    shell> ansible-playbook lp.yml

.. _ug_bp_flavors:

Flavors
-------

 <TBD>
