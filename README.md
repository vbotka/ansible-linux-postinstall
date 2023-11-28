# linux_postinstall

[![quality](https://img.shields.io/ansible/quality/27914)](https://galaxy.ansible.com/vbotka/linux_postinstall)[![Build Status](https://app.travis-ci.com/vbotka/ansible-linux-postinstall.svg?branch=master)](https://app.travis-ci.com/vbotka/ansible-linux-postinstall)[![Documentation Status](https://readthedocs.org/projects/docs/badge/?version=latest)](https://ansible-linux-postinstall.readthedocs.io/en/latest/)

[Ansible role.](https://galaxy.ansible.com/vbotka/linux_postinstall/) Configure Linux: acpi,
aliases, apparmor, apt, authorized keys, autofs, automatic upgrades, bluetooth, cron, debsums,
dnsmasq, fstab, gpg, gpsd, groups, grub, hostname, hosts, chrony, iptables, kvm, latex, libvirt,
lid, logrotate, modem manager, modules, netplan, networkd, networkmanager, nfsd, packages,
passwords, pm-utils, postfix, rc.local, repos, resolvconf, service, smart, speech-dispatcher, ssh,
sshd, sudoers, swap, sysctl, systemd, timesyncd, timezone, tlp, udev, ufw, users, virtualbox,
wpa_gui, wpa_supplicant, xen, xorg.conf.d, zfs, (wip ...)

[Documentation at readthedocs.io](https://ansible-linux-postinstall.readthedocs.io)

This role and the documentation is work in progress. If the
documentation of a task is missing it's necessary to review the
[source
code](https://github.com/vbotka/ansible-linux-postinstall/tree/master/tasks)
to learn how to use it. If a functionality is missing consider role
[config_light](https://galaxy.ansible.com/vbotka/config_light). See
various
[examples](https://github.com/vbotka/ansible-config-light/tree/master/contrib). If
*config_light* is not able to do what you want create new tasks.

Feel free to [share your feedback and report issues](https://github.com/vbotka/ansible-linux-postinstall/issues).

[Contributions are welcome](https://github.com/firstcontributions/first-contributions).


## Supported platforms

This role has been developed and tested in
* [Ubuntu Supported Releases](http://releases.ubuntu.com/)
* Armbian 5.90

This may be different from the platforms in Ansible Galaxy which does not offer all
released versions in time and would report an error. For example:
`IMPORTER101: Invalid platform: "Ubuntu focal", skipping.`

Support for other platforms is work in progress. Some tasks are
supported also by Centos. You're encouraged to fit the variables in
*vars/defaults* and test the tasks on your own.


## Requirements

### Roles

* [ansible_lib](https://galaxy.ansible.com/vbotka/ansible_lib)
* [linux_lib](https://galaxy.ansible.com/vbotka/linux_lib)

### Collections

* ansible.posix
* ansible.utils
* community.general


## Role Variables

See defaults and examples in vars.


## Workflow

1. Install the roles and collections

Install roles

```bash
shell> ansible-galaxy role install vbotka.linux_postinstall
shell> ansible-galaxy role install vbotka.ansible_lib
shell> ansible-galaxy role install vbotka.linux_lib
```

The collections ansible.posix and community.general are included in
the mainstream ansible packages. If they are missing install them

```bash
shell> ansible-galaxy collection install ansible.posix
shell> ansible-galaxy collection install ansible.utils
shell> ansible-galaxy collection install community.general
```

2. Change variables, e.g. in vars/main.yml

```bash
shell> editor vbotka.linux_postinstall/vars/main.yml
```

* See OS specific variables in *vars/defaults*
* See examples in *vars/main.yml.sample*
* Customize and/or add Flavor specific variables in *vars/flavors*
* Optionally enable *lp_flavors_enable: true*. This will slowdown the playbook
* Optionally put customized OS specific variables into the *vars* directory
* See *tasks/vars.yml* for the naming conventions and precedence
* OS specific variables will overwrite variables in *var/main.yml*

3. Create the inventory

```ini
shell> cat hosts
[group1]
host1.example.com
[group1:vars]
ansible_user: admin
ansible_connection=ssh
ansible_python_interpreter=/usr/bin/python3.8
ansible_perl_interpreter=/usr/bin/perl
```

4. Create the playbook

```yaml
shell> cat lp.yml
- hosts: group1
  become: yes
  become_user: root
  become_method: sudo
  roles:
    - vbotka.linux_postinstall
```

5. Run the playbook

```bash
shell> ansible-playbook lp.yml
```


## Best practice

Check syntax of the playbook

```bash
shell> ansible-playbook lp.yml --syntax-check
```

Review variables. Optionally detect and store flavors

```bash
shell> ansible-playbook lp.yml -t lp_vars
```

Run the playbook in check mode

```bash
shell> ansible-playbook lp.yml --check
```

If all is right run the playbook twice. In second run all tasks shall be OK and 0 changed, unreachable and failed.

```bash
shell> ansible-playbook lp.yml
```


## Auto-installation of packages

Packages listed in the variables ``lp_*_packages`` will be automatically installed by the tasks/packages.yml if enabled by variables ``lp_*_install`` . For example,

```yaml
lp_libvirt_install: true
lp_libvirt_packages:
  - libvirt0
  - libvirt-bin
  - libvirt-daemon
  - libvirt-daemon-driver-storage-rbd
  - libvirt-daemon-system
  - virtinst
```

The packages listed in ``lp_libvirt_packages`` will be included in the packages installed by

```bash
shell> ansible-playbook lp.yml -t lp_packages_auto -e lp_packages_auto=true
```

See:

* chapter [packages](https://ansible-linux-postinstall.readthedocs.io/en/latest/guide-task-packages.html)
* source code [packages.yml](tasks/packages.yml)


## Auto-management of services

Variable `lp_service_auto` contains a list of services automatically
managed by the task [service.yml](tasks/service.yml). A *service* will
be manged by the task [service.yml](tasks/service.yml) if
`lp_<service>: true`. Setting `lp_<service>: false` will disable
management of the *service* by the task
[service.yml](tasks/service.yml). Variables `lp_<service>_enable` and
`lp_<service>_state` control the enablement and state of the
*service*. For example, service *udev*, if set `lp_udev: true,` will
be enabled and started because it is listed among `lp_service_auto`
and by default ([precedence 2.](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#understanding-variable-precedence)):

```yaml
lp_udev: true
lp_udev_enable: true
lp_udev_state: started
```

Run the below command to see what services will be managed.

```bash
shell> ansible-playbook lp.yml -e lp_service_debug=true -t lp_service_debug

```

See:

* chapter [Service](https://ansible-linux-postinstall.readthedocs.io/en/latest/guide-task-service.html)
* source code [service.yml](tasks/service.yml)


## Recommended configuration after the installation of OS

1. Configure users, sudoers and persistent network interfaces

```bash
ansible-playbook lp.yml -t lp_vars
ansible-playbook lp.yml -t lp_hostname
ansible-playbook lp.yml -t lp_groups
ansible-playbook lp.yml -t lp_users
ansible-playbook lp.yml -t lp_sudoers
ansible-playbook lp.yml -t lp_udev
ansible-playbook lp.yml -t lp_netplan
ansible-playbook lp.yml -t lp_wpasupplicant
ansible-playbook lp.yml -t lp_reboot -e 'lp_reboot=true lp_reboot_force=true'
```

2. Configure the firewall. For example iptables

```bash
shell> ansible-playbook lp.yml -t lp_iptables
```

3. Test installation of the packages

```bash
shell> ansible-playbook -t lp_packages -e 'lp_package_install_dryrun=true' lp.yml
```

4. Install packages

```bash
shell> ansible-playbook -t lp_packages lp.yml
```

5. Check, install and configure other tasks

```bash
shell> ansible-playbook lp.yml --check
shell> ansible-playbook lp.yml
```


## License

[![license](https://img.shields.io/badge/license-BSD-red.svg)](https://www.freebsd.org/doc/en/articles/bsdl-gpl/article.html)


## Author Information

[Vladimir Botka](https://botka.info)


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
- [Dnsmasq - DNS, DHCP, router advertisement and network boot](https://thekelleys.org.uk/dnsmasq/doc.html)
- [Dnsmasq - Ubuntu Help](https://help.ubuntu.com/community/Dnsmasq)
- [GCP Configuring Imported Images](https://cloud.google.com/compute/docs/images/configuring-imported-images)
- [GPG - GnuPG](https://gnupg.org/)
- [GPG - GnuPG HowTo - Ubuntu Help community](https://help.ubuntu.com/community/GnuPrivacyGuardHowto)
- [GPG - OpenPGP Best Practices](https://riseup.net/en/security/message-security/openpgp/gpg-best-practices)
- [GPG - Ubuntu Security Team](https://wiki.ubuntu.com/SecurityTeam/GPGMigration)
- [GPSD Bluetooth](https://ubuntuforums.org/showthread.php?t=200142)
- [GPSD Troubleshooting](http://www.catb.org/gpsd/troubleshooting.html)
- [GPSD cannot create rfcomm0 - SO](https://stackoverflow.com/questions/33892280/debian-cannot-create-rfcomm0)
- [GRUB - Ubuntu Help](https://help.ubuntu.com/community/Grub2)
- [Chrony - implementation of NTP](https://chrony.tuxfamily.org/)
- [Chrony - ArchLinux Wiki](https://wiki.archlinux.org/title/Chrony)
- [Chrony - Ubuntu Blog: Bionic: Using chrony to configure NTP](https://ubuntu.com/blog/ubuntu-bionic-using-chrony-to-configure-ntp)
- [Chrony - RHEL 7 System Administrator's Guide: CHAPTER 18. CONFIGURING NTP USING THE CHRONY SUITE](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-configuring_ntp_using_the_chrony_suite)
- [Chrony - RHEL 7 System Administrator's Guide: CHAPTER 3. CONFIGURING THE DATE AND TIME](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/chap-configuring_the_date_and_time)
- [Iptables HowTo - Ubuntu Help community](https://help.ubuntu.com/community/IptablesHowTo)
- [How To Implement a Basic Firewall Template with Iptables on Ubuntu 14.04 - DO tutorial](https://www.digitalocean.com/community/tutorials/how-to-implement-a-basic-firewall-template-with-iptables-on-ubuntu-14-04)
- [KVM Ubuntu - Ubuntu Help community](https://help.ubuntu.com/community/KVM)
- [LaTeX - Ubuntu Help community](https://help.ubuntu.com/community/LaTeX)
- [LaTeX CTAN: Comprehensive TEX Archive Network](https://ctan.org/)
- [LaTeX CTAN: macros/latex/contrib/](https://www.ctan.org/tex-archive/macros/latex/contrib/)
- [LaTex How to install LaTex on Ubuntu 22.04 Jammy Jellyfish - LinuxConfig](https://linuxconfig.org/how-to-install-latex-on-ubuntu-22-04-jammy-jellyfish-linux)
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
- [rc.local - AskUbuntu: How can I make /etc/rc.local run on startup?](https://askubuntu.com/questions/9853/how-can-i-make-etc-rc-local-run-on-startup)
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
- [timesyncd - ArchLinux Wiki](https://wiki.archlinux.org/title/systemd-timesyncd)
- [timesyncd - AskUbuntu: NTP not supported](https://askubuntu.com/questions/1314479/ntp-not-supported)
- [timesyncd - Centos Forum](https://forums.centos.org/viewtopic.php?t=54021)
- [udev - ArchLinux Wiki](https://wiki.archlinux.org/index.php/Udev)
- [udev - Debian Wiki](https://wiki.debian.org/udev)
- [udev debugging - Ubuntu Wiki](https://wiki.ubuntu.com/DebuggingUdev)
- [UFW - Uncomplicated Firewall - Ubuntu Help](https://help.ubuntu.com/community/UFW/)
- [UFW - Uncomplicated Firewall - Ubuntu Wiki](https://wiki.ubuntu.com/UncomplicatedFirewall)
- [UFW - How do I get ufw to start on boot? - AskUbuntu](https://askubuntu.com/questions/1040539/how-do-i-get-ufw-to-start-on-boot)
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
