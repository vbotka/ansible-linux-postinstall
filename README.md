# linux_postinstall

[![Build Status](https://travis-ci.org/vbotka/ansible-linux-postinstall.svg?branch=master)](https://travis-ci.org/vbotka/ansible-linux-postinstall)[![Documentation Status](https://readthedocs.org/projects/docs/badge/?version=latest)](https://ansible-linux-postinstall.readthedocs.io/en/latest/)

[Ansible role.](https://galaxy.ansible.com/vbotka/linux_postinstall/) Configure Linux: acpi, aliases, apparmor, apt, authorized keys, autofs, automatic upgrades, bluetooth, cron, debsums, fstab, gpg, gpsd, grub, hostname, hosts, iptables, kvm, latex, libvirt, lid, logrotate, modem manager, modules, netplan, networkd, networkmanager, nfsd, packages, passwords, pm-utils, postfix, repos, resolvconf, service, smart, speech-dispatcher, ssh, sshd, sudoers, swap, sysctl, systemd, timesyncd, timezone, tlp, udev, ufw, users, virtualbox, wpa_gui, wpa_supplicant, xen, xorg.conf.d, zfs, (wip ...)

[Documentation at readthedocs.io](https://ansible-linux-postinstall.readthedocs.io)

This role and the documentation is work in progress. if the documentation of a task is missing it's necessary to review the [source code](https://github.com/vbotka/ansible-linux-postinstall/tree/master/tasks) to learn how to use it.

Feel free to [share your feedback and report issues](https://github.com/vbotka/ansible-linux-postinstall/issues). Contributions are welcome.


## Supported platforms

This role has been developed and tested with
* [Ubuntu Supported Releases](http://releases.ubuntu.com/)
* Armbian 5.90

This may be different from the platforms in Ansible Galaxy which does not offer all
released versions in time and would report an error. For example:
`IMPORTER101: Invalid platform: "Ubuntu focal", skipping.`


## Requirements

* [ansible_lib](https://galaxy.ansible.com/vbotka/ansible_lib)


## Role Variables

Read the defaults and examples in vars.


## Workflow

1. Install the role

```
shell> ansible-galaxy install vbotka.linux_postinstall
```

2. Change variables

```
shell> editor vbotka.linux_postinstall/vars/main.yml
```

* Review OS specific variables in *vars/defaults*
* Review, customize and/or add Flavor specific variables in *vars/flavors*
* Optionally disable *lp_flavors_enable: false*. This will speedup the playbook
* Optionally put customized OS specific variables into the *vars* directory
* See *tasks/vars.yml* for the naming conventions and precedence
* Os specific variables will overwrite variables in *var/main.yml*

3. Create the inventory

```
shell> cat hosts
[host1]
host1.example.com
[host1:vars]
ansible_user: admin
ansible_connection=ssh
ansible_python_interpreter=/usr/bin/python3.7
ansible_perl_interpreter=/usr/bin/perl
```

4. Create the playbook

```
shell> cat linux-postinstall.yml
- hosts: host1
  become: yes
  become_user: root
  become_method: sudo
  roles:
    - vbotka.linux_postinstall
```

5. Run the playbook

```
shell> ansible-playbook linux-postinstall.yml
```


## Best practice

Check syntax of the playbook

```
shell> ansible-playbook linux-postinstall.yml --syntax-check
```

Review variables. Optionally detect and store flavors

```
shell> ansible-playbook linux-postinstall.yml -t lp_vars
```

Run the playbook in check mode

```
shell> ansible-playbook linux-postinstall.yml --check
```

If all is right run the playbook twice. In second run all tasks shall be OK and 0 changed, unreachable and failed.

```
shell> ansible-playbook linux-postinstall.yml
```


## Auto-installation of packages

Packages listed in the variables ``lp_*_packages`` will be automatically installed by the tasks/packages.yml if enabled by variable ``lp_*`` . For example

```
lp_libvirt: true
lp_libvirt_packages:
  - libvirt0
  - libvirt-bin
  - libvirt-daemon
  - libvirt-daemon-driver-storage-rbd
  - libvirt-daemon-system
  - virtinst
```

The packages listed in ``lp_libvirt_packages`` will be included in the packages installed by

```
shell> ansible-playbook linux-postinstall.yml -t lp_packages
```


## Auto-management of services

Variable `lp_service_enable` contains a list of services automatically managed by the task [service.yml](tasks/service.yml). A *service* will be manged by the task [service.yml](tasks/service.yml) if `lp_<service>: true`. Setting `lp_<service>: false` will disable management of the *service* by the task [service.yml](tasks/service.yml). Variable `lp_<service>_enable` controls the status of the *service*. For example service *udev* will be enabled, because it is listed among `lp_service_enable` and by default

```
lp_udev: true
lp_udev_enable: true
```

Run the following command to see what services will be managed.

```
shell> ansible-playbook linux-postinstall.yml -e lp_service_debug=true -t lp_service_debug

```
See [service.yml](tasks/service.yml) for details.


## Recommended configuration after the installation of OS

1. Configure users, sudoers and persistent network interfaces

```
ansible-playbook linux-postinstall.yml -t lp_vars
ansible-playbook linux-postinstall.yml -t lp_hostname                                              
ansible-playbook linux-postinstall.yml -t lp_users
ansible-playbook linux-postinstall.yml -t lp_sudoers
ansible-playbook linux-postinstall.yml -t lp_udev                                                  
ansible-playbook linux-postinstall.yml -t lp_netplan                                               
ansible-playbook linux-postinstall.yml -t lp_wpasupplicant                                         
ansible-playbook linux-postinstall.yml -t lp_reboot -e 'lp_reboot=true lp_reboot_force=true'       
```

2. Configure the firewall. For example iptables

```
shell> ansible-playbook linux-postinstall.yml -t lp_iptables
```

3. Test installation of the packages

```
shell> ansible-playbook -t lp_packages -e 'lp_package_install_dryrun=true' linux-postinstall.yml
```

4. Install packages

```
shell> ansible-playbook -t lp_packages linux-postinstall.yml
```

5. Check, install and configure other tasks

```
shell> ansible-playbook linux-postinstall.yml --check
shell> ansible-playbook linux-postinstall.yml
```


## License

[![license](https://img.shields.io/badge/license-BSD-red.svg)](https://www.freebsd.org/doc/en/articles/bsdl-gpl/article.html)


## Author Information

[Vladimir Botka](https://botka.link)


## References

- [Ubuntu Desktop Guide](https://help.ubuntu.com/lts/ubuntu-help/index.html)
- [Ubuntu Server Guide](https://help.ubuntu.com/lts/serverguide/index.html)
- [Armbian linux for ARM development boards](https://docs.armbian.com/)
- [RHEL 7 System Administrator's Guide](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html-single/system_administrators_guide/index)
- [Ubuntu Release Notes](https://wiki.ubuntu.com/BionicBeaver/ReleaseNotes#New_features_in_18.04)

- [ACPI - Ubuntu Wiki](https://wiki.ubuntu.com/DebuggingACPI)
- [AptConfiguration - Debian Wiki](https://wiki.debian.org/AptConfiguration)
- [apt.conf - Ubuntu man](http://manpages.ubuntu.com/manpages/focal/man5/apt.conf.5.html)
- [AppArmor Wiki](https://gitlab.com/apparmor/apparmor/wikis/home)
- [AppArmor - Ubuntu Wiki](https://wiki.ubuntu.com/AppArmor)
- [AppArmor - Ubuntu Help community](https://help.ubuntu.com/community/AppArmor)
- [Automatic Updates - Ubuntu Help](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)
- [Autofs - Ubuntu Help](https://help.ubuntu.com/community/Autofs)
- [Bluetooth headphones](https://bbs.archlinux.org/viewtopic.php?id=212785)
- [Cron Howto - Ubuntu Help](https://help.ubuntu.com/community/CronHowto)
- [Debsums - Debian man](https://manpages.debian.org/stretch/debsums/debsums.1.en.html)
- [GCP Configuring Imported Images](https://cloud.google.com/compute/docs/images/configuring-imported-images)
- [GPG - GnuPG](https://gnupg.org/)
- [GPG - GnuPG HowTo - Ubuntu Help community](https://help.ubuntu.com/community/GnuPrivacyGuardHowto)
- [GPG - OpenPGP Best Practices](https://riseup.net/en/security/message-security/openpgp/gpg-best-practices)
- [GPG - Ubuntu Security Team](https://wiki.ubuntu.com/SecurityTeam/GPGMigration)
- [GPSD Bluetooth](https://ubuntuforums.org/showthread.php?t=200142)
- [GPSD Troubleshooting](http://www.catb.org/gpsd/troubleshooting.html)
- [GPSD cannot create rfcomm0 - SO](https://stackoverflow.com/questions/33892280/debian-cannot-create-rfcomm0)
- [GRUB - Ubuntu Help](https://help.ubuntu.com/community/Grub2)
- [Iptables HowTo - Ubuntu Help community](https://help.ubuntu.com/community/IptablesHowTo)
- [KVM Ubuntu - Ubuntu Help community](https://help.ubuntu.com/community/KVM)
- [LaTeX - Ubuntu Help community](https://help.ubuntu.com/community/LaTeX)
- [LaTeX CTAN: Comprehensive TEX Archive Network](https://ctan.org/)
- [LaTeX CTAN: macros/latex/contrib/](https://www.ctan.org/tex-archive/macros/latex/contrib/)
- [libvirt](https://libvirt.org/)
- [libvirt - Ubuntu Help](https://help.ubuntu.com/lts/serverguide/libvirt.html.en)
- [libvirt Xen4 - CentOS Wiki](https://wiki.centos.org/HowTos/Xen/Xen4QuickStart/Xen4Libvirt)
- [Lid - Ubuntu Ask](https://askubuntu.com/questions/85705/stop-laptop-from-suspending-when-closing-lid-in-lightdm)
- [Logrotate - How to Setup and Manage Log Rotation](https://www.tecmint.com/install-logrotate-to-manage-log-rotation-in-linux/)
- [ModemManager - FreeDesktop Wiki](https://www.freedesktop.org/wiki/Software/ModemManager/)
- [ModemManager. Remove from boot - Ubuntu Ask](https://askubuntu.com/questions/216114/how-can-i-remove-modem-manager-from-boot)
- [modules - CentOS Persistent Module Loading](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-kernel-modules-persistant.html)
- [modules - Disable and blacklist Linux modules](https://linux-audit.com/kernel-hardening-disable-and-blacklist-linux-modules/)
- [NTP - Ubuntu Help](https://help.ubuntu.com/lts/serverguide/NTP.html)
- [Netplan](https://netplan.io/)
- [Network configuration - ArchLinux Wiki](https://wiki.archlinux.org/index.php/Network_configuration)
- [Networkd systemd-networkd - ArchLinux Wiki](https://wiki.archlinux.org/index.php/Systemd-networkd)
- [Networkd Managing WPA wireless with systemd-networkd - ArchLinux BBS](https://bbs.archlinux.org/viewtopic.php?pid=1393759#p1393759)
- [Networkd systemd-networkd - Freedesktop.org](https://www.freedesktop.org/software/systemd/man/systemd-networkd.service.html)
- [Networkd systemd.network - Freedesktop.org](https://www.freedesktop.org/software/systemd/man/systemd.network.html#)
- [NetworkManager disabling - Ubuntu Help](https://help.ubuntu.com/community/NetworkManager#Stopping_and_Disabling_NetworkManager)
- [NFS - Centos](https://www.centos.org/docs/5/html/5.2/Deployment_Guide/ch-nfs.html)
- [NFS - Ubuntu](https://help.ubuntu.com/lts/serverguide/network-file-system.html)
- [Packages - How to prevent updating of a specific package? - Ubuntu Ask](https://askubuntu.com/questions/18654/how-to-prevent-updating-of-a-specific-package)
- [Password(store) - pass the standard Unix password manager](https://www.passwordstore.org/)
- [PM pm-utils - ArchLinux Wiki](https://wiki.archlinux.org/index.php/pm-utils)
- [Postfix Basic Setup Howto - Ubuntu Help](https://help.ubuntu.com/community/PostfixBasicSetupHowto)
- [Smartmontools](https://www.smartmontools.org/)
- [Smartmontools - Ubuntu Help](https://help.ubuntu.com/community/Smartmontools)
- [SMART - Wikipedia](https://en.wikipedia.org/wiki/S.M.A.R.T.)
- [speech-dispatcher](https://freebsoft.org/speechd)
- [SSH - Ubuntu Help](https://help.ubuntu.com/community/SSH/)
- [SSH - OpenSSH](https://www.openssh.com/)
- [SSH - Passwordless Setup on Ubuntu](https://tech.amikelive.com/node-1095/passwordless-ssh-concept-and-how-to-setup-on-ubuntu/)
- [ssh_config man](https://man.openbsd.org/ssh_config)
- [SwapFaq - Ubuntu Help](https://help.ubuntu.com/community/SwapFaq)
- [systemd - Freedesktop.org](https://freedesktop.org/wiki/Software/systemd/)
- [systemd - ArchLinux Wiki](https://wiki.archlinux.org/index.php/Systemd)
- [systemd - Ubuntu Wiki](https://wiki.ubuntu.com/SystemdForUpstartUsers)
- [TLP - Linux Advanced Power Management Tool](https://linrunner.de/en/tlp/tlp.html)
- [timesyncd - FreeDesktop man](https://www.freedesktop.org/software/systemd/man/systemd-timesyncd.service.html#)
- [udev - Debian Wiki ](https://wiki.debian.org/udev)
- [ufw (UncomplicatedFireWall) - Ubuntu Wiki](https://wiki.ubuntu.com/UncomplicatedFirewall)
- [VirtualBox](https://www.virtualbox.org/wiki/)
- [VirtualBox - Ubuntu Help community](https://help.ubuntu.com/community/VirtualBox)
- [VirtualBox - Install Oracle VM VirtualBox in Ubuntu - eLinuxBook](http://www.elinuxbook.com/install-oracle-vm-virtualbox-in-ubuntu-16-04/)
- [wpa_supplicant - upstream](https://w1.fi/wpa_supplicant/)
- [wpa_supplicant.conf - upstream](https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf)
- [wpa_supplicant - ArchLinux Wiki](https://wiki.archlinux.org/index.php/wpa_supplicant)
- [wpa_supplicant 10-wpa_supplicant dhcpcd hook](https://wiki.archlinux.org/index.php/Dhcpcd#10-wpa_supplicant)
- [Xen - Ubuntu Help community](https://help.ubuntu.com/community/Xen)
- [Xen - Ubuntu Wiki](https://wiki.ubuntu.com/Kernel/Reference/Xen)
- [Xen Tuning for Performance - Xen Wiki](https://wiki.xenproject.org/wiki/Tuning_Xen_for_Performance)
- [Xen Project Best Practices - Xen Wiki](https://wiki.xenproject.org/wiki/Xen_Project_Best_Practices)
- [Xorg Guide - Gentoo Wiki](https://wiki.gentoo.org/wiki/Xorg/Guide)
- [ZFS - Ubuntu Wiki](https://wiki.ubuntu.com/ZFS)
