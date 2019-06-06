# Protect the Docker daemon socket

Follow the steps in Docker [docs](https://docs.docker.com/engine/security/https/) to:
  - generate certs for server and client
  - test if the `daemon` is secure
  - test if the client can use the certs


## Copy the certs to docker directory

Copy the following files to `/etc/docker/`
 - ca.pem
 - server-cert.pem
 - server-key.pem

## Test your changes
The following command can be used to test if the changes are working. However, it is NOT recommened as a way to run the daemon :
```
nohup <command> &
```
where `command` should be: 
```
dockerd --tlsverify --tlscacert=ca.pem --tlscert=server-cert.pem --tlskey=server-key.pem -H=0.0.0.0:2376
```

# Fixes for issues you might run into

When you try to run the above command you might get an error about `docker.pid`. To fix it remove the `docker.pid` using the command:
```
rm /var/run/docker.pid
```

Kill the process listening at port `2376` using the command:
```
sudo kill `sudo lsof -t -i:2376`
```

## Update the Docker service 

Edit the service file using nano (or vi): 
```
nano /lib/systemd/system/docker.service
```

Update `ExecStart` to use TLS Verification:
```
ExecStart=/usr/bin/dockerd --tlsverify --tlscacert=/etc/docker/ca.pem --tlscert=/etc/docker/server-cert.pem --tlskey=/etc/docker/server-key.pem -H=0.0.0.0:2376
```

## Make your client Secure by default 

Open `.bash_profile` and add the following to it:
```
export DOCKER_HOST=tcp://$HOST:2376 DOCKER_TLS_VERIFY=1
```

If the `.bashrc` is not already importing `.bash_profile` then add the following code to `.bashrc`:
```
if [ -f ~/.bash_profile ]; then
    . ~/.bash_profile
fi
```

