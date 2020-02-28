g = open('plata.txt', 'w')
with open('bani.txt') as f:
    money = list(map(int, f.readline().split()))
    targetSum = int(f.readline())
solution = []
money.sort(reverse=True)
for i in money:
    cash = targetSum//i
    solution.append(cash)
    targetSum -= cash*i
# print(solution)
for i in range(len(money)):
    if solution[i]:
        g.write(str(money[i])+"*"+str(solution[i]))
        if(i != (len(money)-1)):
            g.write("+")
g.close()
