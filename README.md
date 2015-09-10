# boot2docker-automounter
A docker container that automounts Virtualbox shared folders on the boot2docker host.

```
docker run -d --restart=always --privileged -v /proc:/hproc --name automounter jrotter/boot2docker-automounter
```
