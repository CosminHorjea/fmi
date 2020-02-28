cuvinte = {}
# nu a zis din fisier dar nu pun in conola romane de fiecare data
with open("problema3.txt", 'r') as f:
    for x in f:  # asta ia fiecare paragraf
        for char in x.lower():
            if(cuvinte.get(char)):
                cuvinte[char] += 1
            else:
                cuvinte[char] = 1
rez = cuvinte.items()

for item in sorted(rez):
    print(item[0], ": ", item[1])
