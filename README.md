# Kodekloud https://www.kodekloud-engineer.com/

## setup.sh configures the followings:
  - passwordless ssh to stapp01, stapp02, stapp03
  - passwordless sudo to jump, stapp01, stapp02, stapp03
  - installs tmux, neovim, sshpass

## You should fork this repo change it to your preference.

## Copy and paste below to command to start setup.sh

  - curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh && bash -x setup.sh && tmux -f ~/tmux.conf
