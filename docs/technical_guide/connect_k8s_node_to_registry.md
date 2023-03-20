# Connect your Kubernetes node to the Whanos registry

```
docker login localhost:5000
```

## Login remotely in an insecure way (dev environment only)

by default, unless configured with a certificate, the registry doesn't use https, however docker expects an https registry for remote access

> you might want to setup the registry with a certificate!

on your local computer, edit or create a file in `/etc/docker/daemon.json` (or `C:\ProgramData\docker\config\daemon.json`).

put in it:

```json
{
  "insecure-registries" : ["http://{server}:5000"]
}
```

you then need to restart docker for changes to take effect! (`sudo systemctl restart docker`)

and then you can connect to it:

```
docker login {server}:5000
```