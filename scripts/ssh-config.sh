#!/bin/bash


# declare the hosts here
declare -a hosts=(172.27.127.169 172.27.127.171 172.27.127.174)


# enable ssh root login
enable_ssh()
{
  echo "Enabling root login on remote server..."
  sshpass -p cybage@123 ssh -q -o StrictHostKeyChecking=no quickdev@$1 -t 'sudo sed -i "s/^PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config'
  echo
  echo
}


# restart the sshd service
restart_sshd()
{
  echo "Restarting 'sshd' service on remote server..."
  sshpass -p cybage@123 ssh -q -o StrictHostKeyChecking=no quickdev@$1 -t 'sudo service sshd restart'
  echo 
}


# setup the root passwd
setup_root_passwd()
{
  echo "Setup the root password..."
  sshpass -p cybage@123 ssh -q -o StrictHostKeyChecking=no quickdev@$1 -t 'sudo passwd root'
  echo 
}


# generate public key
generate_public_key()
{
  echo "Generating public key at '/root/.ssh/'..."
  #ssh-keygen -t rsa
  ssh-keygen -f id_rsa -t rsa -N ''
  echo 
}


# create .ssh directory at remote server
create_ssh_directory()
{
  echo "Creating '.ssh' directory at remote server"
  sshpass -p root ssh root@$1 mkdir -p .ssh
  echo 
}


# copy public keys to the `.ssh` directory at remote server
copy_public_key()
{
  echo "Copying public keys to '.ssh' directory created in previous step"
  sshpass -p root ssh-copy-id -i /root/.ssh/id_rsa.pub root@$1
  echo 
}


initiate_process()
{
  # install sshpass and openssh-server
  echo "installing sshpass and openssh-server..."
  apt install -y sshpass openssh-server
  
  # generate public for later use
  generate_public_key
  echo  
 
  # loop over the hosts
  for host in "${hosts[@]}"
  do
    clear
    echo "Initiating process for $host..."
    enable_ssh $host
    restart_sshd $host
    setup_root_passwd $host
    create_ssh_directory $host
    copy_public_key $host
    echo "Root login with public key is complete for $host..."
    echo
    sleep 1
  done
  echo "+----------------------------------+"
  echo "+    All configurations complete   +"
  echo "+----------------------------------+"
  echo
}


initiate_process


# copy file to remote server
#sshpass -p cybage@123 scp enabler.sh quickdev@172.27.127.171:/home/quickdev/


# ssh as user and switch to root
#sshpass -p cybage@123 ssh -o StrictHostKeyChecking=no quickdev@172.27.127.171 echo "cybage@123" | sudo su << EOF
#   whoami
#EOF


