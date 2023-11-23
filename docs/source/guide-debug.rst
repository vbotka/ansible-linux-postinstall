.. _ug_debug:

Debug
=====


.. _ug_debug_subsystems_enable:

Display subsystems
------------------

Limit the execution of the playbook by the tag ``-t lp_debug`` to the
tasks stored in the file ``tasks/debug.yml`` and enable the debug
output either in the configuration,

.. code-block:: YAML
   :emphasize-lines: 1

   lp_debug: true

, or in the command by setting the extra variable 


.. code-block:: YAML
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -e lp_debug=true -t lp_debug

The above command will run the single debug task and display selected
variables. There are more sections in the output:

* (4-10) The facts collected by *setup*.

* (12-15) The parameters that control the collection of OS specific
  variables.

* {19-22) The parameters that control the installation of packages
  (19-20), backup of changed files (21), and list of managed services.

* (25-26) See the next section :ref:`ug_debug_subsystems_lists`
  
* (28-49) The sorted list of tasks

* (51-70) The sorted list of single services *lp_<name>_service*

* (72-80) The sorted list of multiple services *lp_<name>_services*

* (82-86) Others
  
The first variables in the blocks of the tasks and services enable
that particular subsystem. See ``tasks/main.yml`` on how to enable
particular imports. Some tasks need non-empty list only. For example
non-empty lists *lp_users* or *lp_users_groups* iterate the *user*
module in ``tasks/users.yml``. Not all tasks are listed in this debug
output.

.. literalinclude:: guide-debug/code04.yaml.example
   :language: YAML
   :linenos:
   :emphasize-lines: 1,4-10,12-15,19-22,28-49,51-70,72-80,82-85

.. note:: The debug output of this role is optimized for the **yaml**
   callback plugin. Set this plugin, for example, in the environment
   ``shell> export ANSIBLE_STDOUT_CALLBACK=yaml``.


.. _ug_debug_subsystems_lists:

Display lists of subsystems
---------------------------

If you enable the variables below either in the configuration or in the command

.. code-block:: YAML
   :emphasize-lines: 1-2

   lp_tasks_enabled_print: true
   lp_tasks_disabled_print: true

the output will include the lists of enabled and disabled
subsystems. By default, all subsystems are disabled

.. literalinclude:: guide-debug/code05.yaml.example
   :language: YAML
   :emphasize-lines: 1

.. note:: See the defaults of the variables *lp_tasks_\** in the file
          ``defaults/main/common.yml``.


.. _ug_debug_subsystems:

Debug subsystems
----------------

Most of the subsystems will display additional information when debug
is enabled. For example, enable both the *sshd* subsystem and its
debug output either in the configuration,

.. literalinclude:: guide-debug/code01.yaml.example
   :language: YAML
   :emphasize-lines: 1-2

, or in the command by setting the extra variables 

.. literalinclude:: guide-debug/code02.bash.example
   :language: Bash
   :emphasize-lines: 1

The above command, limited by the tag ``-t lp_sshd_debug``, will run the
single task and display the values of the *lp_sshd_\** variables

.. literalinclude:: guide-debug/code03.yaml.example
   :language: YAML
   :emphasize-lines: 1

.. seealso::

   * `Playbook Debugger <https://docs.ansible.com/ansible/latest/user_guide/playbooks_debugger.html>`_
