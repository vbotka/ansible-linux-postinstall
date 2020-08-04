Example 1: Configure wpa_supplicant by networkd
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall


Take a look at the wpa_supplicant services available at the remote
host

.. code-block:: yaml
   :emphasize-lines: 1

   test_01> systemctl list-unit-files | grep wpa
   wpa_supplicant-wired@.service          disabled       
   wpa_supplicant.service                 disabled       
   wpa_supplicant@.service                disabled


The *nl80211* service ``wpa_supplicant-nl80211@.service`` is not
available. Therefor, in the configuration, we use the default type
``type: default`` (21). This will enable and start the service
``wpa_supplicant@wlan0.service``. This service will start
*wpa_supplicant* with both *nl80211* and *wext* driver ::

   /sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -Dnl80211,wext -iwlan0


Create *host_vars/test_01/lp-wpasupplicant.yml*

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 1,21

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

.. note::
   * *systemd-networkd* uses internal DHCP client. It's not necessary
     to enable *wpa_cli* ``wpa_cli -B -i wlan0 -a
     /root/bin/wpa_action.sh``. The *action script* is disables
     ``lp_wpa_action_script: false``.


Configure :index:`wpa_supplicant`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_wpasupplicant

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
   * There is no item *(item=None)* reported by the task *Create
     wpasupplicant configuration file* because the log is disabled
     ``no_log: "{{ not lp_wpasupplicant_debug_classified }}"``


The command is :index:`idempotent`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_wpasupplicant
   ...
   PLAY RECAP ******************************************************************
   test_01: ok=49 changed=0 unreachable=0 failed=0 skipped=28 rescued=0 ignored=0


Show the process at the remote host

.. code-block:: sh
   :emphasize-lines: 1

   test_01> pgrep -a wpa_supplicant
   28300 /sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -Dnl80211,wext -iwlan0


Show the status of the service at remote host

.. code-block:: sh
   :emphasize-lines: 1

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

