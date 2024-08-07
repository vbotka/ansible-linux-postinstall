.. _ug_task_service:


Service
-------

Manage services. There are three modules that manage services

* `ansible.builtin.service <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/service_module.html>`_
* `ansible.builtin.systemd <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/systemd_service_module.html>`_
* `ansible.builtin.sysvinit <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/sysvinit_module.html>`_


Synopsis
^^^^^^^^

There are four standalone blocks that can be selected by tags:

* Debug. Display variables.
* Sanity check
* Manage automatically services listed in *lp_service_auto*
* Manage services listed in *lp_service*

The module *service* is used in automatic management of services
listed in *lp_service_auto*. The OS specific service management module
discovered by *ansible.builtin.setup* is used to manage services
listed in *lp_service*. The last task after the blocks will flush
handlers.

.. seealso::

   * :ref:`as_service.yml`
   * :ref:`as_service-service.yml`
   * :ref:`as_service-systemd.yml`
   * :ref:`as_service-sysvinit.yml`

Quick guide
^^^^^^^^^^^

* Create list *lp_service_auto* ::

   lp_service_auto: [smart, udev]

  and select the automatic management of services::

   shell> ansible-playbook lp.yml -t lp_service_auto

* Create list *lp_service*::

   lp_service:
     - enabled: true
       name: smartmontools
       state: started
       use: auto
     - enabled: true
       name: udev
       state: started
       use: service

  and select the manual management of services::

   shell> ansible-playbook lp.yml -t lp_service_manual


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

If all seems right manage services and display results

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_service_manual -e lp_service_debug=true

Automatically manage services and display results

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_service_auto -e lp_service_debug=true

To minimize both the execution and output, disable skipped hosts

.. code-block:: bash

   shell> ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook lp.yml -t lp_service_auto
     ...
   TASK [vbotka.linux_postinstall : service: Automatic management of listed services] **************
   ok: [test_01] => (item=unattended-upgrades enabled=False state=stopped use=auto)
   ok: [test_01] => (item=autofs enabled=False state=stopped use=auto)
   ok: [test_01] => (item=bluetooth enabled=True state=started use=auto)
   ok: [test_01] => (item=postfix enabled=True state=started use=auto)
   ok: [test_01] => (item=resolvconf enabled=True state=started use=auto)
   ok: [test_01] => (item=smartmontools enabled=True state=started use=auto)
   ok: [test_01] => (item=speech-dispatcher enabled=False state=stopped use=auto)
   ok: [test_01] => (item=ssh enabled=True state=started use=auto)
   ok: [test_01] => (item=systemd-timesyncd.service enabled=False state=stopped use=auto)
   ok: [test_01] => (item=udev enabled=True state=started use=service)
   ok: [test_01] => (item=ufw enabled=True state=started use=auto)

.. seealso::

   * source code :ref:`as_service.yml` to learn details.

   * `defaults/main/service.yml <https://github.com/vbotka/ansible-linux-postinstall/blob/master/defaults/main/service.yml>`_

   * examples below.
  
.. note::
   
   * The module ``service`` is a proxy for OS specific service
     management modules. See the parameter ``use`` of the module.

   * The module ``service`` by default uses the service manager
     discovered by ``ansible.builtin.setup`` stored in the variable
     ``ansible_service_mgr``.

.. hint:: Use `yaml callback <https://docs.ansible.com/ansible/latest/collections/community/general/yaml_callback.html>`_


Debug
^^^^^

By default, the debug is turned off ``lp_service_debug=false``. If
enabled the debug task will display the variables. For example,

.. literalinclude:: guide-tasks/examples/service-debug.yaml.example
   :language: yaml
   :linenos:
   :emphasize-lines: 1,14,24

.. note:: To demonstrate the functionality, both ``lp_service`` and
          ``lp_service_auto`` list the same services. To manage a
          service you will usually use either ``lp_service`` or
          ``lp_service_auto``. The tasks won't complain if you use both.


Sanity
^^^^^^

By default, the sanity checking is turned off
``lp_service_sanity=false``. If enabled the module
*ansible.builtin.service_facts* will get the service facts and
following tasks will check the validity of:

* the service names in *lp_service*
* the service names in *lp_service_auto*
* the value of *lp_service_module*

.. literalinclude:: guide-tasks/examples/service-sanity.yaml.example
   :language: yaml
   :emphasize-lines: 1

.. seealso:: The declaration of the dynamic variables in `defaults/main/service.yml <https://github.com/vbotka/ansible-linux-postinstall/blob/master/defaults/main/service.yml>`_


Manage services automatically
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Only limited parameters (*state, enabled, use*) of the module *service*
are used in the automatic management of the services. The
configuration is very simple. Put services you want to manage into the
list *lp_service_auto*. Non-empty list *lp_service_auto* enables
automatic management of services

.. code-block:: yaml

    lp_service_auto:
      - smart
      - udev

See the tasks what services are implemented (acpi, apparmor,
auto_upgrades, ..., zfs). For each service, there might be five
variables of the form

.. code-block:: text

    lp_<service_name> ........... included if true (default=false)
    lp_<service_name>_service ... OS specific name (default=<service_name>)
    lp_<service_name>_enable .... enabled if true (default=false)
    lp_<service_name>_state ..... started if true (default=<fn(enabled)>)
    lp_<service_name>_module .... module used (default=auto)

where *service_name* is the name of the task.

* ``lp_<service_name>`` is used both to import the tasks in
  *tasks/main.yml* and to enable automatic management of the
  service. If this variable is *false* neither the tasks will be
  imported nor the service will be managed automatically. The default
  value is *false* (see defaults).

* ``lp_<service_name>_service`` is the name of the service. The names of
  services may vary among the operating systems. The default is
  *<service_name>*

* ``lp_<service_name>_enable`` is what you think it is. The default is
  *false*.

* ``lp_<service_name>_state`` is also what you think it is. The default
  state of the service is derived from the variable
  *lp_<service_name>_enable*. If enabled the state is set *started*
  otherwise it is set *stopped*.

* ``lp_<service_name>_module`` is a name of Ansible module used in the
  parameter *use* of the module *service*. The default is *auto*.

For example, given the below variables, the service *udev* will be set
enabled and started by the module *service* if *udev* is included in
the list *lp_service_auto*

.. code-block:: yaml

    lp_udev: true
    lp_udev_enable: true
    lp_udev_module: service

.. seealso::

   :ref:`ug_task_service_ex1`


Manage services
^^^^^^^^^^^^^^^

If you want to set other parameters of the services use the list
*lp_service*. Non-empty list *lp_service* enables manual management of
services

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
