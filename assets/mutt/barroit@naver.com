# SPDX-License-Identifier: GPL-3.0-or-later

set imap_user = 'barroit@naver.com'
set from      = $imap_user

source ~/.mutt/@naver.com
