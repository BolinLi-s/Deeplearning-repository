import math
import numpy as np
res = []
with open('毛概2020春题库整合（有重复）.txt','r',encoding='utf-8') as f:
    tmp= ''
    count = 0
    for i in f:
        count+=1
        print(count, i)
        if i == '\n':
            res.append(tmp)
            tmp=''
        tmp+=str(i)
res = set(res)
with open('res.txt','w',encoding='utf-8') as w:
    count = 0
    for i in res:
        count +=1
        print(count)
        w.write(i)
