Example 2: Create units (WIP)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create the file *host_vars/test_01/lp-systemd.yml* (1)

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-systemd.yml
   lp_systemd: true

   lp_systemd_unit:
     ...

<TBD>
