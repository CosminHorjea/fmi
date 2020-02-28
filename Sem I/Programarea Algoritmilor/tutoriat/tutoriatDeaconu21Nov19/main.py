from heapModified import *


def cmp(pair_1, pair_2):
    return pair_1[1] < pair_2[1]


def huffman(frecv):
    tati = {}
    fii = {}
    lista = list(frecv.items())
    # print(lista)
    heap = get_heap(lista, cmp=cmp)
    while(len(heap) > 1):
        left = pop_min_from_heap(heap, cmp=cmp)
        right = pop_min_from_heap(heap, cmp=cmp)
        new_item = (left[0]+right[0], left[1]+right[1])
        insert_item_into_heap(heap, new_item, cmp=cmp)
        # print(heap)
        # tati[left[0]+right[0]] = left[1]+right[1]
        tati[left[0]] = new_item[0]
        tati[right[0]] = new_item[0]
        fii[new_item[0]] = [left[0], right[0]]
        # print(final)
    final = {key: '' for key in frecv.keys()}
    # final = {**final, **tati}
    # print(final)
    final.update({
        key[1]: '' for key in tati.items()
    })
    # print(final)
    # print(tati)
    fii = list(fii.items())
    fii.reverse()
    # print(fii)
    # print(final)
    for fiu in fii:
        cheie = fiu[0]
        left, right = fiu[1]
        print(cheie, left, right)
        final[left] = '0'+final[cheie]
        final[right] = '1'+final[cheie]
    print(final)

    # returneaza codificare huffman
dict = {
    'a': 3,
    'b': 7,
    'c': 2,
    'd': 10,
    'e': 11,
    'f': 20
}

# for i in dict.items():
#     lista.append(i)
huffman(dict)
