Example 2: Enable ZFS services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create *host_vars/test_01/lp-zfs.yml*

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-zfs.yml 
   lp_zfs: true
   lp_zfs_debug: false

   lp_zfs_services:
     - {name: zfs-mount, enabled: true, state: started}
     - {name: zfs-share, enabled: true, state: started}
     - {name: zfs-zed, enabled: true, state: started}


Show status of :index:`ZFS` services at the remote host

.. code-block:: yaml
   :emphasize-lines: 1

   test_01> service --status-all | grep zfs
    [ - ]  zfs-import
    [ - ]  zfs-mount
    [ - ]  zfs-share
    [ - ]  zfs-zed

Enable :index:`ZFS` services

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_zfs

   TASK [vbotka.linux_postinstall : zfs: Manage zfs services] ******************
   changed: [test_01] => (item={'name': 'zfs-mount', 'enabled': True, 'state': 'started'})
   changed: [test_01] => (item={'name': 'zfs-share', 'enabled': True, 'state': 'started'})
   changed: [test_01] => (item={'name': 'zfs-zed', 'enabled': True, 'state': 'started'})

The command is idempotent

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_zfs
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=6 changed=0 unreachable=0 failed=0 skipped=8 rescued=0 ignored=0

Show status of :index:`ZFS` services at the remote host

.. code-block:: yaml
   :emphasize-lines: 1

   test_01> service --status-all | grep zfs
    [ - ]  zfs-import
    [ + ]  zfs-mount
    [ + ]  zfs-share
    [ + ]  zfs-zed
