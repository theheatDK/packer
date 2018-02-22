#!/bin/bash -eux

cat <<EOT >> /etc/resolv.conf
# My DNS 1
nameserver 158.234.97.36
# My DNS 2
nameserver 158.234.97.55
# google DNS
nameserver 8.8.8.8
EOT
