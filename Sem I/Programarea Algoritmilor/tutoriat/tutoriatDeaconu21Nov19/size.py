m = [
    [0, 1, 0],
    [0, 1, 1],
    [1, 0, 1]
]
nr = 0


def size(x, y):
    if x > 2 or y > 2 or x < 0 or y < 0 or m[x][y] == 0:
        return 0
    if m[x][y] == 1:
        m[x][y] = 0
        return 1+size(x-1, y)+size(x, y-1)+size(x+1, y)+size(x, y+1)


print(size(1, 1))
