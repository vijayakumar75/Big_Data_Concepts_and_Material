#!/usr/bin/python

from pig_util import outputSchema

@outputSchema("out:float")
def polirevVal(AB, H, G,E):
    AB1 = float(AB)
    H1 = float(H)
    G1 = float(G)
    E1 = float(E)
    
    out = ((H1/AB1) -(E1/G1))

    return out
