# Mergesort


def merge_lists(lst, ldr):
    i = j = 0

    rez = []
    while i < len(lst) and j < len(ldr):
        if lst[i] <= ldr[j]:
            rez.append(lst[i])
            i += 1
        else:
            rez.append(ldr[j])
            j += 1

    rez.extend(lst[i:])
    rez.extend(ldr[j:])

    return rez


def merge_sort(ls):
    if len(ls) <= 1:
        return ls
    else:
        mij = len(ls) // 2
        lst = merge_sort(ls[:mij])
        ldr = merge_sort(ls[mij:])
        return merge_lists(lst, ldr)


ls = [2, 1, 100, 1, 10, 7, 15, 15, 10, 15, 2, 2, 1, 3, 1]
print(ls)
ls = merge_sort(ls)
print(ls)
