#!/bin/bash

virtualenv env

source env/bin/activate

pip install --upgrade pip setuptools

pip install --process-dependency-links Pootle[mysql]

pootle init --db mysql --db-name pootledb --db-user pootle --db-host mysql

