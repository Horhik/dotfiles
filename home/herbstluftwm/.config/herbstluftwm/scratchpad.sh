#!/usr/bin/env bash

# File:           scratchpad.sh
# Description:    Script to toggle or create scratchpad windows
# Author:	  RayZ0rr (https://github.com/RayZ0rr)

name="$1"
command="${@: 2}"

clientsArray=( $(herbstclient foreach C clients. echo C | awk 'BEGIN{ORS=" "} {print $1}') )
for client in "${clientsArray[@]}" ; do

  id=$(echo $client | cut -d '.' -f 2)
  instanceName="$(herbstclient get_attr ${client}.instance)"
  # className=$(herbstclient get_attr "${client}.class")
  # titleName="$(herbstclient get_attr ${client}.title)"

  if [[ "${instanceName}" == "${name}" ]] ; then # If the scratchpad window exists

    visible_wid="$(xdotool search --onlyvisible --classname "${name}" | tail -1 2> /dev/null)"

    if [[ -z "$visible_wid" ]]; then # If the scratchpad window is not visible

      echo "${name} found. Showing scratchpad."
      herbstclient bring ${id} # Bring scratchpad to focus
      exit $?

    else # If the scratchpad window is visible

      echo "Hiding instance of ${name}."
      herbstclient set_attr "${client}.minimized" true # Hide scratchpad
      exit 0

    fi

  fi

done

if [[ $# -ne 2 ]]; then	# If a command to launch it was not provided
  echo "${name} not found. A command was not provided to launch it."
  exit 1
fi

echo "${name} not found. Executing: '${command}'."
$command

# if ! eval "${@: 2}" ; then
if ! [ $? -eq 0 ]; then
  echo "Provided command '${command}' failed"
  exit 1
fi

# Wait for application to be available
while [[ -z "$wid" ]]; do
  sleep 0.05;
  wid="$(xdotool search --classname "${name}" | tail -1 2> /dev/null)"
done

exit 0
