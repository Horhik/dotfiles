
sudo systemctl start NetworkManager
sudo systemctl start dhcpcd  

nmcli con up Main
nmcli dev wifi connect <name> password <pass> hidden <yes/no>
echo "success may be"
