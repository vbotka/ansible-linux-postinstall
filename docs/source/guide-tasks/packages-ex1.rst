.. _ug_task_packages_ex1:

Example 1: Install packages automatically
"""""""""""""""""""""""""""""""""""""""""

If enabled ``lp_packages_auto=true`` packages in the dynamically
created list *my_packages_auto* will be installed. This includes
packages listed in the variables ``lp_<name>_packages`` where
``lp_<name>_install`` is ``true``


**Create playbook**

.. code-block:: yaml
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall


**Show variables**

Display the variables::

  shell> ansible-playbook lp.yml -t lp_packages_debug -e lp_packages_debug=True

and take a look at the list *my_packages_auto*. For example,

.. code-block:: yaml

   my_packages_auto:
     - [autofs]
     - [chrony]
     - [debsums]
     - [gnupg, gpg, gpg-agent]
     - [texlive]
     - [logrotate]
     - [pass]
     - [postfix]
     - [resolvconf]
     - [smartmontools]
     - []
     - [tlp, tlp-rdw]
     - [wpasupplicant, wpagui, net-tools, ifupdown, wireless-tools]
     - [wpasupplicant]
     - [zfsutils-linux]


**Install packages listed in my_packages_auto**

.. literalinclude:: examples/packages-ex1-auto.yaml.example
   :language: yaml
   :emphasize-lines: 1
