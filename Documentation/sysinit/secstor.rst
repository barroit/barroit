.. SPDX-License-Identifier: GPL-3.0-or-later

==============
Secret Storage
==============

In this document, *secstor* refers to ``secret storage``. This storage must
contain necessary GPG-encrypted files. Currently they are:

   - id_dev_macos.gpg
   - id_dev_ubuntu.gpg
   - id_github.gpg
   - id_lvm_freebsd.gpg
   - id_lvm_noble.gpg
   - id_lvm_windows.gpg
   - id_oci_noble.gpg
   - pg_git_tag.gpg
   - rclone.conf.gpg
   - token_discot.gpg

Missing some of the ``id_*.gpg`` files won't break script execution. It'll
continue with warning messages.

Some setup scripts expect the secstor to be mounted at a platform-specific
path:

.. list-table::
   :header-rows: 1
   :widths: 25 25

   * - OS
     - Location
   * - Ubuntu
     - /media/$(whoami)/secret
   * - macOS
     - /Volumes/secret

If you don't do this, some setup scripts fail, like:

   - macos/10-key.sh
   - macos/80-wasabi.sh
   - ubuntu/10-key.sh
   - ubuntu/80-wasabi.sh
