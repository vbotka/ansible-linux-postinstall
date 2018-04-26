linux-postinstall
=================

[![Build Status](https://travis-ci.org/vbotka/ansible-linux-postinstall.svg?branch=master)](https://travis-ci.org/vbotka/ansible-linux-postinstall)

[Ansible role.](https://galaxy.ansible.com/vbotka/linux-postinstall/)
Configure Linux: aliases, apparmor, authorized keys, automatic
upgrades, bluetooth, cron, gpsd, grub, hostname, hosts, iptables,
latex, lid, modem manager, modules, nfsd, packages, pm-utils, postfix,
repos, smart, speech-dispatcher, ssh, sshd, sudoers, sysctl, udev,
users, virtualbox, wpa_gui, xen, xorg.conf.d, (wip ...)


Requirements
------------

None. Tested with Ubuntu 18.04.


Variables
---------

Read the defaults and examples in vars.


Workflow
--------

1) Install the role.

```
ansible-galaxy install vbotka.linux-postinstall
```

2) Change variables.

Make global changes in variables
```
roles/vbotka.linux-postinstall/vars/main.yml
```

Put host specific variables to separate files
```
vars/host1.example.com.yml
```

3) Create the inventory.

```
> cat hosts
[host1]
host1.example.com

[host1:vars]
ansible_connection=ssh
ansible_user=root
ansible_python_interpreter=/usr/bin/python2.7
ansible_perl_interpreter=/usr/bin/perl
```

4) Create the playbook.

```
> cat playbooks/linux-postinstall.yml

- hosts: host1
  vars_files:
    - vars/host1.example.com.yml
  roles:
    - role: vbotka.linux-postinstall
```

5) Run the playbook.
```
> ansible-playbook playbooks/linux-postinstall.yml
```

Best practice
-------------

Perform syntax check of the playbook
```
> ansible-playbook playbooks/linux-postinstall.yml --syntax-check
```

Run the playbook in in check mode first
```
> ansible-playbook playbooks/linux-postinstall.yml --check
```

If all is right run the playbook twice. In second run all tasks shall
be OK and 0 changed, unreachable and failed.
```
> ansible-playbook playbooks/linux-postinstall.yml
```

Recommended configuration after the installation of OS
------------------------------------------------------

1) Configure users, sudoers and persistent network interfaces
```
> ansible-playbook playbooks/linux-postinstall.yml -t lp_users
> ansible-playbook playbooks/linux-postinstall.yml -t lp_sudoers
> ansible-playbook playbooks/linux-postinstall.yml -t lp_udev
```

2) Reboot

3) Configure iptables
```
> ansible-playbook playbooks/linux-postinstall.yml -t lp_iptables
```

4) Configure network connection

5) Configure other tasks
```
> ansible-playbook playbooks/linux-postinstall.yml
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
- [Iptables HowTo](https://help.ubuntu.com/community/IptablesHowTo)
- [LaTeX](https://help.ubuntu.com/community/LaTeX)
- [LaTeX CTAN: Comprehensive TEX Archive Network](https://ctan.org/)
- [LaTeX macros/latex/contrib/labels](https://www.ctan.org/tex-archive/macros/latex/contrib/labels)
- [ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/)
- [ModemManager. Remove from boot](https://askubuntu.com/questions/216114/how-can-i-remove-modem-manager-from-boot)
- [NetworkManager disabling](https://help.ubuntu.com/community/NetworkManager#Disabling_NetworkManager)
- [NFS Centos](https://www.centos.org/docs/5/html/5.2/Deployment_Guide/ch-nfs.html)
- [NFS Ubuntu](https://help.ubuntu.com/lts/serverguide/network-file-system.html)
- [PM pm-utils](https://wiki.archlinux.org/index.php/pm-utils)
- [Postfix Basic Setup Howto](https://help.ubuntu.com/community/PostfixBasicSetupHowto)
- [SMART wiki](https://en.wikipedia.org/wiki/S.M.A.R.T.)
- [Smartmontools](https://www.smartmontools.org/)
- [Smartmontools Ubuntu](https://help.ubuntu.com/community/Smartmontools)
- [speech-dispatcher](https://freebsoft.org/speechd)
- [ssh_config man](https://man.openbsd.org/ssh_config)
- [udev - Linux dynamic device management](https://wiki.debian.org/udev)
- [VirtualBox wiki](https://www.virtualbox.org/wiki/)
- [Install Oracle VM VirtualBox in Ubuntu](http://www.elinuxbook.com/install-oracle-vm-virtualbox-in-ubuntu-16-04/)
- [Xen](https://wiki.ubuntu.com/Kernel/Reference/Xen)
- [Xen Tuning Xen for Performance](https://wiki.xenproject.org/wiki/Tuning_Xen_for_Performance)
- [Xen Project Best Practices](https://wiki.xenproject.org/wiki/Xen_Project_Best_Practices)
- [Xorg Guide](https://wiki.gentoo.org/wiki/Xorg/Guide)
