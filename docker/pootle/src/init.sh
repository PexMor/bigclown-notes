#!/bin/bash

virtualenv env

source env/bin/activate

pip install --upgrade pip setuptools

pip install --process-dependency-links Pootle[mysql]

pootle init --db mysql --db-name pootledb --db-user pootle --db-host mysql

echo "overwrite the config with the config provided here"

# cp ...conf trg/

pootle initdb --no-projects

pootle createsuperuser --username admin --no-input --email test@example.com
pootle verify_user admin

echo "please run 'pootle changepassword admin'"

# pootle createsuperuser
# pootle verify_user admin
# pootle runserver --insecure
