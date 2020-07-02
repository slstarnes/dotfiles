#!/usr/bin/env python3

import argparse

PATTERN = '# ' + '@' * 30

parser = argparse.ArgumentParser()
parser.add_argument('original', help='original file')
parser.add_argument('dotfile', help='dotfile file')
args = parser.parse_args()
original_file = args.original
new_file = args.dotfile
with open(original_file, 'r') as f: original_content=f.read()
with open(new_file, 'r') as f: new_content=f.read()

if PATTERN in original_content:
    inside = original_content[original_content.find(PATTERN):original_content[::-1].find(PATTERN)]
    new_content = PATTERN + '\n' + new_content + '\n' + PATTERN
    updated_content = original_content.replace(inside, new_content)
else:
    updated_content = original_content + '\n' * 2 + PATTERN + '\n' + new_content + '\n' + PATTERN
with open(original_file, 'w') as f: f.write(updated_content)
