.. _ug_task_packages:


Packages
--------

Manage packages. There are two modules maintained by the Ansible Core
Team that manage Linux packages (*package*, *yum*). In addition to
this, we also use here the module *apt*

* `ansible.builtin.package <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/package_module.html>`_
* `ansible.builtin.yum <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/yum_module.html>`_
* `ansible.builtin.apt <https://docs.ansible.com/ansible/latest/collections/ansible/builtin/apt_module.html>`_


Synopsis
^^^^^^^^

There are four tasks that can be selected by tags:

* Debug. Display variables.
* Install automatically enabled packages
* Install packages listed in *lp_packages_install*
* Remove packages listed in *lp_packages_remove*

Both tasks which install packages import the task `install_package.yml <https://github.com/vbotka/ansible-linux-lib/blob/master/tasks/install_package.yml>`_ from the role `vbotka.linux_lib <https://galaxy.ansible.com/vbotka/linux_lib>`_. Red Hat *ansible_os_family* will use *yum*, Debian *ansible_os_family* will use *apt*, and others will use *package*.

.. seealso::

   * :ref:`as_packages.yml`
   * `install_package.yml <https://github.com/vbotka/ansible-linux-lib/blob/master/tasks/install_package.yml>`_


Quick guide
^^^^^^^^^^^

* Install automatically enabled packages. This includes packages
  listed in the variables ``lp_<name>_packages`` where
  ``lp_<name>_install`` is ``true`` ::

   shell> ansible-playbook lp.yml -t lp_packages_auto -e lp_packages_auto=true

* Install packages listed in *lp_packages_install* ::

   shell> ansible-playbook lp.yml -t lp_packages_install

* Remove packages listed in *lp_packages_remove* ::

   shell> ansible-playbook lp.yml -t lp_packages_remove


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

  shell> ansible-playbook lp.yml -t lp_packages_debug -e lp_packages_debug=true

Don't make any changes, predict and show differences

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_packages -e lp_packages_auto=true --check --diff

Optionally, limit the execution by tags

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_packages_auto -e lp_packages_auto=true --check --diff
   shell> ansible-playbook lp.yml -t lp_packages_install --check --diff
   shell> ansible-playbook lp.yml -t lp_packages_remove --check --diff

If all seems right manage the packages and display the results

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_packages -e lp_packages_auto=true -e lp_packages_debug=true

Optionally, limit the execution by tags

.. code-block:: bash

   shell> ansible-playbook lp.yml -t lp_packages_auto -e lp_packages_auto=true -e lp_packages_debug=true
   shell> ansible-playbook lp.yml -t lp_packages_install -e lp_packages_debug=true
   shell> ansible-playbook lp.yml -t lp_packages_remove -e lp_packages_debug=true

To minimize both the execution and output, disable skipped hosts and sanity check

.. code-block:: bash

   shell> ANSIBLE_DISPLAY_SKIPPED_HOSTS=false ansible-playbook lp.yml -t lp_packages -e lp_packages_auto=true -e ll_ipkg_sanity=false
     ...
   TASK [vbotka.linux_postinstall : packages: Instantiate dynamic variables] ***********************
   ok: [test_01]

   TASK [vbotka.linux_lib : ll install_package: Install (apt)] *************************************
   ok: [test_01]

   TASK [vbotka.linux_lib : ll install_package: Install (apt)] *************************************
   ok: [test_01]
   

.. seealso::

   * source code :ref:`as_packages.yml` to learn details.

   * `defaults/main/packages.yml <https://github.com/vbotka/ansible-linux-postinstall/blob/master/defaults/main/packages.yml>`_

   * examples below.
  
.. note::
   
   * By default, automatic installation of packages is turned off ``lp_packages_auto=false``

.. hint:: Use `yaml callback <https://docs.ansible.com/ansible/latest/collections/community/general/yaml_callback.html>`_


Debug
^^^^^

By default, the debug is turned off ``lp_package_debug=false``. If
enabled the debug task will display the variables. For example,

.. literalinclude:: guide-tasks/examples/package-debug.yaml.example
   :language: yaml
   :linenos:
   :emphasize-lines: 1,14,17,20,23,26,57,86

.. note::

   * See `defaults/main/packages.yml <https://github.com/vbotka/ansible-linux-postinstall/blob/master/defaults/main/packages.yml>`_ how the dynamic variables ``my_packages_*`` are declared.

   * The dictionary ``my_packages_install`` collects the variables ``lp_*_install``

   * The dictionary ``my_packages_lists`` collects the variables ``lp_*_packages``

   * The list of lists ``my_packages_auto`` is used to automatically
     install the listed packages. Flatten the list and remove
     duplicates by the filter *unique* if you want to iterate it.


Install packages automatically
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, the automatic installation of packages is turned off
``lp_packages_auto=false``. If enabled the dynamically created list
*my_packages_auto* is used to install packages. The list
*my_packages_auto* keeps lists of packages from the dictionary
*my_packages_lists* enbled in *my_packages_install*.

See the tasks what lists of packages are required (apparmor, autofs,
chrony, ..., zfs). For each task, there might be two variables of the
form

.. code-block:: text

    lp_<name>_packages .... list of packages
    lp_<name>_install ..... install packages if true (default=false)

where *name* is the name of the task. Install the packages::

  shell> ansible-playbook lp.yml -t lp_packages_auto -e lp_packages_auto=true

.. seealso::

   :ref:`ug_task_packages_ex1`


Install packages
^^^^^^^^^^^^^^^^

Install packages listed in *lp_packages_install*. For example,

.. code-block:: yaml

   lp_packages_install:
     - ansible
     - ansible-lint
     - ara-client

Install the packages::

   shell> ansible-playbook lp.yml -t lp_packages_install

.. seealso::

   * :ref:`ug_task_packages_ex2`


Remove packages
^^^^^^^^^^^^^^^

Remove packages listed in *lp_packages_remove*. For example,

.. code-block:: yaml

   lp_packages_remove:
     - zeitgeist

Remove the packages::

  shell> ansible-playbook lp.yml -t lp_packages_remove

.. seealso::

   * :ref:`ug_task_packages_ex3`


Examples
^^^^^^^^

.. toctree::

   guide-tasks/packages-ex1
   guide-tasks/packages-ex2
   guide-tasks/packages-ex3
