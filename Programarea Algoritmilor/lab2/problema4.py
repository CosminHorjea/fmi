'''
4. Scrieți un program care să se verifice dacă două șiruri de caractere sunt anagrame sau nu. Două
șiruri sunt anagrame dacă unul se poate obține din celălalt printr-o permutare a caracterelor sale. De
exemplu, șirurile emerit și treime sunt anagrame, dar șirurile emerit și treimi nu sunt! Indicație de
rezolvare (fără structuri de date auxiliare și fără sortare): Se caută, pe rând, fiecare caracter din
primul șir în cel de-al doilea. În cazul în care caracterul nu este găsit înseamnă că șirurile nu sunt
anagrame, altfel se șterge caracterul din cel de-al doilea șir și se trece la următorul caracter din
primul șir. Atenție, folosind această metodă, cel de-al doilea șir va fi modificat!
'''
# n, m = input().split()
n = "emerit"
m = "treimi"
ok = 0
if(len(n) != len(m)):
    print('nu')
else:
    for i in range(len(n)):
        for j in range(len(m)):
            if(n[i] == m[j]):
                m = m[:j]+m[j+1:]
                ok = 1
                j = 0
                break
        if(not ok):
            print('nu')
            break
if(len(m)):
    print('no')
else:
    print("yes")
