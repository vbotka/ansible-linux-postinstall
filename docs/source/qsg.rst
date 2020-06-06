.. _qg:

Quick start guide
*****************

For those users who want to quickly try the role this guide provides an example of how to create users, install packages and configure services.


* Install the role ``vbotka.linux_postinstall`` ::

    shell> ansible-galaxy install vbotka.linux_postinstall


* Create the playbook ``linux-postinstall.yml`` for single host srv.example.com (2)

.. code-block:: bash
   :emphasize-lines: 2
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


* Create ``host_vars`` with customized variables.

.. code-block:: bash
   :emphasize-lines: 2-6
   :linenos:

   shell> ls -1 host_vars/srv.example.com/lp-*
   host_vars/srv.example.com/lp-common.yml
   host_vars/srv.example.com/lp-users.yml
   host_vars/srv.example.com/lp-passwords.yml
   host_vars/srv.example.com/lp-packages.yml
   host_vars/srv.example.com/lp-service.yml


* To speedup the execution let's set some variables (2-4) to *false*.

.. code-block:: bash
   :emphasize-lines: 2-4
   :linenos:

   shell> cat host_vars/srv.example.com/lp-common.yml
   lp_debug: false
   lp_backup_conf: false
   lp_flavors_enable: false


* Create users.

.. code-block:: bash
   :emphasize-lines: 3,5
   :linenos:

   shell> cat host_vars/srv.example.com/lp-users.yml
   lp_users:
     - {name: ansible,
        shell: /bin/sh}
     - {name: admin,
        shell: /bin/bash}
   lp_users_groups:
     - {name: admin,
        groups: "adm, dialout"}


* Configure passwords.

.. code-block:: bash
   :emphasize-lines: 2-5
   :linenos:

   shell> cat host_vars/srv.example.com/lp-passwords.yml
   lp_passwords: true
   lp_passwordstore: true
   lp_passwordstore_create: false
   lp_passwordstore_overwrite: false


* Install packages and enable autoremove.

.. code-block:: bash
   :emphasize-lines: 2-3
   :linenos:

   shell> cat host_vars/srv.example.com/lp-packages.yml
   lp_packages_autoremove: true
   lp_packages_install:
     - ansible
     - ansible-lint
     - ansible-tower-cli


* Configure services.

.. code-block:: bash
   :emphasize-lines: 2-3
   :linenos:

   shell> cat host_vars/srv.example.com/lp-service.yml
   lp_service_debug: true
   lp_service:
     - {name: ssh, state: started, enabled: true}
  

* Text syntax and review variables ::

    shell> ansible-playbook linux-postinstall.yml -e 'lp_debug=true' -CD


* Install packages ::

    shell> ansible-playbook linux-postinstall.yml -t lp_packages


* Display variables ::

    shell> ansible-playbook linux-postinstall.yml -t lp_debug -e 'lp_debug=true'


* Run the playbook ::

    shell> ansible-playbook linux-postinstall.yml