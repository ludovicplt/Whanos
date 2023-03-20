# Getting started

## Install Ansible

You first need to have python3. [If not installed, Install it following the instructions here](https://www.python.org/downloads/).

> Note: on some distributions or OS, you might need to use `python` instead of `python3`.

Please check you're having Python 3.

```
python3 -V
Python 3.11.0

# or

python -V
Python 3.11.0
```

Verify whether pip is already installed for your preferred Python:
```
python3 -m pip -V
```

If all is well, you should see something like the following:
```
python3 -m pip -V
pip 21.0.1 from /usr/lib/python3.9/site-packages/pip (python 3.9)
```
If so, pip is available, and you can move on to the next step.

If you see an error like No module named pip, you’ll need to install pip under your chosen Python interpreter before proceeding. This may mean installing an additional OS package (for example, python3-pip), or installing the latest pip directly from the Python Packaging Authority by running the following:

```
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python3 get-pip.py --user
```

You may need to perform some additional configuration before you are able to run Ansible. See the Python documentation on installing to the user site for more information.

Installing Ansible
Use pip in your selected Python environment to install the Ansible package of your choice for the current user:
```
python3 -m pip install --user ansible
```
## Set up Whanos

To launch the Whanos project you need a server, a virtual machine, or a virtual container based on Ubuntu 22.04 LTS and with an SSH access. 

### Configure Whanos

In the `ansible/group_vars` folder, your can find and edit your configurations.

There are two configuration files, `all.yml` and `vault`.

The `vault` file is encrypted using `ansible-vault`.

You can edit it using `ansible-vault edit ./vault`.

The content of the vault looks like this:

```yaml
jenkins_user_admin_name: {DISPLAYNAME}
jenkins_user_admin_id: {USERNAME}
jenkins_user_admin_password: {PASSWORD}

docker_registry_user: {USERNAME}
docker_registry_password: {PASSWORD}
```

> Note: you can set up another `docker_registry_host` registry, for example GitLab or GitHub Container Registry.

### Configure Kubernetes (kubectl)

kubectl will be run locally by Jenkins inside of a container.

To configure it accordingly, still inside of the `ansible` folder, you need to create a file named `kubeconfig.yml`. If you use DigitalOcean, for example, a configuration file is already provided right on the dashboard.

> When deploying, your nodes will need to have access to the Docker registry. See Connect Kubernetes to the Whanos Registry.

### Install Whanos

Go to the `ansible` folder.

Create an `hosts` file.

```ini
[primary]
jenkins ansible_host={TARGET HOST} ansible_user={TARGET USER}
registry ansible_host={TARGET HOST} ansible_user={TARGET USER}
```

- `{TARGET HOST}` is the IP or hostname of the distant SSH server.
- `{TARGET USER}` is the username used to connect to the SSH server. This user must have access to `sudo` or have root access. By default, on Ubuntu, the first user you created has this access.

You may reuse the same host for the different services.

```
ansible-playbook -i hosts --ask-vault-pass -kKvvv playbook.yml
```

> If you need to specify an user (e.g. `sudo -u BECOME_USER ...`), you can use the ansible `--become-user BECOME_USER` argument. If you have more complex installation, feel free to check out arguments available with `ansible-playbook -h`.

You will first be prompt the target user password, and then the password required to run the `sudo` command on the distant server.

### Check Kubernetes
You will be able to use the kubectl used by Jenkins by using `/opt/tools/kubectl.sh` instead.

```bash
$ alias kubectl="sudo /opt/tools/kubectl.sh"

$ kubectl get nodes
NAME                   STATUS    ROLES   AGE      VERSION
master.example.com     Ready     master  1h       v1.17.x+x.x.x.el7
worker1.example.com    Ready     <none>  1h       v1.17.x+x.x.x.el7
worker2.example.com    Ready     <none>  1h       v1.17.x+x.x.x.el7
```