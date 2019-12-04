n = int(input("n="))
frecv = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
while n > 0:
    frecv[n % 10] += 1
    n //= 10
frecv2 = frecv
for i in range(9, 0, -1):
    while(frecv[i] != 0):
        print(i, end="")
        frecv[i] -= 1
# print()
for i in range(1, 9, 1):
    while(frecv2[i] != 0):
        print(i, end="")
        frecv2[i] -= 1
