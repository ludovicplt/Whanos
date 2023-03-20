# Setup the registry

## Setup a certificate (setup https)

- put your certificate in `registry/certs`

- edit `ansible/group_vars/all.yml` and put:

```yaml
docker_registry_additional_env: >
  REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt
  REGISTRY_HTTP_TLS_KEY=/certs/domain.key
```

- deploy!
