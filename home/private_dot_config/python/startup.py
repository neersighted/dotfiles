"""
Mirrors CPython's default readline hook, but loads the init file and caps the history length.
"""

import atexit
import os
import sys


def _interactive_hook():
    try:
        import readline
        import rlcompleter  # noqa: F401 -- importing registers the completer
    except ImportError:
        return

    # editline/libedit needs a different binding than GNU readline.
    backend = getattr(readline, "backend", None)
    if backend == "editline" or (
        backend is None and "libedit" in (readline.__doc__ or "")
    ):
        readline.parse_and_bind("bind ^I rl_complete")
    else:
        readline.parse_and_bind("tab: complete")

    try:
        readline.read_init_file()
    except OSError:
        pass

    histfile = os.environ["PYTHON_HISTORY"]
    os.makedirs(os.path.dirname(histfile), exist_ok=True)
    try:
        readline.read_history_file(histfile)
    except OSError:
        pass
    readline.set_history_length(1000)
    atexit.register(readline.write_history_file, histfile)


sys.__interactivehook__ = _interactive_hook
