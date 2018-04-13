#!/usr/bin/env python
import sys

def main(argv):
    current_Combo=None
    current_count=0
    the_Combo=None

	## Expect input to be sorted by key already
    for line in sys.stdin:
        line = line.strip() ## remove leading and trailing blanks
        line = line.replace(" ", "") ## remove blanks in between
        the_Combo, count = line.split(':', 1) # split pair on ':' character
        sys.stderr.write(the_Combo)
        sys.stderr.write('\n')

        count = int(count) ## make sure count value is a valid number

        if current_Combo == the_Combo:
            current_count += count
        else:
            if current_Combo: ## checks current_number isn't empty, as in initial case
                print('%s : %s' % (current_Combo, current_count))

            ## set current_count and current_combo to values read in
            current_count = count
            current_Combo = the_Combo

    if current_Combo == the_Combo: ## checks if any value to print at end
        print('%s : %s' % (current_Combo, current_count))

if __name__ == "__main__":
    main(sys.argv)
