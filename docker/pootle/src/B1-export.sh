#!/bin/bash

source env/bin/activate
source cfg

# from db
pootle sync_stores --project=$PROJ
