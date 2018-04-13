import sys
import itertools


masterList = []
lists = []

def intersect(lists):
    return list(set.intersection(*map(set, lists)))



def main(argv):
    line = sys.stdin.readline()
    while line:
        line = line.strip()

        num, ListofItems = line.split(" ", 1)
        list99 = []

        for i in ListofItems:
            if (i.isdigit()):
                list99.append(i)

        # print(type(list99))
        masterList.append(list99)

        # print("----------------")
        line = sys.stdin.readline()

    print(masterList)
    print(len(masterList))

    stuff = masterList
    for L in range(0, len(stuff)+1):
        for subset in itertools.combinations(stuff, L):
            if len(subset) >= 2:
                lists = subset
                print(subset, (intersect(lists)))



if __name__ == "__main__":
    main(sys.argv)
