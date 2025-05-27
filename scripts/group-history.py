#!/usr/bin/python3
# SPDX-License-Identifier: GPL-3.0-or-later

import fileinput

from os import path, environ as env

def find_bundle(name, arr):
	for i, bundle in enumerate(arr):
		if bundle[0][0] == name:
			return i
	return -1

def find_type(name, arr):
	for i, variant in enumerate(arr):
		if variant[0] == name:
			return i
	return -1

def find_prefix_match(name, arr):
	for i, str in enumerate(arr):
		if name.startswith(str):
			return i
	return -1

def sort_history(arr, size):
	i = size - 1

	while i > 0:
		bundle = arr[i]
		prev = bundle[0][0]
		next = arr[i - 1][0][0]

		if next.startswith(prev):
			j = i - 2

			while j >= 0 and arr[j][0][0].startswith(prev):
				j -= 1

			del arr[i]
			arr.insert(j + 1, bundle)
			continue

		elif len(bundle[0]) == 1:
			j = i + 1

			# Fuck, I'm writing crap. This would be way cleaner
			# with goto, but Python just has to be dumb. It feels
			# like you're not writing code to show what it's doing,
			# just hacking around a language fault. And the actual
			# functionality ends up a side effect.
			if '/' in prev:
				path = prev.rsplit('/', 1)
				prefix = path[0]

				while j < size and \
				      arr[j][0][0].startswith(prefix):
					j += 1

				if j == size:
					prev = ''

			del arr[i]

			if not '/' in prev:
				arr.append(bundle)
			else:
				arr.insert(j, bundle)

			continue

		i -= 1

def fill_lp(name):
	if not path.isfile(name):
		return

	file = open(name, mode = 'r')

	for line in file:
		line = line.rstrip()

		if line == '' or line[0] == '#':
			continue

		if line[-1] == '+':
			lp_type.append(line[0:-1])
		else:
			lp_group.append(line)

	file.close()

HOME = env['HOME']

__history = {}
lp_group = []
lp_type = []

fill_lp(HOME + '/.lowprior')
fill_lp('.lowprior')

for line in fileinput.input():
	line = line.rstrip()
	pair = line.rsplit(': ', 1)
	tags = pair[0].rsplit(': ', 1)

	group = tags[-1]
	title = pair[1]

	if not group in __history:
		__history[group] = [ [ group ] ]

	bundle = __history[group]

	if len(tags) == 1:
		bundle[0].append(title)
		continue

	type = tags[0]
	type_idx = find_type(type, bundle)

	if type_idx == -1:
		bundle.append([ type ])
		type_idx = len(bundle) - 1

	bundle[type_idx].append(title)

history = []
history_lp = []

for group in __history:
	bundle = __history[group]
	group_idx = find_prefix_match(group, lp_group)

	# I NEED THE FUCKING LINKED LIST!
	if group_idx == -1:
		history.append(bundle)
	else:
		history_lp.append(bundle)

history_size = len(history)
history_lp_size = len(history_lp)

sort_history(history, history_size)
sort_history(history_lp, history_lp_size)

for i in range(history_size):
	bundle = history[i]
	i = 0

	while i < len(bundle):
		group = bundle[0][0]
		type = bundle[i][0]
		lp_type_idx = find_prefix_match(type, lp_type)

		if lp_type_idx == -1:
			i += 1
			continue

		offset = find_bundle(group, history[history_size:])

		if offset == -1:
			history.append([ [ group ] ])
			offset = len(history) - history_size - 1

		history[history_size + offset].append(bundle[i])
		del bundle[i]

history[history_size:history_size] = history_lp

for bundle in history:
	group = bundle[0][0]

	for variant in bundle:
		type = variant[0]
		variant_size = len(variant)

		if variant_size == 1:
			continue

		print(type, end = '')

		if type == group:
			print(':')
		else:
			print(f": {group}:")

		for i in range(variant_size - 1, 0, -1):
			print(f"  - {variant[i]}")

		print()
