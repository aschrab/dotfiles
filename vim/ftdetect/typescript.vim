au BufRead * if getline(1) =~ '^#!/usr/bin/env ts-node\(-dev\)\?' | setf typescript | endif
