# vim: ft=python
import os
import sys
import atexit

from pprint import pprint as p

imports = ['os', 'sys', 'atexit']

try:
    import readline
    imports.append('readline')
    import rlcompleter
    imports.append('rlcompleter')

    # Avoid errors about unused imports
    assert rlcompleter
    assert p

    readline.parse_and_bind('tab: complete')
    histfile = os.path.join(os.environ['HOME'], '.pythonhistory')
    try:
        readline.read_history_file(histfile)
    except IOError as err:
        pass

    atexit.register(readline.write_history_file, histfile)
except Exception as err:
    print("!!!! Failed to setup readline history", err)

# Report non-default imports
print("Imported " + ", ".join(imports))

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
