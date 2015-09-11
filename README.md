boot2docker-automounter
=======================

A docker container that automounts Virtualbox shared folders on the boot2docker host.

Linux guests on VirtualBox automatically mount the shared folders by using the VBoxService from the guest additions.
Unfortunately boot2docker is unable to run the VBoxService, so it just tries to automatically mount C:\Users folder, others need to be mounted manually.
The boot2docker-automounter fixes that drawback and mounts all shared folders automatically.

In order to use the boot2docker-automounter, run inside the boot2docker machine:
```
docker run -d --restart=always --privileged -v /proc:/hproc --name automounter jrotter/boot2docker-automounter
```

**Note:** Running the command from Windows host is likely to fail. You have to get inside the boot2docker machine by
running `boot2docker ssh` or `docker-machine ssh`

How does it work?
=================

The boot2docker-automounter runs a VBoxService to obtain the names of shares. The mounts are then performed by jumping into the boot2docker host
mount namespace with `nsenter` and running the required mount command.
