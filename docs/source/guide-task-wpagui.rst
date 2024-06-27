.. _ug_task_wpagui:

wpa_gui
-------

Synopsis
^^^^^^^^

Project `wpa_supplicant`_ provides the complete set of utilities to configure wireless interfaces

* `wpa_supplicant - Wi-Fi Protected Access client and IEEE 802.1X supplicant <https://manpages.ubuntu.com/manpages/noble/man8/wpa_supplicant.8.html>`_
* `wpa_cli - WPA command line client <https://manpages.ubuntu.com/manpages/noble/man8/wpa_cli.8.html>`_
* `wpa_gui - WPA Graphical User Interface <https://manpages.ubuntu.com/manpages/noble/man8/wpa_gui.8.html>`_

Instead of ``NetworkManager`` you can use `wpa_gui`_ to configure and manage wireless interafces.
  
.. seealso::

   * tasks :ref:`as_wpagui.yml`
   * NetworkManager :ref:`ug_task_networkmanager_ex1`
   * :ref:`ug_task_wpasupplicant`

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
     
Enable tasks import and install wpa_qui
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

By default, the management of *wpa_gui* is disabled

.. code-block:: yaml

   - name: Import wpagui.yml
     ansible.builtin.import_tasks: wpagui.yml
     when: ((ansible_os_family == 'RedHat') or
           (ansible_os_family == 'Debian')) and lp_wpagui|bool
     tags: lp_wpagui

Enable it if you want to proceed ::

  lp_wpagui: true

If you want to install or upgrade wpa_supplicant set ::

  lp_wpagui_install: true

Run the play ::

  (env) > ansible-playbook lp.yml -t lp_wpagui
  
Run wpa_gui
^^^^^^^^^^^

* In a desktop, you will probably start *wpa_gui* in the system tray
  by the window manager.

* Optionally, as a user, you can run *wpa_gui* from the command line ::

    test_01> wpa_gui -t -i wlan0 -p /var/run/wpa_supplican &

* Optionally, as a root, you can run the script *wpa_ctl* to
  initialize an interface ::

    test_01> wpa_ctl wlan0
    [OK]  wpa_ctl: wpa_supplicant is running on wlan0
    [OK]  wpa_ctl: wpa_gui is running

.. note:: Install the script *wpa_ctl* from the role's directory ``contrib``

See below the example of running processes ::

  test_01> ps ax | grep wpa
   3455 ?        Ss     0:00 /usr/sbin/wpa_supplicant -B -iwlan0 -P/var/run/wpa_supplicant.wlan0.pid -c/etc/wpa_supplicant/wpa_supplicant-wlan0.conf -f/var/log/wpa_supplicant.wlan0.log
   3858 pts/2    Sl     0:00 wpa_gui -t -i wlan0 -p /var/run/wpa_supplicant


.. _wpa_supplicant: https://w1.fi/wpa_supplicant/
.. _netplan: https://netplan.readthedocs.io/en/stable/
.. _Properties for device type wifis: https://netplan.readthedocs.io/en/stable/netplan-yaml/#properties-for-device-type-wifis
.. _NetworkManager default configuration: https://netplan.readthedocs.io/en/stable/nm-all/#networkmanager-default-configuration
.. _networkd: https://manpages.ubuntu.com/manpages/noble/man8/systemd-networkd.service.8.html
.. _wpa_cli: https://manpages.ubuntu.com/manpages/noble/man8/wpa_cli.8.html
.. _wpa_gui: https://manpages.ubuntu.com/manpages/noble/man8/wpa_gui.8.html
