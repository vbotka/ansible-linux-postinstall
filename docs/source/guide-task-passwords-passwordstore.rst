.. index::
   single: passwordstore

.. _ug_task_passwords_passwordstore:

Passwordstore
-------------

Synopsis
^^^^^^^^

Create, or update passwords of selected users at remote hosts by the
`passwordstore.org <https://www.passwordstore.org/>`_ ``pass`` utility. See details of the included task `al_pws_user_host.yml
<https://raw.githubusercontent.com/vbotka/ansible-lib/master/tasks/al_pws_user_host.yml>`_

.. note::
   * Utility `pass <https://www.passwordstore.org/>`_ is required at controller
   * `GnuPG <https://www.gnupg.org/>`_ is required by ``pass``

Examples
^^^^^^^^

.. toctree::

   guide-tasks/passwords-passwordstore-ex1
   guide-tasks/passwords-passwordstore-ex2
   guide-tasks/passwords-passwordstore-ex3
