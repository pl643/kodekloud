# Setup KodeKloud Lab environment for tmux and ssh keys for passwordless.
# Paste below line without the # to execute:
#    curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh && bash -x setup.sh && tmux -f ~/tmux.conf

GHURL="https://raw.githubusercontent.com/pl643/kodekloud/main"

# retreive ~/bashrc.kk
[ -f ~/bashrc.kk ] || curl -Os $GHURL/bashrc.kk

# add loading of bashrc.kk to ~/.bashrc
grep bashrc.kk ~/.bashrc || echo "source ~/bashrc.kk" >> ~/.bashrc

# grab tmux.conf NOTE: tmux prefix is set to `,  2x` will produce one `
[ -f ~/tmux.conf ] || curl -Os $GHURL/tmux.conf

# grab neovim init file
[ -f ~/init.vim ] || curl -Os $GHURL/init.vim

# add user to /etc/sudoers files to not prompt for password
passwordfile="passwords"
[ -f $passwordfile ] || curl -Os $GHURL/passwords
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
    # install tmux, sshpass
    [ -f yum.install.log ] || sudo yum -y install tmux sshpass neovim 2>&1 > yum.install.log
    passwordfile="passwords"
    grep stapp $passwordfile | while read line; do
        hostname=$(echo $line | awk {'print $1'})
        user=$(echo $line |  awk {'print $4'})
        password=$(echo $line |  awk {'print $5'})
        [ -z $apphosts ] && apphosts=$user@$hostname || apphosts="$apphosts $user@$hostname"

        # copy sshkey to stapp0x systems for passwordless login
        sshpass -p $password ssh-copy-id $SSHOPT $user@$hostname
    done
fi
# setup  app server for sourcing bashrc.kk and no password sudo
for h in ${apphosts[@]}; do
    for f in setup.sh bashrc.kk; do
        ssh $SSHOPT $h "cat > $f" < $f
    done
    ssh $SSHOPT $h "bash -x setup.sh"
done
