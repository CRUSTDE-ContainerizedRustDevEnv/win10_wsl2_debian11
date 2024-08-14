#!/bin/sh

# ~/.ssh/sshadd.sh
# Inside this template, replace the words github_com_bestia_dev_git_ssh_1, github_com_GuitaraokeLeader_git_ssh_1 and bestia_dev_luciano_bestia_ssh_1 
# with your identity file names for the ssh private key.

printf " \n"
printf "  \033[33m Add often used SSH identity private keys to ssh-agent \033[0m\n"
printf "  \033[33m If you add arguments 'github/bestia-dev', 'github/GuitaraokeLeader', 'bestia.dev' or 'crustde' you will add only one credential. \033[0m\n"

printf " \n"
printf "  \033[33m The ssh-agent should be started already on login inside the ~/.bashrc script. \033[0m\n"
printf "  \033[33m <https://github.com/CRUSTDE-ContainerizedRustDevEnv/crustde_cnt_img_pod/blob/main/ssh_easy.md> \033[0m\n"
printf "  \033[33m It is recommanded to use the ~/.ssh/config file to assign explicitly one ssh key to one ssh server. \033[0m\n"
printf "  \033[33m If not, ssh-agent will send all the keys to the server and the server could refute the connection because of too many bad keys. \033[0m\n"

printf " \n"
# check the content of ~/.ssh/config if it contains all the ssh keys
cat ~/.ssh/config | grep -q "~/.ssh/github_com_bestia_dev_git_ssh_1" || printf "  \033[31m The ~/.ssh/config does not contain the identity ~/.ssh/github_com_bestia_dev_git_ssh_1. \033[0m\n"
cat ~/.ssh/config | grep -q "~/.ssh/github_com_GuitaraokeLeader_git_ssh_1" || printf "  \033[31m The ~/.ssh/config does not contain the identity ~/.ssh/github_com_GuitaraokeLeader_git_ssh_1. \033[0m\n"
cat ~/.ssh/config | grep -q "~/.ssh/bestia_dev_luciano_bestia_ssh_1" || printf "  \033[31m The ~/.ssh/config does not contain the identity ~/.ssh/bestia_dev_luciano_bestia_ssh_1. \033[0m\n"
cat ~/.ssh/config | grep -q "~/.ssh/crustde_rustdevuser_ssh_1" || printf "  \033[31m The ~/.ssh/config does not contain the identity ~/.ssh/crustde_rustdevuser_ssh_1. \033[0m\n"

if [ $# -eq 0 ] || [ $1 = "github/bestia-dev" ]; then
    # add if key not yet exist in ssh-agent for git@github.com
    ssh-add -l | grep -q `ssh-keygen -lf ~/.ssh/github_com_bestia_dev_git_ssh_1 | awk '{print $2}'` || (printf "  \033[33m github/bestia-dev \033[0m\n" & ssh-add -t 1h ~/.ssh/github_com_bestia_dev_git_ssh_1)
fi

if [ $# -eq 0 ] || [ $1 = "github/GuitaraokeLeader" ]; then
    # add if key not yet exist in ssh-agent for git@github.com
    ssh-add -l | grep -q `ssh-keygen -lf ~/.ssh/github_com_GuitaraokeLeader_git_ssh_1 | awk '{print $2}'` || (printf "  \033[33m github/GuitaraokeLeader \033[0m\n" & ssh-add -t 1h ~/.ssh/github_com_GuitaraokeLeader_git_ssh_1)
fi

if [ $# -eq 0 ] || [ $1 = "bestia.dev" ]; then
    # add if key not yet exist in ssh-agent for luciano_bestia@bestia.dev
    ssh-add -l | grep -q `ssh-keygen -lf ~/.ssh/bestia_dev_luciano_bestia_ssh_1 | awk '{print $2}'` || (printf "  \033[33m bestia.dev \033[0m\n" & ssh-add -t 1h ~/.ssh/bestia_dev_luciano_bestia_ssh_1)
fi

if [ $# -eq 0 ] || [ $1 = "crustde" ]; then
    # add if key not yet exist in ssh-agent for rustdevuser@localhost:2201
    ssh-add -l | grep -q `ssh-keygen -lf ~/.ssh/crustde_rustdevuser_ssh_1 | awk '{print $2}'` || (printf "  \033[33m crustde \033[0m\n" & ssh-add -t 1h ~/.ssh/crustde_rustdevuser_ssh_1)
fi

printf " \n"
printf "  \033[33m The keys are set to expire in 1 hour. \033[0m\n"
printf "  \033[33m For security, when you are finished using the keys, remove them from the ssh-agent with: \033[0m\n"
printf "\033[32mssh-add -D \033[0m\n"
printf " \n" 
printf "   \033[33m List public fingerprints inside ssh-agent: \033[0m\n"
printf "\033[32mssh-add -l \033[0m\n"
ssh-add -l

printf " \n"
