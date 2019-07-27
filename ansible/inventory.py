#!/usr/bin/python

'''
Example custom dynamic inventory script for Ansible, in Python.
'''

import os
import sys
import argparse
import json


class ExampleInventory(object):

    def __init__(self):
        self.inventory = {}
        self.read_cli_args()

        self.appserver, self.dbserver = self.get_servers_ip() # servers ips

        
        if self.args.list:                              # Called with `--list`.
            self.inventory = self.get_inventory()
        elif self.args.host:                            # Called with `--host [hostname]`
            self.inventory = self.empty_inventory()     # Not implemented, since we return _meta info `--list`.
        else:
            self.inventory = self.empty_inventory()     # If no groups or vars are present, return an empty inventory

        print json.dumps(self.inventory);

    # Generate inventory
    def get_inventory(self):
        return {
                  "app": {
                        "hosts":["appserver"],
                        "vars": {
                        "ansible_host": self.appserver
                        }
                        },
                      "db": {
                        "hosts":["dbserver"],
                        "vars": {
                        "ansible_host": self.dbserver
                        }
                    }
                }

    # Empty inventory for testing.
    def empty_inventory(self):
        return {'_meta': {
                        'hostvars': {}
                    }
                }
    def get_servers_ip(self):
        with open('terraform.tfstate.example', 'r') as file:
        # with open(os.path.expanduser('~/ihoochie_infra/terraform/stage/terraform.tfstate'), 'r') as file:
            state = json.load(file)

        for module in state['modules']:
            if module["path"] == ['root']:
                appserver = module["outputs"]["app_external_ip"]["value"]
                dbserver = module["outputs"]["db_external_ip"]["value"]
            else:
                pass
        return appserver, dbserver


    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

# Get the inventory.
ExampleInventory()
