Example 1: Enable ethernet interface by Netplan
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create *host_vars/test_01/lp-netplan.yml*

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-netplan.yml 
   lp_netplan: true
   lp_netplan_renderer: "networkd"
   lp_netplan_conf:
     - file: "10-ethernet.yaml"
       category: "ethernets"
       conf: |
         eth0:
           optional: true
           set-name: eth0
           dhcp4: true
           dhcp6: false
           match:
           macaddress: "<sanitized>"

Configure :index:`network`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_netplan

   TASK [vbotka.linux_postinstall : netplan: Configure files in /etc/netplan] **
   ok: [test_01] => (item={'file': '10-ethernet.yaml', 'category': 'ethernets',
                           'conf': 'eth0:  optional: true  set-name: eth0
                                    dhcp4: true  dhcp6: false  match:
                                    macaddress: "<sanitized>"'})

The command is :index:`idempotent`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_netplan
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=6 changed=0 unreachable=0 failed=0 skipped=4 rescued=0 ignored=0

   
Show the configuration of :index:`netplan` at the remote host
   
.. code-block:: sh
   :emphasize-lines: 1,6,12

   test_01> tree /etc/netplan/
   /etc/netplan/
   ├── 01-network-manager-all.yaml
   └── 10-ethernet.yaml

   test_01> cat /etc/netplan/01-network-manager-all.yaml 
   # Ansible managed
   network:
     version: 2
     renderer: networkd

   test_01> cat /etc/netplan/10-ethernet.yaml 
   # Ansible managed
   network:
     version: 2
     renderer: networkd
     ethernets:
       {
       "eth0": {
           "dhcp4": true,
           "dhcp6": false,
           "match": {
               "macaddress": "<sanitized>"
           },
           "optional": true,
           "set-name": "eth0"
       }
     }
