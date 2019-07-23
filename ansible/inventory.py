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

        
        if self.args.list:                              # Called with `--list`.
            self.inventory = self.example_inventory()
        elif self.args.host:                            # Called with `--host [hostname]`
            self.inventory = self.empty_inventory()     # Not implemented, since we return _meta info `--list`.
        else:
            self.inventory = self.empty_inventory()     # If no groups or vars are present, return an empty inventory

        print json.dumps(self.inventory);

    # Example inventory for testing.
    def example_inventory(self):
        return {
                  "app": {
                    "hosts":["34.77.235.46"]
                    },
                  "db": {
                    "hosts":["35.195.183.166"]
                    }
                }

    # Empty inventory for testing.
    def empty_inventory(self):
        return {'_meta': {
                        'hostvars': {
                            "appserver": {
                            "ansible_host" : "34.77.235.46"
                            },
                            "dbserver": {
                            "ansible_host" : "35.195.183.166"
                            }
                        }
                }
                }


    # Read the command line args passed to the script.
    def read_cli_args(self):
        parser = argparse.ArgumentParser()
        parser.add_argument('--list', action = 'store_true')
        parser.add_argument('--host', action = 'store')
        self.args = parser.parse_args()

# Get the inventory.
ExampleInventory()
