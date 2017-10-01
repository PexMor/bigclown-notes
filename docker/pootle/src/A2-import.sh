#!/bin/bash

source env/bin/activate
source cfg

pootle update_stores --project=$PROJ
