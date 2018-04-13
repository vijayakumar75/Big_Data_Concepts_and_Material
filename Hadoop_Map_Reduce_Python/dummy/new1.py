import itertools
t = (['2', '3', '5'], ['1', '3', '4', '5'], ['1', '2', '4'], ['2', '3'])

p = []
p = t

def intersect(p):
    return list(set.intersection(*map(set, p)))

print(intersect(p))


