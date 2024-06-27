.. _ug_task_wpasupplicant:

wpa_supplicant
--------------

Synopsis
^^^^^^^^

Project `wpa_supplicant`_ provides the complete set of utilities to
configure and manage wireless interfaces

* `wpa_supplicant - Wi-Fi Protected Access client and IEEE 802.1X supplicant <https://manpages.ubuntu.com/manpages/noble/man8/wpa_supplicant.8.html>`_

* `wpa_cli - WPA command line client <https://manpages.ubuntu.com/manpages/noble/man8/wpa_cli.8.html>`_

* `wpa_gui - WPA Graphical User Interface <https://manpages.ubuntu.com/manpages/noble/man8/wpa_gui.8.html>`_

You can disable ``NetworkManager`` and configure, connect, and manage
the wireless interfaces on your own. Optionally, you can use
`netplan`_ to perform some of these tasks. But, in the minimal
installation, you can also get rid of `D-Bus`_, configure and start
`wpa_supplicant`_ on your own. Depending on the use-case, you can
manage wireless network by the CLI `wpa_cli`_ or GUI `wpa_gui`_. This
scheme provides complete, transparent, and secure management of
wireless networks.

.. seealso::

   * tasks :ref:`as_wpasupplicant.yml`
   * tasks :ref:`as_wpagui.yml`
   * handlers :ref:`as_handler_wpasupplicant.yml`
   * defaults [TODO]

Create a playbook
^^^^^^^^^^^^^^^^^

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat lp.yml
   ---
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Enable tasks import and install wpa_supplicant
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, the management of *wpa_supplicant* is disabled

.. code-block:: yaml

  - name: Import wpasupplicant.yml
    ansible.builtin.import_tasks: wpasupplicant.yml
    when: ((ansible_os_family == 'RedHat') or
          (ansible_os_family == 'Debian')) and lp_wpasupplicant|bool
    tags: lp_wpasupplicant

Enable it if you want to proceed ::

  lp_wpasupplicant: true

If you want to install or upgrade wpa_supplicant set ::

  lp_wpasupplicant_install: true

Run the play ::

  (env) > ansible-playbook lp.yml -t lp_wpasupplicant

Disable NetworkManager
^^^^^^^^^^^^^^^^^^^^^^

By default, Ubuntu distributions come with `netplan`_ configured
*renderer* ``NetworkManager`` ::

  network:
    version: 2
    renderer: NetworkManager

This chapter doesn't cover the configuration of
``NetworkManager``. Instead, the use-cases described below require
``NetworkManager`` disabled.

.. seealso::

   * NetworkManager - :ref:`ug_task_networkmanager_ex1`

   * `NetworkManager default configuration`_

networkd
^^^^^^^^

Optionally, you can use `netplan`_ and configure the wireless interfaces
with the *renderer* `networkd`_ ::

  network:
    version: 2
    renderer: networkd

It is also possible to use `netplan`_ to configure *wpa_supplicant* ::

  network:
  version: 2
  wifis:
    wlan0:
      access-points:
        "TEST":
          password: "password"

In this chapter we don't use `netplan`_ to configure
`wpa_supplicant`_.  Instead, we use this Ansible role to create the
`wpa_supplicant`_ configuration files. Later, we describe how to
control *wpa_supplicant* services by the CLI utility `wpa_cli`_ and GUI
`wpa_gui`_.

.. seealso::

   * Netplan - :ref:`ug_task_netplan_ex2`

   * :ref:`ug_task_netplan` - The network configuration abstraction renderer

   * Netplan - `Properties for device type wifis`_

   * `Developers' documentation for wpa_supplicant and hostapd <https://w1.fi/wpa_supplicant/devel/index.html>`_




Configure wpa_supplicant services
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The most important parts of this section are the configurations of the
services and access points. Take a look at the *wpa_supplicant*
services available at the remote host

.. code-block:: yaml
   :emphasize-lines: 1

   test_01> systemctl list-unit-files | grep wpa
   wpa_supplicant-nl80211@.service  disabled        enabled
   wpa_supplicant-wired@.service    disabled        enabled
   wpa_supplicant.service           disabled        enabled
   wpa_supplicant@.service          disabled        enabled

.. warning::

   This role doesn't test whether an interface uses other
   services. It's necessary to stop and disable such services
   before you run this Ansible role. Kill corresponding
   wpa_supplicants if they are still running. Otherwise, the restart
   of such an interface will crash.

In the below example we configure services:

* *wpa_supplicant@.service* (3) and

* *wpa_supplicant-nl80211@.service* (12)

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 3,12

   lp_wpasupplicant_service_conf:
     - path: /lib/systemd/system
       service: wpa_supplicant@.service
       no_extra_spaces: true
       handlers:
         - 'reload systemd daemon'
       ini:
         - section: Service
           option: ExecStart
           value: "{{ lp_wpasupplicant_bin }} -c/etc/wpa_supplicant/wpa_supplicant-%I.conf -i%I"
     - path: /lib/systemd/system
       service: wpa_supplicant-nl80211@.service
       no_extra_spaces: true
       handlers:
         - 'reload systemd daemon'
       ini:
         - section: Service
           option: ExecStart
           value: "{{ lp_wpasupplicant_bin }} -c/etc/wpa_supplicant/wpa_supplicant-nl80211-%I.conf -Dnl80211 -i%I"

