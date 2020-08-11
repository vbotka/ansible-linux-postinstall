Flavors specific variables (WIP)
================================

The files in the directories ``vars/flavors`` and
``vars/flavors.incr`` keep :index:`flavors` specific variables. The difference
between them is the method how the files are included.

  * **firstfound**: A file in the directory ``vars/flavors`` in the
    order <TBD> is included with the *lookup plugin* ``first_found``.

  * **incremental**: All files in the directory ``vars/defaults.incr``
    in the order <TBD> are included in the *loop*. The variables in
    the files overwrite each other.

In addition, also files ``defaults.yml`` and/or ``default.yml`` can be
included.

The method is determined by the variable ``lp_vars_flavor`` *(default:
firstfound)*

.. code-block:: yaml
   :emphasize-lines: 1

   lp_vars_flavor: firstfound
   
.. seealso::
   * Annotated Source code :ref:`as_vars-flavors.yml`
   * Annotated Source code :ref:`as_vars-flavors-common.yml`
