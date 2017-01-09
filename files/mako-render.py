#!/usr/bin/python

from __future__ import print_function, unicode_literals

import argparse
import mako.template
import yaml

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("template")
    parser.add_argument("data")
    options = parser.parse_args()

    with open(options.template) as stream:
        template = mako.template.Template(stream.read())
    with open(options.data) as stream:
        data = yaml.load(stream)

    print(template.render(**data))

if __name__ == '__main__':
    main()
