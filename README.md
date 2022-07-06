# Custom Kodekloud Lab

These scripts and config files customizes the KK environment to somewhat my daily environment so I can focus on the Labs instead of always typing the password incorrectly and have tmux running when the lab environment sometimes just resets. You *should* fork this repo and change the configurations to your preference.

## The setup.sh script configures the followings:
  - passwordless ssh to stapp01, stapp02, stapp03
  - passwordless sudo to jump, stapp01, stapp02, stapp03
  - installs tmux, neovim, sshpass
  - downloads tmux.conf, init.vim

## Copy and paste the below commands to downloand and run the setup.sh script

  - curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh && bash -x setup.sh && tmux -f ~/tmux.conf
