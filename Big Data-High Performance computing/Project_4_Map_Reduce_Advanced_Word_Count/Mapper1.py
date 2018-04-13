#!/usr/bin/env python

import sys
import re

def main(argv):
    line = sys.stdin.readline()
    line = line.strip()
    
    while line:
        for word in re.split('\s+', line):
            vowels = re.findall('[aeiouy]', word, re.IGNORECASE)
            vowel_len = len(vowels)
            print(str(vowel_len) + " : " + "1")
        line = sys.stdin.readline()
        line = line.strip()


if __name__ == "__main__":
    main(sys.argv)

    
