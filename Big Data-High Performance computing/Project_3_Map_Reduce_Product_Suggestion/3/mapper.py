import sys
import re


def main(argv):
    line = sys.stdin.readline()

    pattern = re.compile("[a-zA-Z0-9]+")

    while line:
        s = line[0]
        list2 = []

        # print(line)
        list1 = line.strip()
        colon = list1.index(':')
        exclamation = list1.index('!')

        # if(list1[i] != " "): print((list1[i]))

        for i in range(colon + 1, exclamation):
            if (list1[i] != " "):
                list2.append(list1[i])
        print(s , (sorted(list2)))
        # print(s, sorted(list2))

        line = sys.stdin.readline()


if __name__ == "__main__":
    main(sys.argv)
