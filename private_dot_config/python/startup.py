#! /bin/python

import atexit
import os
import sys

XDG_DATA_HOME = os.environ['XDG_DATA_HOME'] \
                    if os.environ['XDG_DATA_HOME'] \
                    else os.path.join(os.path.expanduser("~"), ".cache")
PYTHON_DATA = os.path.join(XDG_DATA_HOME, "python")


def interactivehook():
    try:
        import readline
        import rlcompleter
    except ImportError:
        return

    readline_doc = getattr(readline, '__doc__', '')
    if readline_doc is not None and 'libedit' in readline_doc:
        readline.parse_and_bind('bind ^I rl_complete')
    else:
        readline.parse_and_bind('tab: complete')

    if not os.path.isdir(PYTHON_DATA):
        os.mkdir(PYTHON_DATA)
    histfile = os.path.join(PYTHON_DATA, "history")

    try:
        readline.read_history_file(histfile)
        readline.set_history_length(1000)
    except FileNotFoundError:
        pass

    atexit.register(readline.write_history_file, histfile)


sys.__interactivehook__ = interactivehook
