import glob
import collections
import re


#glob.glob looks for part-* wildcards and creates a file name merged which goes through and writes
#all the content to one single file
#The .read() method of a file handle reads the contents of a file and produces a string of it's contents
read_files = glob.glob("part-*")

with open("merged.txt", "wb") as outfile:
    #iterates through each part file
    for f in read_files:
        with open(f, "rb") as infile:
            outfile.write(infile.read())



# a dictonary will add all the key value pairs
myvars = {}
#line.partition and string splicing gets "1,2,3" gets rid of whatever is in 2nd position... so key \t value... tab is ommited
with open("merged.txt") as myfile:
    na = ''
    for line in myfile:
        name, var = line.partition(':')[::2]

        name = (name.strip())

        if(name.isdigit()):
            na = int(name)
        myvars[(na)] = var.strip()

#sorts by keys
print(myvars)

od = collections.OrderedDict(sorted(myvars.items()))



with open("output.txt", "wt") as ofile:
    for i in od:
        ofile.write((str(i)+'\t'+ od[i])+'\n')