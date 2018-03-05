linux-postinstall
=================

[![Build Status](https://travis-ci.org/vbotka/ansible-linux-postinstall.svg?branch=master)](https://travis-ci.org/vbotka/ansible-linux-postinstall)

[Ansible role.](https://galaxy.ansible.com/vbotka/linux-postinstall/) Configure Linux.

- aliases
- apparmor
- authorized keys
- automatic upgrades
- bluetooth
- cron
- gpsd
- grub
- hostname and hosts
- iptables
- latex
- modem manager
- modules
- packages, repos, keys
- pm-utils
- postfix
- smart
- ssh
- sshd
- sysctl
- udev
- users
- virtualbox
- wpa_gui
- xen
- xorg.conf.d
- (wip ...)


Requirements
------------

None.


Variables
---------

TBD (Check the defaults).


Workflow
--------

1) Install role.

```
ansible-galaxy install vbotka.linux-postinstall
```

2) Fit variables.

```
~/.ansible/roles/vbotka.linux-postinstall/vars/main.yml
```

3) Create playbook and inventory.

Remote host
```
> cat ~/.ansible/playbooks/linux-postinstall.yml
---
- hosts: linux-test
  roles:
    - role: vbotka.linux-postinstall
```

```
> cat ~/.ansible/hosts
[linux-test]
<IP-OR-FQDN>

[linux-test:vars]
ansible_connection=ssh
ansible_user=root
ansible_python_interpreter=/usr/bin/python2.7
ansible_perl_interpreter=/usr/bin/perl
```

Localhost
```
> cat ~/.ansible/playbooks/linux-postinstall.yml

---

- hosts: localhost
  connection: local
  become_user: my_user_name
  become: yes
  become_method: sudo
  vars_files:
    - ~/.ansible/vars/localhost.yml
  roles:
    - vbotka.linux-postinstall
```


License
-------

[![license](https://img.shields.io/badge/license-BSD-red.svg)](https://www.freebsd.org/doc/en/articles/bsdl-gpl/article.html)


Author Information
------------------

[Vladimir Botka](https://botka.link)


References
----------

- [AppArmor wiki](https://gitlab.com/apparmor/apparmor/wikis/home)
- [AppArmor wiki Ubuntu](https://wiki.ubuntu.com/AppArmor)
- [AppArmor wiki Ubuntu community](https://help.ubuntu.com/community/AppArmor)
- [Automatic Updates](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)
- [Bluetooth headphones](https://bbs.archlinux.org/viewtopic.php?id=212785)
- [Cron CronHowto](https://help.ubuntu.com/community/CronHowto)
- [GCP: Configuring Imported Images](https://cloud.google.com/compute/docs/images/configuring-imported-images)
- [GPSD Bluetooth](https://ubuntuforums.org/showthread.php?t=200142)
- [GPSD Troubleshooting](http://www.catb.org/gpsd/troubleshooting.html)
- [GPSD cannot create rfcomm0](https://stackoverflow.com/questions/33892280/debian-cannot-create-rfcomm0)
- [GRUB](https://help.ubuntu.com/community/Grub2)
- [LaTeX](https://help.ubuntu.com/community/LaTeX)
- [LaTeX CTAN: Comprehensive TEX Archive Network](https://ctan.org/)
- [LaTeX macros/latex/contrib/labels](https://www.ctan.org/tex-archive/macros/latex/contrib/labels)
- [ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/)
- [ModemManager. Remove from boot](https://askubuntu.com/questions/216114/how-can-i-remove-modem-manager-from-boot)
- [NetworkManager disabling](https://help.ubuntu.com/community/NetworkManager#Disabling_NetworkManager)
- [PM pm-utils](https://wiki.archlinux.org/index.php/pm-utils)
- [Postfix Basic Setup Howto](https://help.ubuntu.com/community/PostfixBasicSetupHowto)
- [SMART wiki](https://en.wikipedia.org/wiki/S.M.A.R.T.)
- [Smartmontools](https://www.smartmontools.org/)
- [Smartmontools Ubuntu](https://help.ubuntu.com/community/Smartmontools)
- [udev - Linux dynamic device management](https://wiki.debian.org/udev)
- [VirtualBox wiki](https://www.virtualbox.org/wiki/)
- [Xen](https://wiki.ubuntu.com/Kernel/Reference/Xen)
- [Xen Tuning Xen for Performance](https://wiki.xenproject.org/wiki/Tuning_Xen_for_Performance)
- [Xen Project Best Practices](https://wiki.xenproject.org/wiki/Xen_Project_Best_Practices)
- [Xorg Guide](https://wiki.gentoo.org/wiki/Xorg/Guide)
