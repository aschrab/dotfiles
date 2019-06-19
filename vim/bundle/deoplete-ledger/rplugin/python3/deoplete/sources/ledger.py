#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import subprocess
from deoplete.source.base import Base


class Source(Base):
    def __init__(self, vim):
        Base.__init__(self, vim)
        self.name = "ledger"
        self.filetypes = ["ledger"]
        self.input_pattern = r'()'

    def gather_candidates(self, context):
        proc = subprocess.Popen(['hledger', 'accounts'],
                                stdout=subprocess.PIPE)
        out, err = proc.communicate()
        return out.decode('utf-8').splitlines()
        # return proc.stdout.split(os.linesep)

        # for line in iter(proc.stdout.readline, ''):
        #     print line.rstrip()
