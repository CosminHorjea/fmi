def insert_item_into_heap(heap, item):
    """
    Functia adauga un nou element, item, la min-heap-ul heap.
    heap este sub forma unei liste care respecta proprietatile de min-heap.
    """
    heap.append(item)
    son_index = len(heap) - 1
    dad_index = (son_index - 1) // 2
    while son_index > 0 and heap[son_index] < heap[dad_index]:
        pair = heap[son_index], heap[dad_index]
        heap[dad_index], heap[son_index] = pair
        # then for the next step:
        son_index = dad_index
        dad_index = (dad_index - 1) // 2


def get_heap(given_list):
    """
    Functia returneaza un nou min-heap prin adaugarea succesiva
        a elementelor din lista primita respectand regulile de min-heap.
    """
    heap = []
    for item in given_list:
        insert_item_into_heap(heap, item)
    return heap


def pop_min_from_heap(heap):
    """
    Functia elimina si returneaza minimul din min-heap-ul primit.
    
    In mare, eliminarea se face prin a muta ultimul element in locul primului,
        si al "cobori" pe cat este necesar, pentru a reface toate
        proprietatile de min-heap.
    """
    if len(heap) == 1:
        return heap.pop()
    top = heap[0]
    
    # Apoi, punem ultimul element din lista ca top
    #   si, eventual, noul top va trebui "impins" mai jos in heap (*):
    heap[0] = heap[-1]
    heap.pop()  # echivalent cu heap.pop(-1)
    index = 0
    not_a_leaf = index * 2 + 1 < len(heap)  # True daca nodul nu a ajuns pe ultimul strat,
        # deci se poate sa mai trebuiasca coborat
        
    while not_a_leaf:  # atentie, trebuie cel mai mic dintre fii pus in locul sau
        left_index = index * 2 + 1
        right_index = left_index + 1

        # cazul 1, avem doar fiu stang
        if right_index >= len(heap):
            if heap[index] > heap[left_index]:
                pair = heap[index], heap[left_index]
                heap[left_index], heap[index] = pair
            # and we stop:
            break
            # gasim fiul cu valoarea mai mica

        # cazul 2: avem doi fii
        min_index = left_index  # presupunem ca fiul stang este minim
        if heap[right_index] < heap[min_index]:
            min_index = right_index  # gasim ca fiul drept este minim
        if heap[index] > heap[min_index]:
            # acum ca stim care fiu este minim, il interschimbam cu tatal
            pair = heap[index], heap[min_index]
            heap[min_index], heap[index] = pair
            #   si continuam la pasul urmator:
            index = min_index
            not_a_leaf = index * 2 + 1 < len(heap)
        else:
            break
    return top


def heap_sorted(given_list):
    heap = get_heap(given_list)
    sorted_list = []
    while heap:
        sorted_list.append(pop_min_from_heap(heap))
    return sorted_list
