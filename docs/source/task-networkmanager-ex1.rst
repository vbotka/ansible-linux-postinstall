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
     - {key: managed, val: 'false'}
   lp_nm_mask: true

Disable :index:`NetworkManager`

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-playbook linux-postinstall.yml -t lp_nm

   TASK [vbotka.linux_postinstall : nm: Create /etc/init/network-manager.override]
   ok: [plana]

   TASK [vbotka.linux_postinstall : nm: Remove /etc/init/network-manager.override]
   skipping: [plana]

   TASK [vbotka.linux_postinstall : nm: Configure /etc/NetworkManager/NetworkManager.conf]
   ok: [plana] => (item={'key': 'managed', 'val': 'false'})

   TASK [vbotka.linux_postinstall : nm: Start and enable NM services] ***********
   skipping: [plana] => (item=NetworkManager.service)
   skipping: [plana] => (item=NetworkManager-wait-online.service)
   skipping: [plana] => (item=NetworkManager-dispatcher.service)
   skipping: [plana] => (item=network-manager.service)
   skipping: [plana] => (item=wpa_supplicant.service)

   TASK [vbotka.linux_postinstall : nm: Stop and disable NM services] ***********
   ok: [plana] => (item=NetworkManager.service)
   ok: [plana] => (item=NetworkManager-wait-online.service)
   ok: [plana] => (item=NetworkManager-dispatcher.service)
   ok: [plana] => (item=network-manager.service)
   ok: [plana] => (item=wpa_supplicant.service)

   TASK [vbotka.linux_postinstall : nm: Unmask NM services] *********************
   skipping: [plana] => (item=NetworkManager.service)

   TASK [vbotka.linux_postinstall : nm: Mask NM services] ***********************
   ok: [plana] => (item=NetworkManager.service)

   
Show the status of *NetworkManager.service*
   
.. code-block:: sh
   :emphasize-lines: 1

   test_01> systemctl status NetworkManager.service

   ● NetworkManager.service
        Loaded: masked (Reason: Unit NetworkManager.service is masked.)
	     Active: inactive (dead)
