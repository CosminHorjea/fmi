n = int(input())
if n % 2 == 0 or n < 4:
    print("NO")
else:
    print(1, int((n-3)/2))

# r=x^2+2xy+x+1
# r-1 = x(x+2y+1)
# let x =1
# r-1 = 2(y+1)
# r = 2y +3
