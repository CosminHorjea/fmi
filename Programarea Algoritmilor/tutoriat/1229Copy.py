from collections import defaultdict
n = int(input())

a = list(map(int, input().split()))

b = list(map(int, input().split()))


# declar un dict mai special, https://stackoverflow.com/questions/5900578/how-does-collections-defaultdict-work
hash = defaultdict(int)

for i, j in enumerate(a):
    # e fix ca un vector de frecv, doar ca nu aloc memorie pt spatiile nefolosite
    hash[j] += 1
# print(hash) {3: 2, 2: 1, 6: 1}
res = 0
for i in range(n):
    for k in hash:  # ptr fiecare cheie in hashtable
        # print(k)
        if hash[k] > 1:  # daca sunt mai mult de 1 elev cu skilurile alea
            if a[i] | k == k:  # si daca k are are toate skillurile lui a[i] + oricate;
                           # ceea ce inseamana ca a[i] are clar mai mai putine skilluri decat k despre care stim ca sunt minim 2 , deci pot sa fie in echipa fara nicio problema, deci a[i] nu constituie o problema
                res += b[i]  # adaug la rezultat val b[i]
                break        # nu mai caut alt element pt acelasi i
print(res)
# e smart AF, nu am facut-o eu but hey, am scris comentariile