For details, see the examples at the end of this section.

.. seealso::

   * `nl80211`_
   * `wext`_


Configure access points
^^^^^^^^^^^^^^^^^^^^^^^

In the below example we configure the *wpa_supplicant* global
parameters (1) and the interface *wlan0* (8) with one disabled (17)
access point (14). The configuration file
``/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf`` will be
created and the service ``wpa_supplicant-nl80211@wlan0.service``
(8,11) will be started (10) by the play. However, the service won't be
started (9) at the start of the system.

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 1,8,9,10,11,14,17

   lp_wpasupplicant_conf_global:
     - {key: ctrl_interface, value: "{{ lp_wpasupplicant_conf_ctrl_interface }}"}
     - {key: ctrl_interface_group, value: adm}
     - {key: fast_reauth, value: 0}
     - {key: update_config, value: 1}

   lp_wpasupplicant_conf:
     - dev: wlan0
       enabled: false
       state: started
       type: nl80211
       network:
         - conf:
             - {key: ssid, value: '"TEST"'}
             - {key: psk, value: '"password"'}
             - {key: pairwise, value: CCMP}
             - {key: disabled, value: 1}

Example of the configuration file created from the above configuration

.. code-block:: ini
   :linenos:
   :emphasize-lines: 1

   test_01> sudo cat /etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf
   # Ansible managed
   ctrl_interface=/run/wpa_supplicant
   ctrl_interface_group=adm
   fast_reauth=0
   update_config=1

   network={
           ssid="TEST"
           psk="password"
           pairwise=CCMP
           disabled=1
   }

Example of the running process ::

   test_01> ps ax | grep wpa
     124727 ?        Ss     2:37 /usr/sbin/wpa_supplicant -c/etc/wpa_supplicant/wpa_supplicant-nl80211-wlan0.conf -Dnl80211 -iwlan0

.. seealso::

   * Annotated Source code :ref:`as_wpasupplicant.yml`

   * Project website `wpa_supplicant`_

   * `ArchLinux Wiki wpa_supplicant <https://wiki.archlinux.org/index.php/wpa_supplicant>`_

Configure DHCP client
^^^^^^^^^^^^^^^^^^^^^

Set ``dhcp4: true`` (8) in the `netplan`_ configuration. In this case,
when *wpa_supplicant* connects to an AP, *netplan* will start the DHCP
client on the interface *wlan0*, will configure the resolver, and routing

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 1,8

   test_01> sudo cat /etc/netplan/10-ethernets.yaml
   # Ansible managed
   network:
     version: 2
     renderer: networkd
     ethernets:
       wlan0:
         dhcp4: true
         dhcp6: false
         match: {macaddress: '<sanitized>'}
         set-name: wlan0

.. seealso::

   Netplan - :ref:`ug_task_netplan_ex2`


Configure wpa_cli (optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Instead of the DHCP configuration in `netplan`_ you can use `wpa_cli`_. Create the action file, by default ``/root/bin/wpa_action.sh`` (1), and declare the template :ref:`as_template_wpa_action.sh.j2` parameters(2,3)

.. code-block:: yaml
   :linenos:
   :emphasize-lines: 1-3

   lp_wpa_action_script: true
   lp_wpasupplicant_conf_ctrl_interface: /run/wpa_supplicant
   lp_wpa_action_script_dhclient: /usr/sbin/dhclient

The play will create the action file, by default ``/root/bin/wpa_action.sh``

.. literalinclude:: guide-tasks/examples/wpasupplicant-ex2/wpa_action.sh
   :language: bash
   :linenos:
   :emphasize-lines: 1

.. seealso::

   * Install :ref:`ug_task_wpagui`

   * Install script ``contrib/wpa_ctl``. Quoting:

     .. pull-quote::

        ``wpa_ctl`` facilitates the control of wireless interfaces
        without the NetworkManager (NM). Typically, it brings up an
        interface and starts wpa_supplicant. Optionally, it starts
        also wpa_cli and wpa_gui. You have to disable NM and
        wpa_supplicant services if you want to use wpa_gui. Do not
        configure the interface in netplan if you want to use
        wpa_cli. See the notes. Run 'wpa_ctl -n'.

Examples
^^^^^^^^

.. toctree::

   guide-tasks/wpasupplicant-ex1
   guide-tasks/wpasupplicant-ex2


.. _wpa_supplicant: https://w1.fi/wpa_supplicant/
.. _netplan: https://netplan.readthedocs.io/en/stable/
.. _Properties for device type wifis: https://netplan.readthedocs.io/en/stable/netplan-yaml/#properties-for-device-type-wifis
.. _NetworkManager default configuration: https://netplan.readthedocs.io/en/stable/nm-all/#networkmanager-default-configuration
.. _networkd: https://manpages.ubuntu.com/manpages/noble/man8/systemd-networkd.service.8.html
.. _wpa_cli: https://manpages.ubuntu.com/manpages/noble/man8/wpa_cli.8.html
.. _wpa_gui: https://manpages.ubuntu.com/manpages/noble/man8/wpa_gui.8.html
.. _D-Bus: https://www.freedesktop.org/wiki/Software/dbus/
.. _nl80211: https://wireless.wiki.kernel.org/en/developers/documentation/nl80211
.. _wext: https://wireless.wiki.kernel.org/en/developers/documentation/wireless-extensions
