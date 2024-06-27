.. _ug_task_wpasupplicant_ex2:

Example 2: Configure wpa_supplicant in Ubuntu 24.04
"""""""""""""""""""""""""""""""""""""""""""""""""""

In this example the Ansible role:

* creates *wpa_supplicant* configuration

* starts *wpa_supplicant* service

* *netplan* configured *networkd* configures IP address, resolver, and
  routing

**Create a playbook**

.. literalinclude:: examples/wpasupplicant-ex2/playbook.yml
   :language: yaml
   :emphasize-lines: 2

**Create host_vars/test_01/lp-wpasupplicant.yml**

Take a look at the wpa_supplicant services available at the remote host

.. literalinclude:: examples/wpasupplicant-ex2/systemctl_list-unit-files.txt
   :language: sh
   :emphasize-lines: 1

The utility ``wpa_supplicant`` will be installed (4) and the services
(13, 22) will be configured to use the binary (10). The *nl80211*
service ``wpa_supplicant-nl80211@.service`` is available. Therefor, in
the configuration, we use ``type: nl80211`` (41). This play will start
the service ``wpa_supplicant-nl80211@wlan0.service`` (40). However,
this service will not be started at the system start (39).  The
attribute *disabled* (47,52) tells *wpa_supplicant* which AP to
connect automatically to

.. literalinclude:: examples/wpasupplicant-ex2/lp-wpasupplicant.yml
   :language: yaml
   :linenos:
   :emphasize-lines: 1,4,10,13,22,39,40,41,47,52

In this scenario:

   * *wpa_supplicant* won't be started at the system start. You have
     to start the service manually.

   * *wpa_supplicant* will automatically connect to AP1.

.. warning::

   This role doesn't test whether a service is already used by other
   interfaces or not. It's necessary to disable such services and make
   sure corresponding wpa_supplicants are not running. Otherwise the
   restart of such service will crash.

**Enable service at system start**

Optionally, you might want to enable *wpa_supplicant* and start
it. Disable all access points if you want to avoid accidental
connections ::

  lp_wpasupplicant_conf:
    - dev: wlan0
      enabled: true
      state: started
      ...

In this scenario:

* *wpa_supplicant* will be started at the system start.

* *wpa_supplicant* will not automatically connect to any access
  point. You can use `wpa_cli`_ or `wpa_gui`_ to control
  *wpa_supplicant*.


.. note::

   * *systemd-networkd* uses internal DHCP client. See :ref:`ug_task_netplan_ex2`

   * If you don't enable DHCP client in the *netplan* configuration
     create script *wpa_action.sh* and run *wpa_cli*
     ``wpa_cli -B -i wlan0 -a /root/bin/wpa_action.sh``.
     By default, the *action script* won't be created
     ``lp_wpa_action_script: false``.

.. warning::

   Setting ``lp_wpasupplicant_debug_classified: true`` (6) will
   display also the passwords.

**Configure wpa_supplicant**

The below listing is abridged

.. literalinclude:: examples/wpasupplicant-ex2/tag_lp_wpasupplicant.txt
   :language: yaml
   :emphasize-lines: 1

.. note::

   * There is no item *(item=None)* reported by the task *Create
     wpasupplicant configuration file* because the log is disabled
     ``no_log: "{{ not lp_wpasupplicant_debug_classified }}"``

The command is idempotent

.. literalinclude:: examples/wpasupplicant-ex2/tag_lp_wpasupplicant-2.txt
   :language: yaml
   :emphasize-lines: 1

**Show the process at the remote host**

.. code-block:: sh
   :emphasize-lines: 1

   test_01> pgrep -a wpa_supplicant
   124727 /usr/sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf -Dnl80211 -iwlan0

**Show the status of the service at the remote host**

.. literalinclude:: examples/wpasupplicant-ex2/systemctl_status-wlan0.txt
   :language: sh
   :emphasize-lines: 1
   
The service is *active* and the connection to the access-point completed.

**Display the link and IP address**

.. literalinclude:: examples/wpasupplicant-ex2/iw_wlan0_link.txt
   :language: sh
   :emphasize-lines: 1,14

**Show the configuration of networkd**

.. code-block:: Bash
   :emphasize-lines: 1

   test_01> networkctl
   IDX LINK  TYPE     OPERATIONAL SETUP     
     1 lo    loopback carrier     unmanaged
     2 eth0  ether    routable    configured
     3 wlan0 wlan     routable    configured

   3 links listed.

.. _wpa_cli: https://manpages.ubuntu.com/manpages/noble/man8/wpa_cli.8.html
.. _wpa_gui: https://manpages.ubuntu.com/manpages/noble/man8/wpa_gui.8.html
