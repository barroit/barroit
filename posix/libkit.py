#!/usr/bin/python3
# SPDX-License-Identifier: GPL-3.0-or-later

import time

from os import chdir,		\
	       devnull,		\
	       environ as env,	\
	       getcwd as pwd,	\
	       getpid,		\
	       mkdir,		\
	       path,		\
	       unlink

from subprocess import run as execl,	\
		       DEVNULL

from sys import argv,		\
		exit,		\
		stdout,		\
		stderr

realpath = path.abspath
basename = path.basename
dirname = path.dirname
isfile = path.isfile
isdir = path.isdir
islink = path.islink

argc = len(argv)

BOLD='\033[1m'
RED='\033[31m'
YELLOW='\033[33m'
GREEN='\033[32m'
CYAN='\033[36m'
WHITE='\033[37m'
RESET='\033[0m'

def current():
	return time.monotonic()

def log(*args):
	print(f"{BOLD}{GREEN}[{current()}]{RESET}", *args)

def note(*args):
	print(f"{BOLD}{CYAN}note:{RESET}", *args)

def warn(*args):
	print(f"{BOLD}{YELLOW}warn:{RESET}", *args, file = stderr)
	return -1

def error(*args):
	print(f"{BOLD}{RED}error:{RESET}", *args, file = stderr)
	return -1

def die(*args):
	print(f"{BOLD}{RED}fatal:{RESET}", *args, file = stderr)
	exit(128)

def env_or_die(name):
	if not name in env:
		die(f"missing env '{name}'")
	return env[name]
