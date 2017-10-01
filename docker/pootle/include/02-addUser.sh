#!/bin/bash

groupadd user
useradd -g user -d /host -M -c "Main user" -s /bin/sh user
echo "user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
