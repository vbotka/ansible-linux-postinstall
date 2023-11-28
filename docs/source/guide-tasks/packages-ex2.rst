.. _ug_task_packages_ex2:

Example 2: Install packages
"""""""""""""""""""""""""""

Install packages listed in *lp_packages_install*


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
of packages *lp_packages_install*

.. code-block:: yaml
    :emphasize-lines: 1

    shell> cat host_vars/test_01/lp-packages.yml
    lp_packages_install:
      - ansible
      - ansible-lint
      - ara-client


**Show variables**

Display the variables::

  shell> ansible-playbook lp.yml -t lp_packages_debug -e lp_packages_debug=True


**Install packages listed in lp_packages_install**

.. literalinclude:: examples/packages-ex2-install.yaml.example
   :language: yaml
   :emphasize-lines: 1
