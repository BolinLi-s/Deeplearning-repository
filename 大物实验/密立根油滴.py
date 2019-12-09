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

# tuples = [
#     (74, 6.14),
#     (60, 11.89),
#     (81, 9.10),
#     (55,13.20),
#     (51,8.17),
#     (96,9.78),
#     (83, 6.27),
#     (104, 10.92)
# ]


# tuples = [
#     (205,27.92),
#     (235,11.82),
#     (216,6.00),
#     (160,8.13),
#     (189,9.90),
#     (183,16.72),
#     (189,9.67),
#     (211,8.64),
#     (164,10.48),
#     (164,10.52),
#     (268,5.47)
# ]

tuples = [
    (315,5.99),
    (185,20.41),
    (172,16.92),
    (154,9.57),
    (644,6.70),
    (211,8.55),
    (331,13.93),
    (293,15.63),
    (203,6.2),
    (197,15.88),
]

e = 1.602e-19

lists = []
print("电荷    电荷量     计算电荷量     图线斜率")
for u,t in tuples:
    q = calculate_q(u,t)

    print(q, q/e, round(q/e), (q/e)/(round(q/e)))
    lists.append((q/e)/(round(q/e)))

def MSE(lists):
    average = sum(lists) / len(lists)
    print(average)
    list_ = [k-average for k in lists]
    print(list_)

    # print('残差')
    # print(sum(list_))
    # print(len(lists))
    print("残差平均值")
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

