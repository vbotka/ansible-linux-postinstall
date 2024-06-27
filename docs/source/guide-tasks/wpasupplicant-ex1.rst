.. _ug_task_wpasupplicant_ex1:

Example 1: Configure wpa_supplicant in Ubuntu 20.04
"""""""""""""""""""""""""""""""""""""""""""""""""""

In this example the Ansible role:

* creates *wpa_supplicant* configuration

* starts *wpa_supplicant* service

* *netplan* configured *networkd* configures IP address, resolver, and
  routing

**Create a playbook**

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat lp.yml
   ---
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

**Create host_vars/test_01/lp-wpasupplicant.yml**

Take a look at wpa_supplicant services available at the remote
host. If the `nl80211`_ service ``wpa_supplicant-nl80211@.service`` is
not available use the role's default service
``wpa_supplicant@.service``. Set type ``type: default`` (21).

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 1,8,21,26,30

   shell> cat host_vars/test_01/lp-wpasupplicant.yml

   lp_wpasupplicant: true
   lp_wpasupplicant_debug: false
   lp_wpasupplicant_debug_classified: false
   lp_wpasupplicant_conf_only: false

   lp_wpa_action_script: false
   lp_wpasupplicant_conf_ctrl_interface: /run/wpa_supplicant

   lp_wpasupplicant_conf_global:
     - {key: ctrl_interface, value: "{{ lp_wpasupplicant_conf_ctrl_interface }}"}
     - {key: ctrl_interface_group, value: adm}
     - {key: fast_reauth, value: "0"}
     - {key: update_config, value: "1"}

   lp_wpasupplicant_conf:
     - dev: wlan0
       enabled: true
       state: started
       type: default
       network:
         - conf:
           - {key: ssid, value: '"AP1"'}
           - {key: psk, value: "\"{{ ap.office['AP1'] }}\""}
           - {key: disabled, value: '0'}
         - conf:
           - {key: ssid, value: '"AP2"'}
           - {key: psk, value: "\"{{ ap.office['AP2'] }}\""}
           - {key: disabled, value: '1'}

This service will start `wpa_supplicant`_ with both `nl80211`_ and
`wext`_ drivers

.. code-block:: sh
   :emphasize-lines: 1

   /usr/sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -Dnl80211,wext -iwlan0

.. note::

   * The client will automatically connect to *AP1* (26,30)

   * *systemd-networkd* uses internal DHCP client.

   * The *wpa_cli* *action script* is disabled (8).

.. warning::

   * ``lp_wpasupplicant_debug_classified: true`` (5) will display also
     the passwords.

**Configure wpa_supplicant**

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_wpasupplicant

   TASK [vbotka.linux_postinstall : wpasupplicant: Create wpasupplicant configuration file]
   changed: [test_01] => (item=None)
   changed: [test_01]

   TASK [vbotka.linux_postinstall : wpasupplicant: Manage wpa_supplicant services]
   changed: [test_01] => (item=wpa_supplicant@wlan0.service)

   TASK [vbotka.linux_postinstall : wpasupplicant: Debug: Services] *************
   skipping: [test_01]

   RUNNING HANDLER [vbotka.linux_postinstall : reconfigure wpa_supplicant] ******
   changed: [test_01] => (item=wpa_supplicant@wlan0.service)

   PLAY RECAP *******************************************************************
   test_01: ok=50 changed=3 unreachable=0 failed=0 skipped=28 rescued=0 ignored=0


.. note::
   * There is no item *(item=None)* reported by the task *"Create
     wpasupplicant configuration file"* because the log is disabled
     ``no_log: "{{ not lp_wpasupplicant_debug_classified }}"``


The command is idempotent

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_wpasupplicant
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=49 changed=0 unreachable=0 failed=0 skipped=28 rescued=0 ignored=0


**Show the process at the remote host**

.. code-block:: sh
   :emphasize-lines: 1

   test_01> pgrep -a wpa_supplicant
   28300 /sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -Dnl80211,wext -iwlan0


**Show the status of the service at the remote host**

.. code-block:: sh
   :emphasize-lines: 1,4,19

   test_01> systemctl status wpa_supplicant@wlan0.service
   * wpa_supplicant@wlan0.service - WPA supplicant daemon (interface-specific version)
      Loaded: loaded (/lib/systemd/system/wpa_supplicant@.service; indirect; vendor preset: enabled)
      Active: active (running) since Tue 2020-08-04 04:55:15 CEST; 16min ago
    Main PID: 28300 (wpa_supplicant)
       Tasks: 1 (limit: 2191)
      CGroup: /system.slice/system-wpa_supplicant.slice/wpa_supplicant@wlan0.service
              `-28300 /sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -Dnl80211,wext -iwlan0

   Aug 04 04:55:15 test_01 systemd[1]: Started WPA supplicant daemon (interface-specific version).
   Aug 04 04:55:15 test_01 wpa_supplicant[28300]: Successfully initialized wpa_supplicant
   Aug 04 04:55:15 test_01 wpa_supplicant[28300]: wlan0: CTRL-EVENT-SCAN-FAILED ret=-16 retry=1
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: SME: Trying to authenticate with <sanitized> (SSID='AP1' freq=2412 M
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: Trying to associate with <sanitized> (SSID='AP1' freq=2412 MHz)
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: Associated with <sanitized>
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: CTRL-EVENT-SUBNET-STATUS-UPDATE status=0
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: CTRL-EVENT-REGDOM-CHANGE init=COUNTRY_IE type=COUNTRY alpha2=SK
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: WPA: Key negotiation completed with <sanitized> [PTK=CCMP GTK=CCMP]
   Aug 04 04:55:17 test_01 wpa_supplicant[28300]: wlan0: CTRL-EVENT-CONNECTED - Connection to <sanitized> completed [id=0 id_str=]

The service is *active* and the connection to the access-point
completed.

**Display the link and address**

.. code-block:: sh
   :emphasize-lines: 1,14

   test_01> iw wlan0 link
   Connected to <sanitized> (on wlan0)
   SSID: AP1
   freq: 2412
   RX: 48102049 bytes (474117 packets)
   TX: 112181 bytes (1164 packets)
   signal: -15 dBm
   tx bitrate: 43.3 MBit/s MCS 4 short GI

   bss flags:short-preamble
   dtim period:2
   beacon int:100

   test_01> ip address show wlan0
   3: wlan0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group
             default qlen 1000
       link/ether 74:da:38:e9:5e:5a brd ff:ff:ff:ff:ff:ff
       inet 10.1.0.21/24 brd 10.1.0.255 scope global dynamic wlan0
          valid_lft 3068841540sec preferred_lft 3068841540sec
   ...

**Show the configuration of networkd.**

.. code-block:: sh
   :emphasize-lines: 1

   test_01> networkctl
   IDX LINK             TYPE               OPERATIONAL SETUP
     1 lo               loopback           carrier     unmanaged
     2 eth0             ether              routable    configured
     3 wlan0            wlan               routable    configured

   3 links listed.

.. _wpa_supplicant: https://w1.fi/wpa_supplicant/
.. _netplan: https://netplan.readthedocs.io/en/stable/
.. _networkd: https://manpages.ubuntu.com/manpages/noble/man8/systemd-networkd.service.8.html
.. _nl80211: https://wireless.wiki.kernel.org/en/developers/documentation/nl80211
.. _wext: https://wireless.wiki.kernel.org/en/developers/documentation/wireless-extensions
.. _wpa_cli: https://manpages.ubuntu.com/manpages/noble/man8/wpa_cli.8.html
.. _wpa_gui: https://manpages.ubuntu.com/manpages/noble/man8/wpa_gui.8.html
