# Setup KodeKloud Lab environment for tmux and ssh keys for passwordless.
# Paste below line without the # to execute:
#    curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh && bash -x setup.sh && tmux -f ~/tmux.conf

# retreive ~/bashrc.kk
[ -f ~/bashrc.kk ] || curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/bashrc.kk

# append sourcing of bashrc.kk to ~/.bashrc
grep bashrc.kk ~/.bashrc || echo "source ~/bashrc.kk" >> ~/.bashrc

# add user to /etc/sudoers files to not prompt for password
passwordfile="passwords"
[ -f $passwordfile ] || curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/passwords
hostname=$(hostname | cut -f 1 -d.)
user=$(grep $hostname $passwordfile | awk {'print $4'})
password=$(grep $hostname $passwordfile | awk {'print $5'})
echo $password | sudo -S bash -c "echo $user ALL = NOPASSWD : ALL >> /etc/sudoers"

# create default sshkey if doesn't exist
[ -f ~/.ssh/id_rsa ] || ssh-keygen -q -N "" -f ~/.ssh/id_rsa

# ssh options to prevent prompting
SSHOPT="-o userknownhostsfile=/dev/null -o StrictHostKeyChecking=no"

# jump(thor) system specific specific
if [ "$hostname" = "jump_host" ]; then
    # install tmux, sshpass, neovim
    [ -f yum.install.log ] || sudo yum -y install tmux sshpass 2>&1 > yum.install.log
    passwordfile="passwords"
    grep stapp $passwordfile | while read line; do
        hostname=$(echo $line | awk {'print $1'})
        user=$(echo $line |  awk {'print $4'})
        password=$(echo $line |  awk {'print $5'})

        # copy sshkey to stapp0x systems for passwordless login
        sshpass -p $password ssh-copy-id $SSHOPT $user@$hostname
    done
fi
