# Access the Whanos registry

```
docker login localhost:5000
```

you can then pull your images by doing

```
docker pull localhost:5000/{image_name}
```

## Login remotely in an insecure way (dev environment only)

by default, unless configured with a certificate, the registry doesn't use https, however docker expects an https registry for remote access

> you should probably contact your sysadmin to setup a certificate!

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