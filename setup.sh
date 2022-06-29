# Setup KodeKloud Lab environment for tmux and ssh keys for less passord typing.
# Paste below line without the # to execute:
#    curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh; bash -x setup.sh; source bashrc.kk; tmux

# retreive ~/bashrc.kk
[ -f ~/bashrc.kk ] || curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/bashrc.kk

# append sourcing of bashrc.kk to ~/.bashrc
grep bashrc.kk ~/.bashrc || echo "source ~/bashrc.kk" >> ~/.bashrc

# add user to sudoer files
passwordfile="passwords"
[ -f $passwordfile ] || curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/passwords
hostname=$(hostname | cut -f 1 -d.)
user=$(grep $hostname $passwordfile | awk {'print $4'})
password=$(grep $hostname $passwordfile | awk {'print $5'})
# echo mjolnir123 | sudo -S sh -c 'echo "thor ALL = NOPASSWD : ALL" >> /etc/sudoers2'
echo $password | sudo -S bash -c "echo $user ALL = NOPASSWD : ALL >> /etc/sudoers"

# create default sshkey if doesn't exist
[ -f ~/.ssh/id_rsa ] || ssh-keygen -q -N "" -f ~/.ssh/id_rsa

# ssh options to prevent prompting
SSHOPT="-o userknownhostsfile=/dev/null -o StrictHostKeyChecking=no"

# jump(thor) system specific specific
if [ "$hostname" = "jump_host" ]; then
    # install tmux, sshpass, neovim
    [ -f yum.install.log ] || sudo yum -y install tmux sshpass neovim 2>&1 > yum.install.log
    passwordfile="passwords"
    grep app $passwordfile | while read line; do
        hostname=$(echo $line | awk {'print $1'})
        user=$(echo $line |  awk {'print $4'})
        password=$(echo $line |  awk {'print $5'})

        # copy sshkey to app systems for passwordless login
        sshpass -p $password ssh-copy-id $SSHOPT $user@$hostname
        #sshpass -p $password ssh $SSHOPT $user@$hostname "echo $password | sudo -S yum -y install openssh-clients"
        #sshpass -p $password scp $SSHOPT bashrc.kk  $user@$hostname:
        #sshpass -p $password ssh $SSHOPT $user@$hostname 'curl -s https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh \> setup.sh; bash -x setup.sh'
    done
fi
