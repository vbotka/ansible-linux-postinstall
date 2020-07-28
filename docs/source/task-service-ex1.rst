Example 1: Manage services listed in lp_service_enable
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create the file *host_vars/test_01/lp-service.yml* and create the list
of services :index:`lp_service_enable` that shall be managed by this
task

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-service.yml
   lp_service: []
   lp_service_enable:
     - udev
     - sshd
     - bluetooth
     - postfix
     - smart
     - timesyncd

.. note:: Name of the variable ``lp_service_enable`` means **enable
   management** of these services.

.. hint:: Use the variable ``lp_service`` to create list of **enabled
          services**. See the next example.
   
Show what services will be managed

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_service_debug \
          -e "lp_service_debug=True"
		     
   TASK [vbotka.linux_postinstall : service: Debug] ***************************
   ok: [test_01] => {
       "msg": [
           "lp_service",
           "[]",
           "",
           "lp_service_enable",
           "- udev",
           "- sshd",
           "- bluetooth",
           "- postfix",
           "- smart",
           "- timesyncd",
           "",
           "my_service_name_vars",
           "-   udev: udev",
           "-   sshd: ssh",
           "-   bluetooth: bluetooth",
           "-   postfix: postfix",
           "-   smart: smartmontools",
           "-   timesyncd: systemd-timesyncd.service",
           "",
           "my_service_enable_vars",
           "-   udev: true",
           "-   sshd: true",
           "-   bluetooth: true",
           "-   postfix: true",
           "-   smart: true",
           "-   timesyncd: true"
       ]
   }


Manage the services

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_service_auto

   TASK [vbotka.linux_postinstall : service: Automatically enable or disable services managed by this role]
   ok: [test_01] => (item=udev)
   ok: [test_01] => (item=sshd)
   ok: [test_01] => (item=bluetooth)
   ok: [test_01] => (item=postfix)
   ok: [test_01] => (item=smart)
   ok: [test_01] => (item=timesyncd)


Show the status of the services ::

   test_01> service --status-all
