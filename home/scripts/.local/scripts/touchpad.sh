#!/bin/bash

id=$(xinput | grep -shoP 'Touchpad.*id=[0-9]*' | grep -shoP '[0-9]*')
tap_id=$(xinput list-props $id | grep -shoP 'Tapping Enabled Default.+[0-9]*' | grep -sho '[0-9][0-9][0-9]')

echo $id 
tap_id=$(xinput list-props $id | grep -shoP 'Tapping Enabled.+[0-9]*' | grep -m 1 -sho '[0-9][0-9][0-9]')

middle_id=$(xinput list-props $id | grep -shoP 'Middle Emulation Enabled.+[0-9]*' | grep -m 1 -sho '[0-9][0-9][0-9]')

echo $tap_id
echo $middle_id

xinput set-prop $id $tap_id 1
xinput set-prop $id $middle_id 1
synclient TapButton2=2
synclient TapButton3=3
xinput set-prop $id 381 2 3 0 0 1 3 2
