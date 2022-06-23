# Setup KodeKloud Lab environment for tmux environment and sshpass to auto enter password
# paste below command without the # to execute: 
#    curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh | bash; tmux

curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/bashrc.kk > ~/bashrc.kk

# append sourcing of bashrc.kk to ~/.bashrc
grep bashrc.kk ~/.bashrc || echo "source ~/bashrc.kk" >> ~/.bashrc

# install and execute tmux
echo mjolnir123 | sudo -S yum install tmux sshpass
