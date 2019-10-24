'''
Today he invented one simple game to play with Lena, with whom he shares a desk. The rules are simple. Sasha draws n sticks in a row. After that the players take turns crossing out exactly k sticks from left or right in each turn. Sasha moves first, because he is the inventor of the game. If there are less than k sticks on the paper before some turn, the game ends. Sasha wins if he makes strictly more moves than Lena. Sasha wants to know the result of the game before playing, you are to help him.
'''
n, k = map(int, input().split())
if(n % k == 0 and n != 1 and (n//k) % 2 == 0):
    print("NO")
elif(n % k and (n//k) % 2 == 0):
    print("NO")
else:
    print("YES")
# 6 2
# 6 3
