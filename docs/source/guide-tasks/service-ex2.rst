.. _ug_task_service_ex2:

Example 2: Manage services listed in lp_service
"""""""""""""""""""""""""""""""""""""""""""""""

Create a playbook

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create the file *host_vars/test_01/lp-service.yml* and create the list
of services that shall be managed by this task `lp_service`

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-service.yml
   lp_service_enable: []
   lp_service:
      < TBD>

Show what services will be managed

.. code-block:: Bash
   :emphasize-lines: 1-2

   shell> ansible-playbook lp.yml -t lp_service_debug \
                                  -e lp_service_debug=True
		     
   TASK [vbotka.linux_postinstall : service: Debug] ***************************
   ok: [test_01] => {
       "msg": [
           "lp_service",
           <TBD>
           "",
           "lp_service_enable",
           "[]",
       ]
   }


Manage the services

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_service_general

   TASK [vbotka.linux_postinstall : service: General management of services]
   ok: [test_01] => <TBD>

Show the status of the services ::

   test_01> service --status-all
