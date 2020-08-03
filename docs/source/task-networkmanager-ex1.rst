Example 1: Disable NetworkManager
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a playbook

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat linux-postinstall.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Create *host_vars/test_01/lp-nm.yml*

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat host_vars/test_01/lp-nm.yml 
   lp_nm: true
   lp_nm_install: false
   lp_nm_enable: false
   lp_nm_conf:
     - {section: ifupdown, key: managed, val: 'false'}
   lp_nm_mask: true

Disable :index:`NetworkManager`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_nm

   TASK [vbotka.linux_postinstall : nm: Create /etc/init/network-manager.override]
   ok: [test_01]

   TASK [vbotka.linux_postinstall : nm: Remove /etc/init/network-manager.override]
   skipping: [test_01]

   TASK [vbotka.linux_postinstall : nm: Configure /etc/NetworkManager/NetworkManager.conf]
   ok: [test_01] => (item={'section': 'ifupdown', 'key': 'managed', 'val': 'false'})

   TASK [vbotka.linux_postinstall : nm: Start and enable NM services] ***********
   skipping: [test_01] => (item=NetworkManager.service)
   skipping: [test_01] => (item=NetworkManager-wait-online.service)
   skipping: [test_01] => (item=NetworkManager-dispatcher.service)
   skipping: [test_01] => (item=network-manager.service)
   skipping: [test_01] => (item=wpa_supplicant.service)

   TASK [vbotka.linux_postinstall : nm: Stop and disable NM services] ***********
   ok: [test_01] => (item=NetworkManager.service)
   ok: [test_01] => (item=NetworkManager-wait-online.service)
   ok: [test_01] => (item=NetworkManager-dispatcher.service)
   ok: [test_01] => (item=network-manager.service)
   ok: [test_01] => (item=wpa_supplicant.service)

   TASK [vbotka.linux_postinstall : nm: Unmask NM services] *********************
   skipping: [test_01] => (item=NetworkManager.service)

   TASK [vbotka.linux_postinstall : nm: Mask NM services] ***********************
   ok: [test_01] => (item=NetworkManager.service)

   
Show the status of *NetworkManager.service*
   
.. code-block:: sh
   :emphasize-lines: 1

   test_01> systemctl status NetworkManager.service

   ● NetworkManager.service
        Loaded: masked (Reason: Unit NetworkManager.service is masked.)
	     Active: inactive (dead)
