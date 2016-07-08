#!/bin/bash

echo "127.0.0.1 ${NEOS_VHOST}" | tee -a /etc/hosts

echo "=> Setting a password to the root user"
echo "root:root" | chpasswd
echo "=> Done!"

echo "========================================================================"
echo "You can now connect to this Ubuntu container via SSH using:"
echo ""
echo "    ssh -p <port> root@<host>"
echo "and enter the root password 'root' when prompted"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"