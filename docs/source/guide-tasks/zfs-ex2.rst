.. _ug_zfs_ex2:

Example 2: Enable ZFS services
""""""""""""""""""""""""""""""

Create a playbook

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create *host_vars/test_01/lp-zfs.yml*

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-zfs.yml 
   lp_zfs: true
   lp_zfs_debug: false

   lp_zfs_services:
     - {name: zfs-mount, enabled: true, state: started}
     - {name: zfs-share, enabled: true, state: started}
     - {name: zfs-zed, enabled: true, state: started}


Show status of ZFS services at the remote host

.. code-block:: YAML
   :emphasize-lines: 1

   test_01> service --status-all | grep zfs
    [ - ]  zfs-import
    [ - ]  zfs-mount
    [ - ]  zfs-share
    [ - ]  zfs-zed

Enable ZFS services

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_zfs

   TASK [vbotka.linux_postinstall : zfs: Manage zfs services] ******************
   changed: [test_01] => (item={'name': 'zfs-mount', 'enabled': True, 'state': 'started'})
   changed: [test_01] => (item={'name': 'zfs-share', 'enabled': True, 'state': 'started'})
   changed: [test_01] => (item={'name': 'zfs-zed', 'enabled': True, 'state': 'started'})

The command is idempotent

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_zfs
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=6 changed=0 unreachable=0 failed=0 skipped=8 rescued=0 ignored=0

Show status of ZFS services at the remote host

.. code-block:: YAML
   :emphasize-lines: 1

   test_01> service --status-all | grep zfs
    [ - ]  zfs-import
    [ + ]  zfs-mount
    [ + ]  zfs-share
    [ + ]  zfs-zed
