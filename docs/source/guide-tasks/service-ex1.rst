.. _ug_task_service_ex1:

Example 1: Automatic management of services
"""""""""""""""""""""""""""""""""""""""""""

Services in the list *lp_service_auto* will be automatically set
according the below variables

.. code-block:: text

    lp_<service_name> ........... included if true (default=false)
    lp_<service_name>_service ... Os specific name (see defaults and vars)
    lp_<service_name>_enable .... enabled if true (default=false)
    lp_<service_name>_module .... module used (default=auto)

For example, given the below variables, the service *udev* will be set
enabled and started by module *service*

.. code-block:: yaml

    lp_udev: true
    lp_udev_service: udev
    lp_udev_enable: true
    lp_udev_module: service

**Create playbook**

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

**Create variables**
	 
Create the file *host_vars/test_01/lp-service.yml* and create the list
of services `lp_service_auto` that shall be managed by this task

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-service.yml
   lp_service_auto:
     - smart
     - udev

.. note:: It is possible to set only **state: started/stopped** and
          **enabled: true/false** for services listed in
          **lp_service_auto**.
	  
.. hint:: Use the variable **lp_service** to set other parameters.
   
**Show variables**

.. literalinclude:: examples/service-ex1-debug.yaml.example
   :language: yaml
   :emphasize-lines: 1

**Manage the services and show the results**

.. literalinclude:: examples/service-ex1-manage.yaml.example
   :language: yaml
   :emphasize-lines: 1
