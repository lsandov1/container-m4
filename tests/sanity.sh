#/bin/bash

echo "Running Sanity"
echo "Distro / Kernel info: "
uname -a
if test -f "/etc/issue"; then
    cat "/etc/issue"
fi

