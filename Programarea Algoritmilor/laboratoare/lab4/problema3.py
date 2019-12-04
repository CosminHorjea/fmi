def min_max(*argv):
    if(argv):
        return min(argv), max(argv)
    return None


g = open('problema3.out', 'w')
try:
    with open('problema3.txt', 'r') as f:
        i = map(int, f.readline().split())
        nr_min, nr_max = min_max(*i)
        try:
            impartire = nr_max/nr_min
            g.write(str(impartire))
        except:
            g.write("Impartie nevalida")
        finally:
            g.close()
except:
    print("Fisier Not Found")
