# MeshCentral2 running in a Docker container inside a Vagrant VM

This is a Vagrant VM running a CentOS 7 host running Docker CE (reused
from https://github.com/stefanlasiewski/vagrant-centos-docker ), to
run MeshCentral2 as a Docker container.

It runs the olberger/meshcentral2:latest Docker container image, which
is itself an installation of MeshCentral2 on a CentOS 7 base image.


# Usage

Simply clone this repo, and run `vagrant up`:

```
$ vagrant up
Bringing machine 'default' up with 'virtualbox' provider...
==> default: Importing base box 'centos/7'...
...
==> docker-centos: Running provisioner: shell...
    docker-centos: Running: /tmp/vagrant-shell20200604-441847-1iq6klh.sh
    docker-centos: latest: Pulling from olberger/meshcentral2
...
   docker-centos: Status: Downloaded newer image for olberger/meshcentral2:latest
    docker-centos: docker.io/olberger/meshcentral2:latest
    docker-centos: 6df6292e5d4e7c71e74271478c38431ce81464eaf2ba32091887bfb83aeaa79b
    docker-centos: staring mes central
    docker-centos: Last login: Thu Jun  4 14:05:37 UTC 2020
    docker-centos: Installing otplib@10.2.3...
    docker-centos: MeshCentral HTTP redirection server running on port 80.
    docker-centos: Generating certificates, may take a few minutes...
    docker-centos: Generating root certificate...
    docker-centos: Generating HTTPS certificate...
    docker-centos: Generating MeshAgent certificate...
    docker-centos: Generating Intel AMT MPS certificate...
    docker-centos: MeshCentral v0.5.50, LAN mode.
    docker-centos: Server has no users, next new account will be site administrator.
    docker-centos: MeshCentral HTTPS server running on port 443.
    docker-centos: meshcentral should be available on https://localhost:8443/
```

Then connect to `https://localhost:8443/` on your host, to load the
MeshCentral server's Web UI. Acknowledge the security risk warning, to
load the page, and you have it.

You then have to, for instance :
- create a new admin user
- login
- create a new group
- add a new agent, and select "Linux / BSD"
- then copy the script snippet which looks like:
```
(wget "https://localhost/meshagents?script=1" --no-check-certificate -O ./meshinstall.sh || wget "https://localhost/meshagents?script=1" --no-proxy --no-check-certificate -O ./meshinstall.sh) && chmod 755 ./meshinstall.sh && sudo -E ./meshinstall.sh https://localhost 'L0iyvvrYkWKZ00Jhx4GoUiyNW$OP3XqaFlLw4w8bbGUTd67gWp@MD@adcGiK3ONg' || ./meshinstall.sh https://localhost 'L0iyvvrYkWKZ00Jhx4GoUiyNW$OP3XqaFlLw4w8bbGUTd67gWp@MD@adcGiK3ONg'
```
- note the hash provided there, here it would be: `'L0iyvvrYkWKZ00Jhx4GoUiyNW$OP3XqaFlLw4w8bbGUTd67gWp@MD@adcGiK3ONg'`
- SSH to the VM using `vagrant ssh`
- then type: `sudo -E ./meshinstall.sh https://localhost 'L0iyvvrYkWKZ00Jhx4GoUiyNW$OP3XqaFlLw4w8bbGUTd67gWp@MD@adcGiK3ONg'`

This will install the Linux MeshCentral agent on the VM running MeshCentral (we already installed the agent's installation script `meshinstall.sh` at Vagrant provisionning).

This will result in the appearance of the `localhost.localdomain` agent in the group, in the MeshCentral Web interface.

The interface should then allow you to connect as root on the VM itself, from within the Web interface (right click on the `localhost.localdomain` icon and select "Terminal").
