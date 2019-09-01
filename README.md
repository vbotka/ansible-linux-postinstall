# linux_postinstall

[![Build Status](https://travis-ci.org/vbotka/ansible-linux-postinstall.svg?branch=master)](https://travis-ci.org/vbotka/ansible-linux-postinstall)

[Ansible role.](https://galaxy.ansible.com/vbotka/linux_postinstall/)

Configure Linux: acpi, aliases, apparmor, authorized keys, autofs, automatic upgrades, bluetooth, cron, fstab, gpsd, grub, hostname, hosts, iptables, kvm, latex, libvirt, lid, logrotate, modem manager, modules, netplan, nfsd, packages, pm-utils, postfix, repos, service, smart, speech-dispatcher, ssh, sshd, sudoers, swap, sysctl, timesyncd, timezone, tlp, udev, ufw, users, virtualbox, wpa_gui, wpa_supplicant, xen, xorg.conf.d, zfs, (wip ...)

Tested with Ubuntu 18.04. Some tasks tested with CentOS 7 and Armbian 5.90.


## Requirements

None.


## Variables

Read the defaults and examples in vars.


## Workflow

1. Install the role.
```
# ansible-galaxy install vbotka.linux_postinstall
```

2. Change variables.
```
# editor vbotka.linux_postinstall/vars/main.yml
```
* Review OS specific variables in *vars/defaults*.
* Review, customize and/or add Flavor specific variables in *vars/flavors*.
* Optionally disable *lp_flavors_enable: false*. This will speedup the playbook.
* Optionally put customized OS specific variables into the *vars* directory.
* See *tasks/vars.yml* for the naming conventions and precedence.
* Os specific variables will overwrite variables in *var/main.yml*.

3. Create the inventory.
```
# cat hosts
[host1]
host1.example.com
[host1:vars]
ansible_user: admin
ansible_connection=ssh
ansible_python_interpreter=/usr/bin/python3.6
ansible_perl_interpreter=/usr/bin/perl
```

4. Create the playbook.
```
# cat linux-postinstall.yml
- hosts: host1
  become: yes
  become_user: root
  become_method: sudo
  roles:
    - vbotka.linux_postinstall
```

5. Run the playbook.
```
# ansible-playbook linux-postinstall.yml
```


## Best practice

Perform syntax check of the playbook
```
# ansible-playbook linux-postinstall.yml --syntax-check
```
Run the playbook in in check mode first
```
# ansible-playbook linux-postinstall.yml --check
```
If all is right run the playbook twice. In second run all tasks shall
be OK and 0 changed, unreachable and failed.
```
# ansible-playbook linux-postinstall.yml
```


## Auto-installation of packages

Packages listed in the variables lp_*_packages will be automatically
installed by the tasks/packages.yml if enabled by variable lp_* . For
example
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
the lp_libvirt_packages will be included in the packages installed by
```
# ansible-playbook linux-postinstall.yml -t lp_packages
```


## Auto-management of services

Variable `lp_service_enable` contains a list of services automatically managed by the task [service.yml](tasks/service.yml). A *service* will be manged by the task [service.yml](tasks/service.yml) if `lp_<service>: true`. Setting `lp_<service>: false` will disable management of the *service* by the task [service.yml](tasks/service.yml). Variable `lp_<service>_enable` controls the status of the *service*. For example service *udev* will be enabled, because it is listed among `lp_service_enable` and by default
```
lp_udev: true
lp_udev_enable: true
```
Run the following command to see what services will be managed.
```
# ansible-playbook linux-postinstall.yml -e lp_service_debug=true -t lp_service_debug
```
See [service.yml](tasks/service.yml) for details.


## Recommended configuration after the installation of OS

1. Configure users, sudoers and persistent network interfaces

```
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
# ansible-playbook linux-postinstall.yml -t lp_iptables
```

3. Test installation of the packages

```
ansible-playbook -t lp_packages -e 'lp_package_install_dryrun=true' linux-postinstall.yml
```

4. Install packages

```
ansible-playbook -t lp_packages linux-postinstall.yml
```

5. Check, install and configure other tasks

```
ansible-playbook linux-postinstall.yml --check
ansible-playbook linux-postinstall.yml
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
- [AppArmor wiki](https://gitlab.com/apparmor/apparmor/wikis/home)
- [AppArmor wiki Ubuntu](https://wiki.ubuntu.com/AppArmor)
- [AppArmor wiki Ubuntu community](https://help.ubuntu.com/community/AppArmor)
- [Automatic Updates](https://help.ubuntu.com/lts/serverguide/automatic-updates.html)
- [Autofs - Ubuntu community](https://help.ubuntu.com/community/Autofs)
- [Bluetooth headphones](https://bbs.archlinux.org/viewtopic.php?id=212785)
- [Cron CronHowto](https://help.ubuntu.com/community/CronHowto)
- [GCP: Configuring Imported Images](https://cloud.google.com/compute/docs/images/configuring-imported-images)
- [GPSD Bluetooth](https://ubuntuforums.org/showthread.php?t=200142)
- [GPSD Troubleshooting](http://www.catb.org/gpsd/troubleshooting.html)
- [GPSD cannot create rfcomm0](https://stackoverflow.com/questions/33892280/debian-cannot-create-rfcomm0)
- [GRUB](https://help.ubuntu.com/community/Grub2)
- [Iptables HowTo](https://help.ubuntu.com/community/IptablesHowTo)
- [KVM Ubuntu](https://help.ubuntu.com/community/KVM)
- [LaTeX](https://help.ubuntu.com/community/LaTeX)
- [LaTeX CTAN: Comprehensive TEX Archive Network](https://ctan.org/)
- [LaTeX macros/latex/contrib/](https://www.ctan.org/tex-archive/macros/latex/contrib/)
- [libvirt](https://libvirt.org/)
- [libvirt Ubuntu](https://help.ubuntu.com/lts/serverguide/libvirt.html.en)
- [libvirt Xen4 for CentOS 6 and 7](https://wiki.centos.org/HowTos/Xen/Xen4QuickStart/Xen4Libvirt)
- [Lid Ubuntu](https://askubuntu.com/questions/85705/stop-laptop-from-suspending-when-closing-lid-in-lightdm)
- [ Logrotate - How to Setup and Manage Log Rotation](https://www.tecmint.com/install-logrotate-to-manage-log-rotation-in-linux/)
- [ModemManager](https://www.freedesktop.org/wiki/Software/ModemManager/)
- [ModemManager. Remove from boot](https://askubuntu.com/questions/216114/how-can-i-remove-modem-manager-from-boot)
- [modules - CentOS Persistent Module Loading](https://www.centos.org/docs/5/html/Deployment_Guide-en-US/s1-kernel-modules-persistant.html)
- [modules - Disable and blacklist Linux modules](https://linux-audit.com/kernel-hardening-disable-and-blacklist-linux-modules/)
- [NTP - Time Synchronization Ubuntu](https://help.ubuntu.com/lts/serverguide/NTP.html)
- [Netplan](https://netplan.io/)
- [NetworkManager disabling](https://help.ubuntu.com/community/NetworkManager#Disabling_NetworkManager)
- [NFS Centos](https://www.centos.org/docs/5/html/5.2/Deployment_Guide/ch-nfs.html)
- [NFS Ubuntu](https://help.ubuntu.com/lts/serverguide/network-file-system.html)
- [Packages Ubuntu - How to prevent updating of a specific package?](https://askubuntu.com/questions/18654/how-to-prevent-updating-of-a-specific-package)
- [PM pm-utils](https://wiki.archlinux.org/index.php/pm-utils)
- [Postfix Basic Setup Howto](https://help.ubuntu.com/community/PostfixBasicSetupHowto)
- [SMART wiki](https://en.wikipedia.org/wiki/S.M.A.R.T.)
- [Smartmontools](https://www.smartmontools.org/)
- [Smartmontools Ubuntu](https://help.ubuntu.com/community/Smartmontools)
- [speech-dispatcher](https://freebsoft.org/speechd)
- [ssh_config man](https://man.openbsd.org/ssh_config)
- [SwapFaq](https://help.ubuntu.com/community/SwapFaq)
- [TLP - Linux Advanced Power Management Tool](https://linrunner.de/en/tlp/tlp.html)
- [timesyncd](https://www.freedesktop.org/software/systemd/man/systemd-timesyncd.service.html#)
- [udev - Linux dynamic device management](https://wiki.debian.org/udev)
- [ufw - Ubuntu Wiki UncomplicatedFirewall](https://wiki.ubuntu.com/UncomplicatedFirewall)
- [VirtualBox wiki](https://www.virtualbox.org/wiki/)
- [VirtualBox - Ubuntu community](https://help.ubuntu.com/community/VirtualBox)
- [VirtualBox - Install Oracle VM VirtualBox in Ubuntu](http://www.elinuxbook.com/install-oracle-vm-virtualbox-in-ubuntu-16-04/)
- [wpa_supplicant](https://w1.fi/wpa_supplicant/)
- [wpa_supplicant.conf](https://w1.fi/cgit/hostap/plain/wpa_supplicant/wpa_supplicant.conf)
- [Xen Ubuntu Help](https://help.ubuntu.com/community/Xen)
- [Xen Ubuntu Wiki](https://wiki.ubuntu.com/Kernel/Reference/Xen)
- [Xen Tuning for Performance](https://wiki.xenproject.org/wiki/Tuning_Xen_for_Performance)
- [Xen Project Best Practices](https://wiki.xenproject.org/wiki/Xen_Project_Best_Practices)
- [Xorg Guide](https://wiki.gentoo.org/wiki/Xorg/Guide)
- [ZFS Ubuntu Wiki](https://wiki.ubuntu.com/ZFS)
