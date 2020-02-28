import random


# random choice e doar in caz ca nu dam parametru
def quickselect(l, k, pivot_fn=random.choice):

    pivot = pivot_fn(l)

    lows = [el for el in l if el < pivot]  # el mai mici dacat pivotul
    highs = [el for el in l if el > pivot]  # mai mari
    pivots = [el for el in l if el == pivot]  # si egale

    if k < len(lows):  # daca sunt mai multe elemente mai mici deact pivotul
        # inseamna ca al k-lea minim e in acele elemente
        return quickselect(lows, k, pivot_fn)
    elif k < len(lows) + len(pivots):  # daca alea mai mici si pivotii sunt mai multi de k
        return pivots[0]  # clar un pivot e k-lea mic element
    else:
        # daca nu si nu, caut in alea mai mari dar caut pt al k-lea din care scad nr de alea mai mici si egale ca pivoti
        return quickselect(highs, k - len(lows) - len(pivots), pivot_fn)


def pick_pivot(l):

    if len(l) <= 5:
        return sorted(l)[len(l)//2]  # daca e mai mic decat 5 intorc mediana

    chunks = [sorted(l[i:i + 5]) for i in range(0, len(l), 5)
              ]  # impart lista in liste de lung 5
    # print(chunks)

    # pun intr-o lista toate medianele la alea de lungime 5
    medians = [chunk[len(chunk)//2] for chunk in chunks]
    # print(medians)

    return pick_pivot(medians)  # do it again


ls = [17, 4, 10, 2, 9, 3, 15, 34, 21, 7, 7, 2, 17, 4, 10, 2, 9, 8,
      3, 15, 34, 21, 7, 7, 2, 17, 4, 10, 2, 9, 3, 15, 34, 21, 7, 7, 2]

k = 5
print(quickselect(ls, k, pick_pivot))
