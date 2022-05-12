.. _ug_playbook:

Playbook
========

Below is a simple playbook that calls this role (10) at a single host
srv.example.com (2)

.. code-block:: bash
   :emphasize-lines: 1
   :linenos:

   shell> cat lp.yml
   - hosts: srv.example.com
     gather_facts: true
     connection: ssh
     remote_user: admin
     become: yes
     become_user: root
     become_method: sudo
     roles:
       - vbotka.linux_postinstall


By default, all functionality of the role is disabled. This means that
running the above playbook with default variables won't make any
changes. See ``tasks/main.yml`` on how to enable particular subsystems
either by dedicated Boolean variables or by the non-empty lists.

.. note:: ``gather_facts: true`` (3) must be set to gather facts
   needed to evaluate :index:`OS-specific options` of the role. For example, to
   install packages, the variable ``ansible_os_family`` is needed to
   select the appropriate Ansible module.

.. seealso::
   * For details see `Connection Plugins <https://docs.ansible.com/ansible/latest/plugins/connection.html>`_ (4-5)
   * See also `Understanding Privilege Escalation <https://docs.ansible.com/ansible/latest/user_guide/become.html#understanding-privilege-escalation>`_ (6-8)
