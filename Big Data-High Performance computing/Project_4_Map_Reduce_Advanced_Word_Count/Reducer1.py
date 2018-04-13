#!/usr/bin/env python

import sys

def main(argv):
    current_number = None
    current_count = 0
    the_number = None

    for line in sys.stdin:
        line = line.strip()
        line = line.replace(" ", "")

	the_number, count = line.split(':',1)


        
        count = int(count)
        if current_number == the_number:
            current_count += count
        else:
            if current_number:
                print('%s : %s' % (current_number, current_count))
            current_count = count
            current_number = the_number

    if current_number == the_number:
        print('%s : %s' % (current_number, current_count))
if __name__ == "__main__":
    main(sys.argv)

