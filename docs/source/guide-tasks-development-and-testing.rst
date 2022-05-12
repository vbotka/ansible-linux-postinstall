.. _ug_task_development_and_testing:

Development and testing
-----------------------

In order to deliver an Ansible project it's necessary to test the code
and configuration. The tags provide the administrators with a tool to
test single tasks' files and single tasks. For example, to test single
tasks at single remote host *test_01*, create a playbook

.. code-block:: YAML
   :emphasize-lines: 1

   shell> cat lp.yml
   - hosts: test_01
     become: true
     roles:
       - vbotka.linux_postinstall

Customize configuration in ``host_vars/test_01/lp-*.yml`` and `check the syntax`

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml --syntax-check

Then `dry-run` the selected task and see what will be changed. Replace
<tag> with valid tag or with a comma-separated list of tags

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t <tag> --check --diff

When all seems to be ready run the command. Run the command twice and
make sure the playbook and the configuration is `idempotent`

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t <tag>

.. seealso::
   * Periodically run playbooks from cron by *ansible-runner*
     `ansible-cron-audit.bash <https://github.com/vbotka/ansible-runner/blob/master/contrib/ansible-cron-audit.bash>`_
   * *ansible-runner* wrapper
     `arwrapper.bash <https://github.com/vbotka/ansible-runner/blob/master/contrib/arwrapper.bash>`_
