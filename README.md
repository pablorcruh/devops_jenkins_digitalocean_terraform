## DEVOP DEPLOYING JENKINS ON DIGITAL OCEAN

### DESCRIPTION

The present project is a basic guide to use terraform and digital ocean as
tools to deploy our infrastructure.

In this case we deploy a Jenkins server as a container inside a droplet.

We spin up the droplet and provision docker and some configuration files to bring the server up.

This is infrastructure as code, we have all the configuration that we need on
a repository and we always be able to keep track of any changes, making this process repeatable 
with the same outcome every time.

The provision makes an ssh connection and create a directory and move some files to setup 
everything.

The project has the following files.
* dns.tf -> has digitalocean dns record.
* docker-compose.yml -> has the jenkins container configuration.
* droplet.tf -> has all the droplet configuration to be deployed.
* server_keys -> folder with private key and public key. 
* provider.tf -> has all the provider configuration to be used.
* ssh_key.tf -> has public key configuration to be passed to the droplet.
* terraform.tfvars -> has the DigitalOcean API key, file never uploaded to the repository
* userdata.yaml -> has all software provisioning inside the droplet and executes some commands


We need and ssh key to access droplet within our project, so we create a folder for all keys, we create new keys so we don't override our ssh keys on our machine.

On the root of the project we create a folder and generate the ssh keys

```
    mkdir server_keys
    ssh-keygen -b 4096
    
    
    Generating public/private rsa key pair.
    Enter file in which to save the key (/path/to/.ssh/id_rsa): /path/to/project/server_keys/id_rsa
    Enter passphrase (empty for no passphrase): 
    Enter same passphrase again: 
    Your identification has been saved in /path/to/project/devops_jenkins_digitalocean_terraform/server_keys/id_rsa.
```

The files that we need to modify are:

* docker-compose.yml
```
      - VIRTUAL_HOST=jenkins.your.domain.com
      - VIRTUAL_PORT=8080
      - LETSENCRYPT_HOST=jenkins.your.domain.com
      - LETSENCRYPT_EMAIL=support@emial.com
```
we need to replace all the values according with our own 

To start the project

```
    terraform init
```

We use terraform to download all the components needed for the provider specified

To finish we apply all the changes on our infrastructure as we planned

In case you need to understand the variables used in the configuration 
we supply the **terraform.tfvars** structure

We need to create a file called terraform.tfvars with the following structure

```
    do_token="DIGITAL_OCEAN_API_KEY"
    file_path="file/path/from/source/project"
    domain="jenkins.your.domain"

```
We specify the path to the project so terraform can locate the docker-compose file.

```
    terraform plan
```

We use terraform to generate an output describing all changes to be executed on our
infrastructure.

```
    terraform apply
```

In case you need to access to jenkins server for the first time you need to ssh into the droplet

```
   ssh root@droplet_ip_address -i server_keys/id_rsa
```

## Note

The installation and setup of the jenkins and nginx container will take about 10 minutes to everything
will be up and running.

Then you can get the jenkins access key login into the container and start installation

```
   docker logs -f jenkins
```
