Default OS specific variables
=============================

The files in the directories ``vars/defaults`` and
``vars/defaults.incr`` keep :index:`OS specific variables`. The difference
between them is the method how the files are included.

  * **firstfound**: A file in the directory ``vars/defaults`` in the
    order ``ansible_distribution_release``, ``ansible_distribution``,
    and ``ansible_os_family`` is included with the *lookup plugin*
    ``first_found``.

  * **incremental**: All files in the directory ``vars/defaults.incr``
    in the order ``ansible_os_family``, ``ansible_distribution``, and
    ``ansible_distribution_release`` are included in the *loop*. The
    variables in the files overwrite each other.

In addition, also files ``defaults.yml`` and/or ``default.yml`` can be
included.

The method is determined by the variable ``lp_vars_distro`` *(default:
firstfound)*

.. code-block:: yaml
   :emphasize-lines: 1

   lp_vars_distro: firstfound

.. warning::
   * Don’t change these file. The changes will be overwritten by the
     update of the role. Customize the default OS values in the files
     placed in the directory ``vars/``
   
.. seealso::
   * Annotated Source code :ref:`as_vars.yml`
   * Annotated Source code :ref:`as_vars_firstfound.yml`
   * Annotated Source code :ref:`as_vars_incremental.yml`
