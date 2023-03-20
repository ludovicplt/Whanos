FROM jenkins/jenkins:2.332.1
USER root
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli
RUN groupadd -g 999 docker
RUN usermod -aG docker jenkins
RUN usermod -aG docker root
USER jenkins
RUN jenkins-plugin-cli --plugins "configuration-as-code cloudbees-folder credentials github job-dsl script-security structs role-strategy ws-cleanup parameterized-trigger"
COPY ./jenkins.yml /var/jenkins_home/casc_configs/jenkins.yml
COPY ./job_dsl.groovy /var/jenkins_home/casc_configs/job_dsl.groovy
COPY ./whanos.txt /var/jenkins_home/whanos.txt

USER root
ARG DOCKER_REGISTRY_HOST
ARG DOCKER_REGISTRY_USER
RUN mkdir -p /var/lib/jenkins
RUN echo "${DOCKER_REGISTRY_HOST}" > /var/lib/jenkins/registry_host.txt
RUN chmod 644 /var/lib/jenkins/registry_host.txt

RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
RUN mv kubectl /usr/bin/
RUN chmod +x /usr/bin/kubectl
COPY ./.registry.txt /var/lib/jenkins/registry_pwd.txt
RUN chown jenkins /var/lib/jenkins/registry_pwd.txt
RUN apt-get update && apt-get install -y python3 python3-pip
RUN pip3 install PyYAML

USER jenkins
WORKDIR /var/jenkins_home/casc_configs

ENTRYPOINT ["sh", "-c", "cat /var/lib/jenkins/registry_pwd.txt | docker login --username ${DOCKER_REGISTRY_USER} --password-stdin ${DOCKER_REGISTRY_HOST} && /usr/bin/tini -- /usr/local/bin/jenkins.sh"]