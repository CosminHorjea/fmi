'''
1. Se dă o ecuație de gradul II de forma generala. Realizați un algoritm care să
determine rădăcinile acesteia.
'''
import math

a = int(input("introduceti ax^2+bx+c=0\n a="))
b = int(input("b="))
c = int(input("c="))
delta = b**2-4*a*c
if(delta < 0):
    x1 = int(((-1)*b-math.sqrt(-delta))/2*a)
    x2 = int(((-1)*b+math.sqrt(-delta))/2*a)
else:
    x1 = int(((-1)*b-math.sqrt(delta))/2*a)
    x2 = int(((-1)*b+math.sqrt(delta))/2*a)
print(x1, " ", x2)
