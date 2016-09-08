linux-postinstall
=================

[![Build Status](https://travis-ci.org/vbotka/ansible-linux-postinstall.svg?branch=master)](https://travis-ci.org/vbotka/ansible-linux-postinstall)
[![license](https://img.shields.io/badge/license-BSD-red.svg)](https://www.freebsd.org/doc/en/articles/bsdl-gpl/article.html)

Ansible role. Configure Linux (wpagui, ... wip).

https://galaxy.ansible.com/vbotka/linux-postinstall/

Test in progress with Ubuntu 16.04


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
ansible-galaxy install vbotka.ansible-linux-postinstall
```

3) Fit variables.

```
~/.ansible/roles/vbotka.ansible-linux-postinstall/vars/main.yml
```

4) Create playbook and inventory.

Remote host
```
> cat ~/.ansible/playbooks/linux-postinstall.yml
---
- hosts: linux-test
  roles:
    - role: vbotka.ansible-linux-postinstall
```

```
> cat ~/.ansible/hosts
[linux-test]
<MAILSERVER-IP-OR-FQDN>

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
    - vbotka.ansible-linux-postinstall
```


License
-------

BSD


Author Information
------------------

[Vladimir Botka](https://botka.link)
