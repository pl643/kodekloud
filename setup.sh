# Setup KodeKloud Lab environment for tmux environment ssh keys for less passord typing.
 and sshpass to auto enter password
# paste below command without the # to execute:
#    curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh > setup.sh; bash -x setup.sh; tmux

# retreive ~/bashrc.kk
[ -f ~/bashrc.kk ] || curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/bashrc.kk > ~/bashrc.kk

# append sourcing of bashrc.kk to ~/.bashrc
grep bashrc.kk ~/.bashrc || echo "source ~/bashrc.kk" >> ~/.bashrc

# add user to sudoer files
passwordfile="passwords"
[ -f $passwordfile ] || curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/passwords > $passwordfile
hostname=$(hostname | cut -f 1 -d.)
user=$(grep $hostname $passwordfile | awk {'print $4'})
password=$(grep $hostname $passwordfile | awk {'print $5'})
# echo mjolnir123 | sudo -S sh -c 'echo "thor ALL = NOPASSWD : ALL" >> /etc/sudoers2'
# echo $password | sudo -S sh   -c echo "$user ALL = NOPASSWD : ALL >> /etc/sudoers2"
echo $password | sudo -S bash -c "echo $user ALL = NOPASSWD : ALL >> /etc/sudoers"

# create default sshkey if doesn't exist
[ ! -f ~/.ssh/id_rsa ] && ssh-keygen -q -N "" -f ~/.ssh/id_rsa

# ssh options to prevent prompting
SSHOPT="-o userknownhostsfile=/dev/null -o StrictHostKeyChecking=no"

# jump(thor) system specific specific
if [ "$hostname" = "thor" ]; then
    # install tmux, sshpass
    sudo yum -y install tmux sshpass neovim

    passwordfile="passwords"
    grep -v jump_host $passwordfile | while read line; do
        hostname=$(echo $line | awk {'print $1'})
        user=$(echo $line |  awk {'print $4'})
        password=$(echo $line |  awk {'print $5'})

        # copy sshkey to systems for passwordless login
        # sshpass -p $password ssh $SSHOPT $user@$hostname '[ -d .ssh ] || mkdir .ssh && chmod 700 .ssh'
        sshpass -p $password ssh-copy-id $SSHOPT $user@$hostname
    done
fi
