import logging
import sys
import itertools

# a list that contains the input without the numbers after "!" sign
# [['2', '3', '5'], ['1', '3', '4', '5'], ['1', '2', '4'], ['2', '3'], ['1', '2']]
masterList = []

#this intersects and finds the set of n lists and returns the SET number
def intersect(lists):
    return list(set.intersection(*map(set, lists)))

# returns a list of combinations of i.e [1,2,3,4,5)
def returner1(stuff_1):
    DList = []
    for L in range(0, len(stuff_1)+1):
        for subset in itertools.combinations(stuff_1, L):
            lists = []
            if len(subset) >= 2:
                lists = subset
                DList.append(list(lists))
    return DList


# returns a list of combinations of i.e [['2', '3', '5'], ['1', '3', '4', '5'], ['1', '2', '4'], ['2', '3'], ['1', '2']]
def returner2(stuff_2):
    Dlist = []
    for L in range(0, len(stuff_2)+1):
        for subset in itertools.combinations(stuff_2, L):
            if len(subset) >= 2:
                lists_1 = subset
                Dlist.append(intersect(lists_1))
    return Dlist


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
        line = sys.stdin.readline()


    # this will be length of the masterlist which will be used towards firsthalf of output after getting all combinations
    masterListLengthElements = []
    for i in range(0,len(masterList)):
        masterListLengthElements.append(i + 1)

    #two lists which will contain the out puts 1st half will go in firstList and 2ndhalf will go in secondList
    #[x, y, z] : set[z]
    firstList = returner1(masterListLengthElements)
    secondList = returner2(masterList)


    #gets rid of all brackets,commas, and apostrphes
    for i,j in zip(firstList,secondList):
        print(" ".join(map(str,i)) +" : "+ " ".join(map(str,j)))
        #logging.debug(" ".join(map(str,i)) +" : "+ " ".join(map(str,j)))
        sys.stderr.write(" ".join(map(str,i)) +" : "+ " ".join(map(str,j)))



if __name__ == "__main__":
    main(sys.argv)
