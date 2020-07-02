Example 1: Mount ZFS filesystems
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

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

   lp_zfs_manage:
     - name: zroot/test1
       state: present
       extra_zfs_properties:
         compression: on
     - name: zroot/images
       state: present
       extra_zfs_properties:
         compression: on
         mountpoint: /var/lib/libvirt/images

   lp_zfs_mountpoints:
     - mountpoint: /var/lib/libvirt/images
       owner: root
       group: root
       mode: "0711"
		     
Mount the ZFS filesystems

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_zfs

   TASK [vbotka.linux_postinstall : zfs: Manage zfs] ***************************
   ok: [test_01] => (item={u'state': u'present', u'extra_zfs_properties':
                          {u'compression': True}, u'name': u'zroot/test1'})
   ok: [test_01] => (item={u'state': u'present', u'extra_zfs_properties':
                          {u'mountpoint': u'/var/lib/libvirt/images', u'compression': True},
                           u'name': u'zroot/images'})

   TASK [vbotka.linux_postinstall : zfs: Set mode and ownership of zfs mountpoints]
   changed: [test_01] => (item={u'owner': u'root', u'mountpoint': u'/var/lib/libvirt/images',
                              u'group': u'root', u'mode': u'0711'})

The command is idempotent

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_zfs
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=11 changed=0 unreachable=0 failed=0 skipped=3 rescued=0 ignored=0

   
Show the ZFS mountpoints at the remote host
   
.. code-block:: sh
   :emphasize-lines: 1

   test_01> zfs list
   NAME           USED  AVAIL  REFER  MOUNTPOINT
   zroot          421M   107G    24K  /zroot
   zroot/images   419M   107G   419M  /var/lib/libvirt/images
   zroot/test1     24K   107G    24K  /zroot/test1
