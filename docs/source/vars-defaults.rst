Default variables
=================

The common variables for all distributions are in the directory ``defaults/main/``. These variables
can be customized in the file ``vars/main.yml``. The file ``vars/main.yml`` will be preserved by the
update of the role.

.. warning::
   * Don't make any changes to the file *defaults/main.yml*. The
     changes will be overwritten by the update of the role. Customize
     the default values in the file *vars/main.yml*.

   * Default value of *lp_passwords_debug_classified* and
     *lp_wpasupplicant_debug_classified* is *False*. Passwords will be
     displayed if these variables are enabled.

.. seealso::
   * The examples of the customization ``vars/main.yml.sample``
   * Defaults of *lp_vars_* ``defaults/main/vars.yml``

[`defaults/main/vars.yml <https://github.com/vbotka/ansible-linux-postinstall/blob/master/defaults/main/vars.yml>`_]

.. highlight:: yaml
    :linenothreshold: 5
.. literalinclude:: ../../defaults/main/vars.yml
    :language: yaml
    :emphasize-lines: 2
    :linenos:
