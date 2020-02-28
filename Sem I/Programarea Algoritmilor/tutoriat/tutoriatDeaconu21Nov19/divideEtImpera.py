curr = 1

def cover(M, p1, p2, start, orientare_start):
    l, L = p1[0], p2[0]
    if(abs(L-l) < 2):
        return
    x,y=start
    if orientare_start == 0:
        M[x][y+1] = curr
        M[x+1][y+1] = curr
        M[x+1][y] = curr
        cover(M,p1,start,start,2)
        cover(M,(p1[0],y+1),(x,p2[1]),(x,y+1),3)
        cover(M,(p1[1],x+1),(p2[0],y),(x-1,y),1)
        cover(M,(x+1,y+1),p2,(x+1,y+1),0)
    elif orientare_start == 1:
        M[x][y-1] = curr
        M[x+1][y+1] = curr
        M[x-1][y+1] = curr
    elif orientare_start == 2:
        M[x-1][y]==curr
        M[x][y-1]==curr
        M[x-1][y-1]==curr
    elif orientare_start == 3:
        M[x-1][y-1]==curr
        M[x][y-1]==curr
        M[x+1][y]==curr



n = 4

M = [[0 for x in range(n)]for y in range(n)]
cover(M, (0, 0), (3, 3), (2, 1), 0)
