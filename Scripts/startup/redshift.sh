#!/bin/bash

time =  date | grep -oh "[0-9][0-9]:[0-9][0-9]"   

redshift -P -O 2000
