linux-postinstall
=================

[![Build Status](https://travis-ci.org/vbotka/ansible-linux-postinstall.svg?branch=master)](https://travis-ci.org/vbotka/ansible-linux-postinstall)

[Ansible role.](https://galaxy.ansible.com/vbotka/linux-postinstall/) Configure Linux.

- aliases
- authorized keys
- automatic updates
- bluetooth
- cron
- grub
- hostname and hosts
- iptables
- latex
- modules
- packages, repos, keys
- pm-utils
- ssh
- sshd
- sysctl
- udev
- users
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

- [Automatic Updates](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)
- [GRUB](https://help.ubuntu.com/community/Grub2)
- [LaTeX](https://help.ubuntu.com/community/LaTeX)
- [CTAN: Comprehensive TEX Archive Network](https://ctan.org/)
- [Directory macros/latex/contrib/labels](https://www.ctan.org/tex-archive/macros/latex/contrib/labels)
- [Disabling NetworkManager](https://help.ubuntu.com/community/NetworkManager#Disabling_NetworkManager)
- [Xen](https://wiki.ubuntu.com/Kernel/Reference/Xen)
- [Tuning Xen for Performance](https://wiki.xenproject.org/wiki/Tuning_Xen_for_Performance)
- [Xen Project Best Practices](https://wiki.xenproject.org/wiki/Xen_Project_Best_Practices)
- [pm-utils](https://wiki.archlinux.org/index.php/pm-utils)
- [GCP: Configuring Imported Images](https://cloud.google.com/compute/docs/images/configuring-imported-images)
- [Connect my Bluetooth headphones](https://bbs.archlinux.org/viewtopic.php?id=212785)
- [Xorg Guide](https://wiki.gentoo.org/wiki/Xorg/Guide)
- [CronHowto](https://help.ubuntu.com/community/CronHowto)
