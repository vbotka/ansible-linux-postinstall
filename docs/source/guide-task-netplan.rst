.. _ug_task_netplan:

Netplan
-------

Synopsis
^^^^^^^^

The network configuration abstraction renderer.

.. warning::
   * Quoting from `About NetworkManager
     <https://core.docs.ubuntu.com/en/stacks/network/network-manager/docs/>`_:
     "By default network management on Ubuntu Core is handled by
     systemd's networkd and netplan. However, when NetworkManager is
     installed, it will take control of all networking devices in the
     system by creating a netplan configuration file in which it sets
     itself as the default network renderer."

.. seealso::
   * Annotated Source code :ref:`as_netplan.yml`
   * Annotated Template :ref:`as_template_netplan_default.j2`
   * Annotated Template :ref:`as_template_netplan_conf.j2`
   * Project website `netplan.io <https://netplan.io/>`_
   * See :ref:`ug_task_networkmanager_ex1`

Examples
^^^^^^^^

.. toctree::

   guide-tasks/netplan-ex1
   guide-tasks/netplan-ex2
