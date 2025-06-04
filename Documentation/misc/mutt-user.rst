.. SPDX-License-Identifier: GPL-3.0-or-later

.. _mutt_user_config:

=======================
Mutt User Configuration
=======================

This guide describes steps to configure a mutt user. It only shows how to work
with barroit's config setup. It never talks about mutt's own usage or configs.

You must read configs. This document never explains what a config contains, and
it's not here to hold your hand. It just tells you how to name them and makes
sure you don't fuck up hierarchy.

This document assumes you map config via ``./<consumer>/setup.sh filemap`` in
this repo. See :ref:`sysinit_setup_usage`.

Configuration Hierarchy
=======================

This setup structures configs into a hierarchy. All configs exist in
``$HOME/.mutt``, from root to leaf:

``provider``
	Defines mailboxes and auth method to use. Filename starts with ``@``.

``consumer``
	Defines user info and provider to use. Filename is your email.

``client``
	Defines auth info. Filename is ``client.your_email``.

``auth provider``
	Reads auth info from client in a method-specific way.

Mutt reads ``$HOME/.muttrc``. Muttrc sources consumer, consumer sources
provider, provider sources auth provider, auth provider reads client. This
chain makes it easy to extend or reuse any specific role.

Provider
--------

Each provider maps to a real-world email provider. This setup supports the 
following providers:

   - @gmail.com
   - @naver.com
   - @outlook.com
   - @sunjiamu@outlook.com

``@sunjiamu@outlook.com`` is a special provider. It wraps ``@outlook.com`` and
serves both ``sunjiamu@outlook.com`` and vanity email ``barroit@linux.com``.

Client
------

Client defines fields in key-value pairs:

``id``
	Azure application ID.

``user``
	Your email.

``secret``
	Filename of secret file, relative to ``$HOME/.mutt``.

Auth Methods
------------

This setup supports two auth methods:

   - oauth2
   - password

Each auth method requires client to define specific fields. Table below
describes required fields for each method:

.. list-table::
   :align: left
   :header-rows: 1
   :widths: 50 50 25 25 25

   * - provider
     - method
     - id
     - user
     - secret
   * - Outlook
     - oauth2
     - **\+**
     - **\+**
     - \
   * - Gmail
     - oauth2
     - **\+**
     - **\+**
     - **\+**
   * - NAVER
     - password
     - \
     - \
     - **\+**

Fill Authentication Information
===============================

This section assumes you've already configured a user. If you don't know how to
do that, you're dumb and this setup isn't for you.

Password Authentication
-----------------------

Just put your SMTP/IMAP password in ``your_email.secret``.

OAuth 2.0 Authentication
------------------------

Fill client info with necessary fields. Check out `mutt_oauth2.py docs`_, and
configure app registration. Also define a valid GnuPG key. Its "Email address"
must match ``user`` in client.

Once you set up these, run::

	$ cd $HOME/.mutt
	$ ./oauth2.py --authorize your_email.token

Follow instructions. For "Preferred OAuth2 flow", mutt_oauth2.py docs author
suggests trying all methods it provides. In practice, ``localhostauthcode``
works well.

Switch Users
============

:ref:`switch_mutt_users` documents this.

.. _mutt_oauth2.py docs: https://
	github.com/muttmua/mutt/blob/master/contrib/mutt_oauth2.py.README
