# Custom Kodekloud Lab

These scripts customize the KK environment to somewhat of my daily environment so I can focus on the Labs instead of always and typing the password incorrectly and have tmux running when the lab environment sometimes just resets.

## The setup.sh script configures the followings:
  - passwordless ssh to stapp01, stapp02, stapp03
  - passwordless sudo to jump, stapp01, stapp02, stapp03
  - installs tmux, neovim, sshpass
  - downloads tmux.conf, init.vim

## You should fork this repo change it to your preference.

## Copy and paste the below command to downloand and run setup.sh

  - curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh && bash -x setup.sh && tmux -f ~/tmux.conf
