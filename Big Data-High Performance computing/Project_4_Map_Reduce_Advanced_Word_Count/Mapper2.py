#!/usr/bin/env python
import sys
import re

def main(argv):
    line = sys.stdin.readline()
    line = line.strip()
    while line:
		## For each line, get the words in the line
        for combo in re.split('\s+', line):
            s =""
			# cats,dogs,monkey etc..
            combos = re.findall('[CDFM]', combo, re.IGNORECASE)
			
			#sort the combos
            combos= sorted(combos)
			
			#re create the combo in alphabetical order
            for i in combos:
                s += i

            print(str(s) + " : " + "1")
        line = sys.stdin.readline()
        line = line.strip()

if __name__ == "__main__":
    main(sys.argv)

