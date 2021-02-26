#!/bin/bash

id=$(xinput | grep -shoP 'Touchpad.*id=[0-9]*' | grep -shoP '[0-9]*')
xinput set-prop $id 'libinput Tapping Enabled' 1
xinput set-prop $id 'libinput Tapping Enabled' 1

xinput set-prop $id 'libinput Middle Emulation Enabled' 1
xinput set-prop $id 'libinput Natural Scrolling Enabled' 1

