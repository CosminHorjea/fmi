max1 = 0
max2 = 1

n = int(input("n="))

for i in range(n):
    x = int(input())  # treuie apasat enter dupa fiecare numar
    if(x > max1):
        max2 = max1
        max1 = x
    elif(x > max2 and x != max1):
        max2 = x
print(max1, " si ", max2)
