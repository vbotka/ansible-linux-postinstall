.. _ug_task_service:


Service
-------

Manage services. There are three modules that manage services:

* ansible.builtin.service
* ansible.builtin.systemd
* ansible.builtin.sysvinet


Synopsis
^^^^^^^^

There are four standalone blocks that can be selected by tags:

* Debug
* Sanity
* Automatic management of services
* Manual management of services

The module *service* is used in **automatic** management of services
listed in *lp_service_auto*. The **manual** management of services
uses by default the OS specific service management module discovered
by *ansible.builtin.setup* to manage services listed in
*lp_service*. The last task after the blocks will flush handlers.


Best practice
^^^^^^^^^^^^^

Create a playbook and configure variables

.. code-block:: yaml

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Check the syntax of the playbook

.. code-block:: bash

   shell> ansible-playbook lp.yml --syntax-check

Display variables

.. code-block:: bash

  shell> ansible-playbook lp.yml -t lp_service_debug -e lp_service_debug=true
  shell> ansible-playbook lp.yml -t lp_debug -e lp_debug=true

Check sanity of variables

.. code-block:: bash

  shell> ansible-playbook lp.yml -t lp_service_sanity -e lp_service_sanity=true -e lp_service_sanity_quiet=false

Don't make any changes, predict and show differences. Limit the
execution to the automatic and manual management of services

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_service_auto --check --diff
   shell> ansible-playbook lp.yml -t lp_service_manual --check --diff

Automatically manage services and display results

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_service_auto -e lp_service_debug=true

Manually manage services and display results

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_service_manual -e lp_service_debug=true

.. seealso::

   * source code :ref:`as_service.yml` to learn details.

   * defaults in *defaults/main/services.yml*

   * examples below.
  
.. note::
   
   * The module **service** is a proxy for OS specific service
     management modules. See the parameter **use** of the module.

   * The module **service** by default uses the service manager
     discovered by **ansible.builtin.setup** stored in the variable
     **ansible_service_mgr**.


Debug
^^^^^

By default, the debug is turned off. If enabled the debug task will
display the variables. For example,

.. literalinclude:: guide-tasks/examples/service-debug.yaml.example
   :language: yaml
   :emphasize-lines: 1

.. note:: To demonstrate the functionality, both *lp_service* and
          *lp_service_auto* list the same services. To manage a
          service you will usually use either *lp_service* or
          *lp_service_auto*. The tasks won't complain if you use both.


Sanity
^^^^^^

By default, the sanity checking is turned off. If enabled the module
*ansible.builtin.service_facts* will get the service facts and
following tasks will check the validity of:

* the service names in *lp_service*
* the service names in *lp_service_auto*
* the value of *lp_service_module*

.. literalinclude:: guide-tasks/examples/service-sanity.yaml.example
   :language: yaml
   :emphasize-lines: 1

.. seealso:: The declaration of the dynamic variables in *defaults/main/service.yml*


Automatic management of services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Only limited parameters (state, enabled, use) of the module *service*
are used in the automatic management of the services. The
configuration is very simple. Put services you want to manage into the
list *lp_service_auto*. Non-empty list *lp_service_auto* enables
automatic management of services

.. code-block:: yaml

    lp_service_auto:
      - smart
      - udev

See the tasks what services are implemented (acpi,
apparmor, auto_upgrades, ..., zfs). For each service, there are four
variables of the form

.. code-block:: text

    lp_<service_name> ........... included if true (default=false)
    lp_<service_name>_service ... OS specific name (see defaults and vars)
    lp_<service_name>_enable .... enabled if true (default=false)
    lp_<service_name>_module .... module used (default=auto)

where *service_name* is the name of the task. Only the variables
*lp_<service_name>_service* are mandatory. The names of services may
vary among the operating systems. The variable *lp_<service_name>* is
used both to import the tasks in *tasks/main.yml* and to enable automatic
management of the service. If this variable is *false* neither the
tasks will be imported nor the service will be managed
automatically. The default value of the variables *lp_<service_name>*
is *false* (see defaults). For example, given the below variables, the
service *udev* will be set enabled and started by the module *service*
if *udev* is included in the list *lp_service_auto*

.. code-block:: yaml

    lp_udev: true
    lp_udev_service: udev
    lp_udev_enable: true
    lp_udev_module: service

The state of the service is derived from the variable
*lp_<service_name>_enable*. If enabled the state is set *started*
otherwise it is set *stopped*.

.. seealso::

   :ref:`ug_task_service_ex1`


Manual management of services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If you want to set other parameters use the list
*lp_service*. Non-empty list *lp_service* enables manual management of
services.

.. code-block:: yaml

    lp_service:
      - enabled: true
        name: smartmontools
        state: started
        use: auto
      - enabled: true
        name: udev
        state: started
        use: service

Here you can use the variables *lp_<service_name>_\** explicitly. The
content of the below list will be the same

.. code-block:: yaml

    lp_service:
      - name: "{{ lookup('vars', 'lp_smart_service') }}"
        enabled: "{{ lookup('vars', 'lp_smart_enable', default=false) }}"
        state: "{{ lookup('vars', 'lp_smart_state', default='stopped') }}"
        use: "{{ lookup('vars', 'lp_smart_module', default='auto') }}"
      - name: "{{ lookup('vars', 'lp_udev_service') }}"
        enabled: "{{ lookup('vars', 'lp_udev_enable', default=false) }}"
        state: "{{ lookup('vars', 'lp_udevt_state', default='stopped') }}"
        use: "{{ lookup('vars', 'lp_udev_module', default='auto') }}"

What parameters can be used depends on the module. By default the
variable *lp_service_module* is set to *auto*. In this case, the OS
native service manager *ansible_service_mgr* is used. Take a look at
files *tasks/fn/service-\*.yml* what options are available. The valid
options are listed in the variable *lp_service_module_valid*

.. code:: yaml

   lp_service_module_valid: [auto, service, systemd, sysvinit]


Module systemd
""""""""""""""

Quoting from the `notes <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_service_module.html#notes>`_:

   The order of execution when having multiple properties is to first
   enable/disable, then mask/unmask and then deal with service
   state. It has been reported that systemctl can behave differently
   depending on the order of operations if you do the same manually.

The task *systemd* will be run three times to:

1) enable/disable services
2) mask/unmask services
3) deal with services' states

.. seealso::

   * source code :ref:`as_service-systemd.yml`
   * :ref:`ug_task_service_ex2`


Module sysvinit
"""""""""""""""

TBD

.. seealso::

   * source code :ref:`as_service-sysvinit.yml`

	
Examples
^^^^^^^^

.. toctree::

   guide-tasks/service-ex1
   guide-tasks/service-ex2
