from random import randint

# string that holds the aniamls
str = 'CDFM'

lst = []

#we create a 100000 pet oweners sample
while len(lst) != 100000:
    s = ''
    #The pet range can be from 4 pets to 6 pets in number
    r = randint(4,6)
    for i in range(0,r):
        i = randint(0,3)
        s = s + str[i]
        s.strip()
    lst.append(s)
    #print(randint(0,3))


#for e in lst:
 #   print(e)


# splits every 5 elments in a list an joins them with a space
composite_list = [" ".join(lst[x:x+5]) for x in range(0, len(lst),5)]

#print(composite_list)

for l in composite_list:
    print(l)



with open('input2.txt','w') as the_file:
    for l in composite_list:
        the_file.write((l) +'\n')


