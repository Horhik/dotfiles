dropdown_enabled=$(cat /tmp/dropdown | grep 'dropdown')
if [[ $dropdown_enabled == dropdown ]];
then
  echo true
fi
