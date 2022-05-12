.. _ug_task_systemd_ex3:

Example 3: Remove units (WIP)
"""""""""""""""""""""""""""""

Create a playbook

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create the file ``host_vars/test_01/lp-systemd.yml`` (1)

.. code-block:: YAML
   :linenos:
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-systemd.yml
   lp_systemd: true

   lp_systemd_unit:
     ...

<TBD>
