import sys
import re


def main(argv):
    
    my_dict = {}
    line = sys.stdin.readline()
    while line:

        line = line.strip()
        word, vowelCount = line.split('\t', 1)
        #print(word, vowelCount)

        key = vowelCount
        if key in my_dict:
            my_dict[key] += 1
        else:
            my_dict[key] = 1

        line = sys.stdin.readline()

    # print(my_dict)

    #for k, v in my_dict.items(): print(str(k) + ":" + str(v))

    for key in sorted(my_dict):
          print( "%s : %s" % (key, my_dict[key]))

    sys.stderr.write(str(my_dict))

if __name__ == "__main__":
    main(sys.argv)


