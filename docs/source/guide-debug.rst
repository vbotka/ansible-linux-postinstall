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

The above command will run the single debug task. In the last section,
the values of all variables that enable the subsystems are displayed
in alphabetical order. See ``tasks/main.yml`` on how to enable
particular imports. Some tasks need non-empty list only. For example
non-empty lists *lp_users* or *lp_users_groups* iterate the *user*
module in ``tasks/users.yml``.

.. literalinclude:: guide-debug/code04.yaml.example
   :language: YAML
   :emphasize-lines: 1,28-78

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
