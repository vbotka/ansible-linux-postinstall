Example 2: Enable wifi interface by Netplan
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Add the configuration of the wireless interface to the file
*host_vars/test_01/lp-netplan.yml*

.. code-block:: yaml
   :emphasize-lines: 1,5,15

   shell> cat host_vars/test_01/lp-netplan.yml 
   lp_netplan: true
   lp_netplan_renderer: "networkd"
   lp_netplan_conf:
     - file: 10-ethernet.yaml
       category: ethernets
       conf: |
         eth0:
           optional: true
           set-name: eth0
           dhcp4: true
           dhcp6: false
           match:
             macaddress: "<sanitized>"
     - file: 10-wlan0-dhcp.yaml
       category: ethernets
       conf: |
         wlan0:
           optional: true
           set-name: wlan0
           dhcp4: true
           dhcp6: false
           match:
             macaddress: "<sanitized>"

.. note::
   * ``category: ethernets`` is used for *wlan0* instead of
     ``category: wifis`` because wpa_supplicant will authenticate the
     client to the access point.


Configure :index:`wifi` interface

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_netplan

   TASK [vbotka.linux_postinstall : netplan: Configure files in /etc/netplan] ******
   ok: [test_01] => (item={'file': '10-ethernet.yaml', 'category':
   'ethernets', 'conf': 'eth0:\n optional: true\n set-name: eth0\n dhcp4:
   true\n dhcp6: false\n match:\n macaddress: "<sanitized>"\n'})
   changed: [test_01] => (item={'file': '10-wlan0-dhcp.yaml', 'category':
   'ethernets', 'conf': 'wlan0:\n optional: true\n set-name: wlan0\n
   dhcp4: true\n dhcp6: false\n match:\n macaddress: "<sanitized>"\n'})

   RUNNING HANDLER [vbotka.linux_postinstall : netplan apply] **********************
   changed: [test_01]

   PLAY RECAP **********************************************************************
   test_01: ok=46 changed=2 unreachable=0 failed=0 skipped=25 rescued=0 ignored=0


The command is :index:`idempotent`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_netplan
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=45 changed=0 unreachable=0 failed=0 skipped=25 rescued=0 ignored=0


Show the configuration of the :index:`wifi` interface

.. code-block:: sh
   :emphasize-lines: 1,9

   test_01> tree /etc/netplan/
   /etc/netplan/
   |-- 10-ethernet.yaml
   |-- 10-wlan0-dhcp.yaml
   `-- armbian-default.yaml

   0 directories, 3 files

   test_01> cat /etc/netplan/10-wlan0-dhcp.yaml
   # Ansible managed
   network:
     version: 2
     renderer: networkd
     ethernets:
       {
       "wlan0": {
           "dhcp4": true,
           "dhcp6": false,
           "match": {
               "macaddress": "<sanitized>"
           },
           "optional": true,
           "set-name": "wlan0"
       }
   }

Show the configuration of :index:`networkd` at the remote host

.. code-block:: sh
   :emphasize-lines: 1,17,25

   test_01> cat /run/systemd/network/10-netplan-wlan0.network 
   [Match]
   MACAddress=<sanitized>
   Name=wlan0

   [Link]
   RequiredForOnline=no

   [Network]
   DHCP=ipv4
   LinkLocalAddressing=ipv6

   [DHCP]
   RouteMetric=100
   UseMTU=true

   test_01> cat /run/systemd/network/10-netplan-wlan0.link
   [Match]
   MACAddress=<sanitized>

   [Link]
   Name=wlan0
   WakeOnLan=off

   test_01> networkctl 
   IDX LINK             TYPE               OPERATIONAL SETUP     
     1 lo               loopback           carrier     unmanaged 
     2 eth0             ether              routable    configured
     3 wlan0            wlan               no-carrier  configuring

   3 links listed.

.. note::
   * wlan0 is *configuring* and *no-carrier* because wpa_supplicant
     has not been started yet. See the example of wpa_supplicant.
