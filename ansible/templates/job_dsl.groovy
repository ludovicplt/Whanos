
folder('Projects') {
    description('Tools for the Jenkins server')
}

folder('Whanos base images') {
    description('Base images for Whanos.')
}

freeStyleJob('Whanos base images/Build all base images') {
    steps {
        downstreamParameterized {
            {% for file in languagedirs.files %}
                trigger('Whanos base images/whanos-{{ file.path | basename }}')
            {% endfor %}
        }
    }
}


{% for file in languagedirs.files %}
    freeStyleJob('Whanos base images/whanos-{{ file.path | basename }}') {
        steps {
            shell('/opt/tools/build_base_image.sh {{ file.path | basename }}')
        }
    }
{% endfor %}

freeStyleJob('link-project') {
    parameters {
        stringParam('GIT_REPOSITORY', '', 'Git repository (e.g. https://github.com/user/repo.git)')
        stringParam('DISPLAY_NAME', '', 'Display name (the name of the job, must not contain special characters, e.g. My Project)')
        stringParam('IMAGE_NAME', '', 'Image name (must not contain spaces or special characters, e.g. my-project)')
    }
    steps {
        dsl {
            text('''freeStyleJob("Projects/${IMAGE_NAME}") {
                        scm {
                            git {
                                remote {
                                    name('origin')
                                    url("${GIT_REPOSITORY}")
                                }
                            }
                        }
                        wrappers {
                            preBuildCleanup()
                        }
                        triggers {
                            scm('* * * * *')
                        }
                        steps {
                            shell('cat /var/jenkins_home/whanos.txt')
                            shell("/opt/tools/build_image.sh ${IMAGE_NAME}")
                            shell("/opt/tools/register_image.sh ${IMAGE_NAME}")
                            shell("/opt/tools/deploy.sh ${IMAGE_NAME}")
                        }
                    }'''.stripIndent())
        }
    }
}