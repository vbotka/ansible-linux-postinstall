.. _ug_installation:

Installation
============

The most convenient way how to install an Ansible role is to use
:index:`Ansible Galaxy` CLI
`ansible-galaxy <https://docs.ansible.com/ansible/latest/cli/ansible-galaxy.html>`_.
The utility comes with the standard Ansible package and provides the
user with a simple interface to the Ansible Galaxy's services. For
example, take a look at the current status of the role

.. code-block:: sh
   :emphasize-lines: 1

   shell> ansible-galaxy role info vbotka.linux_postinstall

and install it

.. code-block:: sh
   :emphasize-lines: 1

    shell> ansible-galaxy role install vbotka.linux_postinstall

Install the libraries of tasks

.. code-block:: sh
   :emphasize-lines: 1-2

    shell> ansible-galaxy role install vbotka.ansible_lib
    shell> ansible-galaxy role install vbotka.linux_lib

List installed collection versions

.. code-block:: sh
   :emphasize-lines: 1-3

   shell> ansible-galaxy collection list ansible.posix
   shell> ansible-galaxy collection list ansible.utils
   shell> ansible-galaxy collection list community.general

Optionally, upgrade the latest collections

.. code-block:: sh
   :emphasize-lines: 1-3

   shell> ansible-galaxy collection install --upgrade ansible.posix
   shell> ansible-galaxy collection install --upgrade ansible.utils
   shell> ansible-galaxy collection install --upgrade community.general

.. seealso::
   * `Galaxy User Guide <https://docs.ansible.com/ansible/latest/galaxy/user_guide.html>`_
   * Take a look at other roles ``shell> ansible-galaxy search --author=vbotka``
