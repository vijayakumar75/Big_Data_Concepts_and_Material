

import numpy as np


with open('C:/Users/spoli/Desktop/input/input2(5).txt', 'r') as document:
    array2d = [[int(digit) for digit in line[4:].split()] for line in document]




"""
    Arr is a matrix holding the actual distances.
    Returns the path and cost of the found solution
    """
def TSP_Nearest_Neighbor(Two_dimensional_array, building_start):
    
    # we have set the building_start at ZERO
    path = [building_start]
    time = 0 # start time
    N = Two_dimensional_array.shape[0]
    
    # maske keeps up with building hasn't been visited.
   
    mask = np.ones(N, dtype=bool)  
    mask[building_start] = False

    for i in range(N-1):
        lastbuilding = path[-1]
        next_ind = np.argmin(A[lastbuilding][mask]) # find minimum of remaining locations
        next_location = np.arange(N)[mask][next_ind] # convert to original location
        path.append(next_location)
        mask[next_location] = False
        time += A[lastbuilding, next_location]

    return "Path:" + str(path), "Time: "+  str(time)
    
     
TwoD_Arr = np.array(array2d)   
    
'''    
    
A = np.array([
   [0, 74, 4109, 3047, 2266], 
    [74, 0, 4069, 2999, 2213],
    [4109, 4069, 0, 1172, 1972], 
    [3047, 2999, 1172, 0, 816], 
    [2266, 2213, 1972, 816, 0]])
'''
print(TSP_Nearest_Neighbor(TwoD_Arr,0))