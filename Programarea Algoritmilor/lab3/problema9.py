cuvinte = {}
# nu stau sa-l formatez din rpogram, practic daca il citeam de la tastatura era acelasi lucru pt ca erau \n deja
# doar il pus in fiiser cu fiecar cuv pe o linie
with open('problema9.txt', 'r') as f:
    for x in f:
        cuv = x.split()[0]
        cuvinte[cuv] = x.count(cuv)+x.count("~")
        print((cuv, cuvinte[cuv]))
