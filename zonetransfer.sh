#!/bin/sh
for srv in $(host -t ns $1 | cut -d" " -f4 | sed 's/\.$//'); do host -l $1 $srv | egrep '([0-9]{1,3}\.){3}[0-9]{1,3}$\b'; done
