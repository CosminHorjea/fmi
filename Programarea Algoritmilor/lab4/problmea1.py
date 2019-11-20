from math import sqrt

# a)


def ipotenuza(a, b):
    return sqrt(a**2+b**2)


# print(ipotenuza(3, 4))
 # b)
f = open('triplete_pitagorice.txt', 'w')
b = int(input())
for a in range(1, b):
    if(float(ipotenuza(a, b)).is_integer()):
        s = ""+str(a)+" "+str(b)+" "+str(int(ipotenuza(a, b)))+"\n"
        f.write(s)
f.close()
