t = int(input())
for test in range(t):
    n = int(input())
    p = list(map(int, input().split()))
    m = int(input())
    q = list(map(int, input().split()))
    nr = 0
    # print(*p, " ", *q)
    pare1, pare2, impare1, impare2 = 0, 0, 0, 0
    for i in p:
        if(i % 2):
            impare1 += 1
        else:
            pare1 += 1
    for j in q:
        if(j % 2):
            impare2 += 1
        else:
            pare2 += 1
    # numeri pare si impare si dupa vezi cate sume sunt pare
    print(pare1*pare2+impare1*impare2)
