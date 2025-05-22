# SPDX-License-Identifier: GPL-3.0-or-later

source ~/.mutt/auth.password

set smtp_url = "smtp://$imap_user@smtp.naver.com:587/"

set folder    = 'imaps://imap.naver.com:993/'
set spoolfile = +INBOX
set postponed = +Drafts
set record    = '+Sent Messages'

set trash     = '+Deleted Messages'
set delete

set imap_keepalive = 60
