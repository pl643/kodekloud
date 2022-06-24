# Setup KodeKloud Lab environment for tmux environment and sshpass to auto enter password
# paste below command without the # to execute: 
#    curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh | bash; tmux

curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/bashrc.kk > ~/bashrc.kk

# append sourcing of bashrc.kk to ~/.bashrc
grep bashrc.kk ~/.bashrc || echo "source ~/bashrc.kk" >> ~/.bashrc

# add thor to sudoer files
echo mjolnir123 | sudo -S sh -c 'echo "thor ALL = NOPASSWD : ALL" >> /etc/sudoers'

# install tmux, sshpass
sudo yum -y install tmux sshpass neovim

# create sshkey
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen -q -N "" -f ~/.ssh/id_rsa

# skip hostkey and userhostfile checking
alias ssh='ssh -o userknownhostsfile=/dev/null -o "StrictHostKeyChecking no"

# copy sshkey to systems for passwordless login
sshpass -p Ir0nM@n ssh tony@stapp01 '[ -d .ssh ] || mkdir .ssh ]'
sshpass -p Ir0nM@n ssh-copy-id tony@stapp01

sshpass -p Am3ric@ ssh steve@stapp02 '[ -d .ssh ] || mkdir .ssh ]'
sshpass -p Am3ric@ ssh-copy-id steve@stapp02 
