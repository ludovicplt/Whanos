# How to make a project

## Set up the repo

First create a public git repo for Whanos, you can use GitHub or GitLab for this.

The default supported languages are:

- C;
- Java;
- JavaScript;
- Python;
- Befunge

### C

#### Easy install (standalone)

Create a repo with a `Makefile`. The generated executable must be named `compiled-app`.

#### More complex install (custom Dockerfile)

Create a repo with a `Makefile`. The generated executable must be named `compiled-app`.

You can create a `Dockerfile` that is based on the `whanos-c` image.

Example:

```dockerfile
FROM whanos-c
RUN apt-get update && apt-get install -y \
    my-dependencies
```

### Java

#### Easy install (standalone)

Create a repo with a `pom.xml`. The generated jarfile must be in `target/app.jar`.

#### More complex install (custom Dockerfile)

Create a repo with a `pom.xml`. The generated jarfile must be in `target/app.jar`.

You can create a `Dockerfile` that is based on the `whanos-java` image.

Example:

```dockerfile
FROM whanos-java
RUN some-command
```

### JavaScript

#### Easy install (standalone)

Create a repo with a `package.json`. The startup file must be named `index.js`.

#### More complex install (custom Dockerfile)

Create a repo with a `package.json`. The startup file must be named `index.js`.

You can create a `Dockerfile` that is based on the `whanos-javascript` image.

Example:

```dockerfile
FROM whanos-javascript
RUN npm run build
```

### Python

#### Easy install (standalone)

Create a repo with a `requirements.txt`. The startup file must be named `app.py`.

#### More complex install (custom Dockerfile)

Create a repo with a `requirements.txt`. The startup file must be named `app.py`.

You can create a `Dockerfile` that is based on the `whanos-python` image.

Example:

```dockerfile
FROM whanos-python
RUN some-command
```

### Befunge

#### Easy install (standalone)

Create a repo with a `src/main.bf` file. The startup file must be named `src/main.bf`.

#### More complex install (custom Dockerfile)

Create a repo with a `src/main.bf` file. The startup file must be named `src/main.bf`.

You can create a `Dockerfile` that is based on the `whanos-befunge` image.

Example:

```dockerfile
FROM whanos-befunge
RUN some-command
```

## Setup deployment with Kubernetes

At the root of your project, create a file named `whanos.yml`:

```
deployment:
  replicas: 3
  resources:
    limits:
      memory: "128M"
    requests:
      memory: "64M"
  ports:
    - 3000

```