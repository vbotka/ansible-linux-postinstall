.. _ug_task_service_ex2:

Example 2: Manual management of services
""""""""""""""""""""""""""""""""""""""""

In the list *lp_service*, it is possible to set more parameters
compared to the list *lp_service_auto*. What parameters can be used
depends on the module that will be used

.. code-block:: yaml
    :emphasize-lines: 1,2

    lp_service_module: auto
    lp_service:
      - enabled: true
        name: smartmontools
        state: stopped
      - enabled: true
        name: udev
        state: stopped
        use: service

By default the variable *lp_service_module* is set to *auto*. In this
case, the OS native service manager *ansible_service_mgr* is used.

**Create a playbook**

.. code-block:: yaml
    :emphasize-lines: 1

    shell> cat lp.yml
    - hosts: test_01
      become: true
      roles:
        - vbotka.linux_postinstal

**Create variables**

Create the file *host_vars/test_01/lp-service.yml* and create the list
of services `lp_service` that shall be managed by this task

.. code-block:: yaml
    :emphasize-lines: 1

    shell> cat host_vars/test_01/lp-service.yml
    lp_service: []
      - enabled: true
        name: smartmontools
        state: started
        use: auto
      - enabled: true
        name: udev
        state: started
        use: service
   
**Show variables**

.. literalinclude:: examples/service-ex2-debug.yaml.example
    :language: yaml
    :emphasize-lines: 1


**Manage the services and show the results**

.. literalinclude:: examples/service-ex2-manage.yaml.example
    :language: yaml
    :emphasize-lines: 1
