# SPDX-License-Identifier: GPL-3.0-or-later

copyright = '2025 Jiamu Sun'
author = 'Jiamu Sun'

with open('../NAME') as file:
	project = file.read()

with open('../VERSION') as file:
	vernumb = file.read()

	version = f"v{vernumb}"
	release = version

needs_sphinx = '8.2'
smartquotes_action = 'q'

extensions = []

primary_domain = 'c'
highlight_language = 'none'

templates_path = [ 'sphinx/templates' ]
exclude_patterns = [ 'build' ]

html_theme = 'alabaster'
html_static_path = [ 'sphinx/static' ]

html_logo = 'images/logo.svg'
html_favicon = 'images/favicon.png'

html_css_files = [
	'custom.css',
	'toc.css',
]

html_theme_options = {
	'description': version,
	'page_width': '65em',
	'sidebar_width': '20em',
	'fixed_sidebar': 'true',
	'font_size': 'inherit',
	'font_family': 'serif',
}

html_sidebars = {
	'**': [
		'about.html',
		'searchbox.html',
		'toc.html',
		'sourcelink.html',
	],
}
