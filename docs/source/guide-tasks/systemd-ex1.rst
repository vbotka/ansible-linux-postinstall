.. _ug_task_systemd_ex1:

Example 1: Configure netpland
"""""""""""""""""""""""""""""

Create a playbook

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create the file ``host_vars/test_01/lp-systemd.yml`` (1). Enable the
import of the tasks (2). Configure the file (5). The ownership and
mode (6-8) use the default values ``lp_systemd_*`` and can be
omitted. The attribute ``reload_service`` (9) is needed to reload or
restart the service when the configuration file changes

.. code-block:: YAML
   :linenos:
   :emphasize-lines: 1,2,5,6-8,9,16

   shell> cat host_vars/test_01/lp-systemd.yml
   lp_systemd: true

   lp_systemd_conf:
     /etc/systemd/networkd.conf:
        owner: "{{ lp_systemd_owner }}"
        group: "{{ lp_systemd_group }}"
        mode:  "{{ lp_systemd_mode }}"
        reload_service: systemd-networkd.service
        conf:
          - {section: Network, key: SpeedMeter, val: 'no'}
          - {section: Network, key: SpeedMeterIntervalSec, val: 10sec}
          - {section: DHCP, key: DUIDType, val: vendor}

   lp_systemd_unit:
     - name: systemd-networkd
       control:
         enabled: true
         state: started
         restart_or_reload: restarted

.. note::

   * The service, which shall be reloaded or restarted when the
     configuration changes, ``reload_service`` (9) can be configured
     in ``lp_systemd_unit`` (16). The handler ``reload systemd conf``
     needs to know if and how to reload or restart the service.

   * If the attribute ``reload_service`` is missing in
     ``lp_systemd_unit`` the handler ``reload systemd conf`` will
     crash.
     
   * If the ``reload_service`` is not configured in
     ``lp_systemd_unit`` the handler ``reload systemd conf`` will
     reload the service by default.
     
   * If no service needs to be reloaded or restarted set
     ``reload_service: noop`` (9).

.. seealso::
     
   * See the handler ``reload systemd conf``.


Run the playbook with the tag ``-t lp_systemd_conf`` to limit the
tasks and configure the files from the dictionary ``lp_systemd_conf``

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_systemd_conf

   TASK [vbotka.linux_postinstall : systemd: Configure systemd] *****************
   changed: [test_01] => (item=/etc/systemd/networkd.conf Network SpeedMeter no)
   changed: [test_01] => (item=/etc/systemd/networkd.conf Network SpeedMeterIntervalSec 10sec)
   changed: [test_01] => (item=/etc/systemd/networkd.conf DHCP DUIDType vendor)

   TASK [vbotka.linux_postinstall : systemd: Debug conf results] ****************
   skipping: [test_01]
   
   TASK [vbotka.linux_postinstall : systemd: Debug conf loop results] ***********
   skipping: [test_01] => (item=/etc/systemd/networkd.conf) 
   skipping: [test_01] => (item=/etc/systemd/networkd.conf) 
   skipping: [test_01] => (item=/etc/systemd/networkd.conf) 
   skipping: [test_01]

   RUNNING HANDLER [vbotka.linux_postinstall : reload systemd conf] *************
   changed: [test_01] => (item=systemd-networkd.service)
   changed: [test_01] => (item=systemd-networkd.service)
   changed: [test_01] => (item=systemd-networkd.service)

   PLAY RECAP *******************************************************************
   test_01: ok=8 changed=2 unreachable=0 failed=0 skipped=7 rescued=0 ignored=0 

Display the configuration file

.. code-block:: Bash
   :emphasize-lines: 1

   test_01> cat /etc/systemd/networkd.conf
   [Network]
   SpeedMeter=no
   SpeedMeterIntervalSec=10sec
   [DHCP]
   DUIDType=vendor
