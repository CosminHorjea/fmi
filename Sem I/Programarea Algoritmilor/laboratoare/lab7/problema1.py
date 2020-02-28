f = open('date1.in', 'r')

piese = []

n = int(f.readline())
T = [[0 for x in range(n+1)] for y in range(n)]

for _ in f.readlines():
    piese.append(list(map(int, _.split())))

for i in range(n+1):
    
