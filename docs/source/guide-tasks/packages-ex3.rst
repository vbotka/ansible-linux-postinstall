.. _ug_task_packages_ex3:

Example 3: Remove packages
""""""""""""""""""""""""""

Remove packages listed in *lp_packages_remove*


**Create playbook**

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall


**Create variables**

Create the file *host_vars/test_01/lp-packages.yml* and declare the list
of packages *lp_packages_remove*

.. code-block:: yaml
    :emphasize-lines: 1

    shell> cat host_vars/test_01/lp-packages.yml
    lp_packages_remove:
      - zeitgeist


**Show variables**

Display the variables::

  shell> ansible-playbook lp.yml -t lp_packages_debug -e lp_packages_debug=True


**Remove packages listed in lp_packages_remove**

.. literalinclude:: examples/packages-ex3-remove.yaml.example
   :language: yaml
   :emphasize-lines: 1
