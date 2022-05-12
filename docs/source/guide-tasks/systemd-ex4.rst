.. _ug_task_systemd_ex4:

Example 4: Control units
""""""""""""""""""""""""

Create a playbook

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create the file ``host_vars/test_01/lp-systemd.yml`` (1). Enable the
import of the tasks (2). Configure the units (3).

.. code-block:: YAML
   :linenos:
   :emphasize-lines: 1,2,3

   shell> cat lp-systemd.yml
   lp_systemd: true
   lp_systemd_unit:
     - name: zfs-mount
       control:
         enabled: true
         state: started
         restart_or_reload: restarted
     - name: zfs-share
       control:
         enabled: true
         state: started
         restart_or_reload: restarted
     - name: zfs-zed
       control:
         enabled: true
         state: started
         restart_or_reload: restarted

Run the playbook with the tag ``-t lp_systemd_unit_control`` to limit the
tasks and control the units only

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_systemd_unit_control

   TASK [vbotka.linux_postinstall : systemd: Control units] *********************
   changed: [test_01] => (item=zfs-mount.service)
   changed: [test_01] => (item=zfs-share.service)
   changed: [test_01] => (item=zfs-zed.service)

   PLAY RECAP *******************************************************************
   test_01: ok=6 changed=1 unreachable=0 failed=0 skipped=6 rescued=0 ignored=0


Display the status of ``zfs-mount.service``

.. code-block:: Bash
   :emphasize-lines: 1

   shell> systemctl status zfs-mount.service

   ● zfs-mount.service - Mount ZFS filesystems
        Loaded: loaded (/lib/systemd/system/zfs-mount.service; enabled; vendor preset: enabled)
        Active: active (exited) since Sun 2020-08-09 23:19:45 CEST; 17min ago
          Docs: man:zfs(8)
       Process: 560998 ExecStart=/sbin/zfs mount -a (code=exited, status=0/SUCCESS)
      Main PID: 560998 (code=exited, status=0/SUCCESS)

Display System V status of ``zfs-*`` scripts

.. code-block:: Bash
   :emphasize-lines: 1

   shell> service --status-all | grep zfs
   [ - ]  zfs-import
   [ + ]  zfs-mount
   [ + ]  zfs-share
   [ + ]  zfs-zed
