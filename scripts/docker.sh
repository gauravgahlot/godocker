#  +-----------------------------------------+
#  +	INSTALL SPECIFIC VERSIN OF DOCKER    +		
#  +-----------------------------------------+

# install dependencies
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

# add repositry
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update

# list all stable versions
apt-cache madison docker-ce

# install docker 18.03
sudo apt-get install -y docker-ce=18.03.0~ce-0~ubuntu
