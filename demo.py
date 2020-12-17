import math
import numpy as np

def ddd(x):
    return -x*math.log(x,2)

a = ddd(0.64) + 2*ddd(0.16) + ddd(0.04)
b = ddd(0.8) + ddd(0.2)
b = ddd(8/3)
print(b)
