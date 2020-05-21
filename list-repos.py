#!/bin/env python3

import yaml


with open('./configuration.yaml') as f:
    config = yaml.load(f)

for git_service in config.get('git_services'):
    host = git_service['host']
    if '://' not in host:
        host = f'https://{host}'
    for repo in git_service['repos']:
        print(f'{host}/{repo}')
