mkdir ~/.ssh
cd ~/.ssh
ssh-keygen -t rsa -b 4096 -C $myEmail

systemctl enable --user pipewire-pulse.service
