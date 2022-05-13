.. _ug_tags:

Tags
====

The `tags` provide the user with a very useful tool to run selected
tasks of the role. To see what tags are available list the tags of the
role by the command


.. literalinclude:: guide-tags/code01.yaml.example
   :language: YAML
   :emphasize-lines: 1


.. _ug_tags_examples:

Examples
--------

* Display the list of the variables and their values with the tag
  ``lp_debug`` (when the `debug` is enabled ``lp_debug: true``)

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_debug

* See what packages will be installed

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_packages --check

* Install packages and exit the play

.. code-block:: Bash
   :emphasize-lines: 1

   shell> ansible-playbook lp.yml -t lp_packages
