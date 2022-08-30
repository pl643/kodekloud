## Usage

Copy and paste the below commands on the jump_host to download and run the setup.sh script. I do this before the start of each exercise.

```
curl -Os https://raw.githubusercontent.com/pl643/kodekloud/main/setup.sh && bash -x setup.sh && tmux -f ~/tmux.conf
```


# Custom Kodekloud Lab Environment

These scripts and config files customizes the KK environment to somewhat like my daily environment so one can focus on the Labs instead of always typing the password incorrectly and have tmux running when the lab environment sometimes just resets and drops you back to the jump host. I can resume my tmux session with "tmux attach". You *should* fork this repo and change the configurations to your preference.

## The setup.sh script configures the followings:
  - passwordless ssh to stapp01, stapp02, stapp03
  - passwordless sudo on jump, stapp01, stapp02, stapp03
  - installs tmux, neovim, sshpass
  - downloads tmux.conf, init.vim, bashrc.kk, passwords
  - adds/sources bashrc.kk to ~/.bashrc

