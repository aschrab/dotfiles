# vim: ft=python
import readline
import rlcompleter
import os
import sys
import atexit

from pprint import pprint as p

# Avoid errors about unused imports
assert rlcompleter
assert p

readline.parse_and_bind('tab: complete')
histfile = os.path.join(os.environ['HOME'], '.pythonhistory')
try:
    readline.read_history_file(histfile)
except IOError:
    pass

atexit.register(readline.write_history_file, histfile)

h = [None]


class Prompt:
    def __init__(self, prompt='h[%d] >> '):
        self.prompt = prompt

    def __str__(self):
        try:
            if _ not in h:
                h.append(_)
        except NameError:
            pass
        return self.prompt % len(h)

    def __radd__(self, other):
        return str(other) + str(self)


sys.ps1 = Prompt()
sys.ps2 = '...     '
