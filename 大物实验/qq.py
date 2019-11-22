import math
def calculate_q(u, t):
    yita = 1.83e-5
    b = 6.17e-6
    p = 76
    d = 5e-3
    rou = 981
    g = 9.797
    l = 1.5e-3

    vg = l / t
    r = ((9*yita*vg) /(2*rou*g))**0.5
    yita_ = yita / (1 + b/(p*r))

    q = (18*math.pi)/(2*rou*g)**0.5 * (yita_ * vg )**1.5 *d/u
    return q

tuples = [
    (74, 6.14),
    (60, 11.89),
    (81, 9.10),
    (55,13.20),
    (51,8.17),
    (96,9.78),
    (83, 6.27),
    (104, 10.92)
]

e = 1.602e-19
# for u,t in tuples:
#     q = calculate_q(u,t)
#     print(q, q/e, round(q/e), (q/e)/(round(q/e)))

lists = [1.01,1,0.98,1.03,1.01,0.99,1,0.99]
def MSE(lists):
    average = sum(lists) / len(lists)
    print(average)
    list_ = [k-average for k in lists]
    print(list_)

    print('残差')
    print(sum(list_))
    print(len(lists))
    print(sum(list_) / len(lists))

    print('相对误差')
    relative = []

    for i in range(len(lists)):
        relative.append(abs(list_[i]) / lists[i])
    print(sum(relative) / len(lists))
    square = [k**2 for k in list_]

    print('均方误差')
    sums = sum(square)
    print(sums)


MSE(lists)