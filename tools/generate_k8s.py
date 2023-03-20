#!/usr/bin/env python3
import sys
import yaml
import io

name = sys.argv[1]
imageName = sys.argv[2]
repoCwd = sys.argv[3]

whanosFile = repoCwd + "/whanos.yml"

with open(whanosFile, "r") as stream:
    try:
        whanosConfig = yaml.safe_load(stream)

        if not isinstance(whanosConfig['deployment']['replicas'], int):
            print("Replicas should be an int")
            sys.exit(1)

        for port in whanosConfig['deployment']['ports']:
            if not isinstance(port, int):
                print("Ports are expected to be an array of integers")
                sys.exit(1)

        deploymentContent = {
            'apiVersion': 'apps/v1',
            'kind': 'Deployment',
            'metadata': {
                'name': name,
                'labels': {
                    'app': name
                },
            },
            'spec': {
                'replicas': whanosConfig['deployment']['replicas'],
                'selector': {
                    'matchLabels': {
                        'app': name
                    }
                },
                'template': {
                    'metadata': {
                        'labels': {
                            'app': name
                        }
                    },
                    'spec': {
                        'containers': [
                            {
                                'name': name,
                                'image': imageName,
                                'resources': whanosConfig['deployment']['resources'],
                                'ports': [
                                    { 'containerPort': port } for port in whanosConfig['deployment']['ports']
                                ]
                            }
                        ]
                    }
                }
            }
        }

        serviceContent = {
            'apiVersion': 'v1',
            'kind': 'Service',
            'metadata': {
                'name': name,
            },
            'spec': {
                'selector': {
                    'app.kubernetes.io/name': name,
                },
                'ports': [
                    {
                        'protocol': 'TCP',
                        'port': port,
                        'targetPort': port
                    } for port in whanosConfig['deployment']['ports']
                ]
            }
        }

        with io.open(repoCwd + '/deployment.yml', 'w', encoding='utf8') as outfile:
            yaml.dump(deploymentContent, outfile, default_flow_style=False, allow_unicode=True)
        with io.open(repoCwd + '/service.yml', 'w', encoding='utf8') as outfile:
            yaml.dump(serviceContent, outfile, default_flow_style=False, allow_unicode=True)
    except yaml.YAMLError as exc:
        print(exc)
        sys.exit(1)