#/bin/bash
git log --all | egrep -e '([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})' | grep 'Author: ' | sed -e 's/Author: //g' | sort -u > authors.txt
cat authors.txt | egrep -o '([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})' | sed -e 's/.*<//g' -e 's/>.*//g' | grep -v 'users.noreply.github.com' | sort -fu > emails.txt

