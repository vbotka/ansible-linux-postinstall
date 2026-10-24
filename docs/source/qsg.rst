.. _qg:

Quick start guide
*****************

For users who want to try the role quickly, this guide provides an
example of how to create users, install packages, and configure
services.


- Install the roles:

.. code-block:: console

    shell> ansible-galaxy install vbotka.linux_postinstall

.. code-block:: console

    shell> ansible-galaxy install vbotka.ansible_lib

.. code-block:: console

    shell> ansible-galaxy install vbotka.linux_lib


- Create the playbook ``playbook.yml`` for a single host *srv.example.com*:

.. code-block:: console

    shell> cat playbook.yml

.. code-block:: yaml
    :linenos:

    - hosts: srv.example.com
      gather_facts: true
      connection: ssh
      remote_user: admin
      become: true
      become_user: root
      become_method: sudo
      roles:
        - vbotka.linux_postinstall


- Create ``host_vars`` with customized variables:

.. code-block:: console

    shell> ls -1 host_vars/srv.example.com/lp-*

.. code-block:: text
    :linenos:

    host_vars/srv.example.com/lp-common.yml
    host_vars/srv.example.com/lp-users.yml
    host_vars/srv.example.com/lp-passwords.yml
    host_vars/srv.example.com/lp-packages.yml
    host_vars/srv.example.com/lp-service.yml


- To speed up execution, set non-essential variables to *false*:

.. code-block:: console

    shell> cat host_vars/srv.example.com/lp-common.yml

.. code-block:: yaml
    :linenos:

    lp_debug: false
    lp_backup_conf: false
    lp_flavors_enable: false


- Create users. Passwords will not be created (lines 4, 7). See `details
  <https://github.com/vbotka/ansible-lib/blob/master/tasks/al_pws_user_host.yml>`_.

.. code-block:: console

    shell> cat host_vars/srv.example.com/lp-users.yml

.. code-block:: yaml
    :emphasize-lines: 4,7
    :linenos:

    lp_users:
      - name: ansible
        shell: /bin/sh
        disabled_password: true
      - name: admin
        shell: /bin/bash
        disabled_password: true
    lp_users_groups:
      - name: admin
        groups: [adm, dialout]


- Configure passwords. See `details
  <https://github.com/vbotka/ansible-lib/blob/master/tasks/al_pws_user_host.yml>`_.

.. index::
    single: passwordstore; Quick start guide

.. code-block:: console

    shell> cat host_vars/srv.example.com/lp-passwords.yml

.. code-block:: yaml
    :linenos:

    lp_passwords: true
    lp_passwordstore: true
    lp_passwordstore_create: false
    lp_passwordstore_overwrite: false


- Install packages and enable autoremove:

.. code-block:: console

    shell> cat host_vars/srv.example.com/lp-packages.yml

.. code-block:: yaml
    :linenos:

    lp_packages_autoremove: true
    lp_packages_install:
      - ansible
      - ansible-lint
      - ansible-tower-cli


- Configure services:

.. code-block:: console

    shell> cat host_vars/srv.example.com/lp-service.yml

.. code-block:: yaml
    :linenos:

    lp_service_debug: true
    lp_service:
      - {name: ssh, state: started, enabled: true}


- Test syntax:

.. code-block:: console

    shell> ansible-playbook playbook.yml --syntax-check


- See which variables will be included:

.. code-block:: console

    shell> ansible-playbook playbook.yml -t lp_debug -e lp_debug=true


- Install packages:

.. code-block:: console

    shell> ansible-playbook playbook.yml -t lp_packages


- Perform a dry-run to display diffs and variable values:

.. code-block:: console

    shell> ansible-playbook playbook.yml -e lp_debug=true --check --diff


- Run the playbook:

.. code-block:: console

    shell> ansible-playbook playbook.yml


.. warning::

    The host has not been secured by this playbook and should be used for testing
    only.