import math
import copy
import os
import time
import sys

timp_timeout = 0


def dropGrid(grid):
    """
        Primeste o matrice (tabla de joc) si duce piesele in jos si in stanga
    Args:
        grid(matrice) : tabla de joc
    Returns:
        newGrid(matrice) : o tabla de joc care are toate piesele fara spatii goale de dedesupt sau intre coloane
    """
    newGrid = copy.deepcopy(grid)
    w = len(grid[0])
    h = len(grid)
    move = 1
    while(move):
        move = 0
        for i in range(h):
            for j in range(w):
                if(newGrid[i][j] == "#" and i > 0 and newGrid[i-1][j] != "#"):
                    newGrid[i][j] = newGrid[i-1][j]
                    newGrid[i-1][j] = "#"
                    move = 1
    move = 1
    while(move):
        move = 0
        for col in range(w-1):
            currCol = []
            for row in range(h):
                currCol.append(newGrid[row][col])
            if(currCol == ["#"] * h):
                for row in range(h):
                    if(newGrid[row][col+1] != "#"):
                        move = 1
                        newGrid[row][col] = newGrid[row][col+1]
                        newGrid[row][col+1] = "#"
    return newGrid


def removeArea(grid, i, j):
    """
        Parcurge matricea de la coordonatele i,j si sterge zona din acele coordonate
    Args:
        grid(matrice) : tabla de joc
        i,j (int) : coordonatele in tabla de joc

    Returns:
        newGrid(matrice) : o noua tabla de joc care are zona de la coordonatele (i,j) schimbata cu "#" 
    """
    h = len(grid)
    w = len(grid[0])
    newGrid = copy.deepcopy(grid)
    directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
    searchedChar = newGrid[i][j]
    q = [(i, j)]
    while(len(q)):
        x, y = q.pop(0)
        newGrid[x][y] = "#"
        for d1, d2 in directions:
            nx = x+d1
            ny = y+d2
            if nx >= 0 and nx < h and ny >= 0 and ny < w:
                if(newGrid[nx][ny] == searchedChar):
                    q.append((nx, ny))
    return newGrid


def getNumberOfPiecesDropped(grid, i, j):
    """
    Args:
        grid: tabla de joc
        i,j : coordonatele din tabla de joc
    Returns:
        piecesCount (int) : numarul de piese care compune zona de la i,j
    """
    w = len(grid[0])
    h = len(grid)
    directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
    newGrid = copy.deepcopy(grid)
    searchedChar = grid[i][j]
    piecesCount = 0
    visited = set()
    q = [(i, j)]
    while(len(q)):
        x, y = q.pop(0)
        if((x, y) not in visited):
            visited.add((x, y))
        else:
            continue
        newGrid[x][y] = "#"
        piecesCount += 1
        for d1, d2 in directions:
            nx = x+d1
            ny = y+d2
            if nx >= 0 and nx < h and ny >= 0 and ny < w:
                if(newGrid[nx][ny] == searchedChar):
                    q.append((nx, ny))
    return piecesCount


def getFrequencyOfPieces(grid):
    """
    Args:
        grid(matrice) : tabla de joc
    Returns:
        freq(dict) : un dictionar care are perechi (key:value) unde key este piesa de pe tabla iar value este numarul de piese de pe toata tabla
    """
    freq = {}
    for linie in grid:
        for caracter in linie:
            if caracter != "#":
                if caracter not in freq:
                    freq[caracter] = 1
                else:
                    freq[caracter] += 1

    return freq


class NodParcurgere:
    gr = None

    def __init__(self, info, parinte, cost=0, h=0):
        self.info = info
        self.parinte = parinte
        self.g = cost
        self.h = h
        self. f = self.g + self.h

    def obtineDrum(self):
        l = [self]
        nod = self
        while nod.parinte is not None:
            l.insert(0, nod.parinte)
            nod = nod.parinte
        return l

    def afisDrum(
        self, output_file, afisCost=True, afisLung=True
    ):  # returneaza si lungimea drumului
        l = self.obtineDrum()
        for nod in l:
            output_file.write(str(nod)+"\n")
        if afisCost:
            output_file.write("Cost: " + str(self.g)+"\n")
        if afisLung:
            output_file.write("Lungime: " + str(len(l))+"\n")
        return len(l)

    def contineInDrum(self, infoNodNou):
        nodDrum = self
        while nodDrum is not None:
            if infoNodNou == nodDrum.info:
                return True
            nodDrum = nodDrum.parinte

    def __repr__(self):
        sir = ""
        for linie in self.info:
            sir += " ".join(linie)+"\n"
        # sir += " g: " + str(self.g) + " f: " + str(self.f)+"\n"
        return sir

    def __str__(self):
        sir = ""
        for linie in self.info:
            sir += " ".join(linie)+"\n"
        # sir += " g: " + str(self.g) + " f: " + str(self.f)
        return sir


class Graph:
    def __init__(self, nume_fisier):
        f = open(nume_fisier, "r")
        self.K = int(f.readline())
        self.start = []
        for line in f.readlines():
            self.start.append(list(line.strip()))
        self.width = len(self.start[0])
        self.height = len(self.start)
        self.scop = [["#" for _ in range(self.width)]
                     for y in range(self.height)]

    def testeaza_scop(self, nodCurent):
        return nodCurent.info == self.scop

    def verifExistentaSol(self, infoNod):
        freq = getFrequencyOfPieces(infoNod)
        for (key, val) in freq.items():
            if val < self.K:
                return False
        return True

    def genereazaSuccesori(self, nodCurent, tip_euristica="euristica banala"):
        listaSuccesori = []
        uniqueBoards = []
        board = nodCurent.info
        for i in range(len(board)):
            for j in range(len(board[i])):
                if(board[i][j] != "#"):
                    nextBoard = removeArea(board, i, j)
                    nextBoard = dropGrid(nextBoard)
                    piecesDropped = getNumberOfPiecesDropped(board, i, j)
                    totalPiecesOfCurrentType = getFrequencyOfPieces(board)[
                        board[i][j]]
                    if(nextBoard not in uniqueBoards):
                        uniqueBoards.append(nextBoard)
                        listaSuccesori.append(NodParcurgere(
                            nextBoard, nodCurent, nodCurent.g+(1+(totalPiecesOfCurrentType - piecesDropped)/totalPiecesOfCurrentType), self.calculeaza_h(nextBoard, tip_euristica)))
        return listaSuccesori

    def calculeaza_h(self, infoNod, tip_euristica="euristica banala"):
        if tip_euristica == "euristica banala":
            if infoNod != self.scop:
                return 1
        if tip_euristica == "euristica admisibila 1":
            '''
                Numaram culorile de pe tabla, trebuie sa fac cel putin o mutare de cost 1 pentru fiecare,
                deci euristica este admisibila
            '''
            res = getFrequencyOfPieces(infoNod)
            return len(res)

        if tip_euristica == "euristica admisibila 2":
            ''' 
                Numaram cate spatii goale sunt in matrice si intoarcem inversul
                Estimarea nu trece de 1 care este costul minim si este mai mare 
                cu cat sunt mai putine spatii goale
            '''
            nrLocuriCuPiese = 0
            for linie in infoNod:
                for caracter in linie:
                    if caracter == "#":
                        nrLocuriCuPiese += 1
            if nrLocuriCuPiese != 0:
                return 1/nrLocuriCuPiese
            return 0

        if tip_euristica == "euristica neadmisibila":
            '''
            Numar cate zone am pe tabla si scad numarul de culori
            inadmisibil, contra exemplu dat in documentatie
            '''
            uniqueBoards = []
            for i in range(len(infoNod)):
                for j in range(len(infoNod[i])):
                    if(infoNod[i][j] != "#"):
                        nextBoard = removeArea(infoNod, i, j)
                        nextBoard = dropGrid(nextBoard)
                        if(nextBoard not in uniqueBoards):
                            uniqueBoards.append(nextBoard)

            return len(uniqueBoards) - len(getFrequencyOfPieces(infoNod))

        return 0


def a_star(gr, nrSocutiiCautate, tip_euristica, output):
    if not gr.verifExistentaSol(gr.start):
        output.write("fara sol")
        return
    c = [NodParcurgere(gr.start, None, 0,
                       gr.calculeaza_h(gr.start, tip_euristica))]
    start_time = time.time()
    noduriInMemorie = 1
    noduriCalculate = 0
    while(len(c) > 0):
        if(timp_timeout < 1000 * (time.time()-start_time)):
            output.write("\nTimeout\n")
            print("Timeout")
            return

        nodCurent = c.pop(0)
        noduriCalculate += 1

        if gr.testeaza_scop(nodCurent):
            solution_time = time.time()
            output.write("Solutie A* "+tip_euristica+" : \n")
            output.write(
                "Timp: " + str(round(1000*(solution_time-start_time)))+" milisecunde\n")
            nodCurent.afisDrum(output_file=output)
            output.write("Numărul maxim de noduri: "+str(noduriInMemorie)+"\n")
            output.write("Numărul total de noduri calculate: " +
                         str(noduriCalculate))
            output.write("\n-------------\n")
            nrSocutiiCautate -= 1
            if nrSocutiiCautate == 0:
                return
        lSuccesori = gr.genereazaSuccesori(nodCurent, tip_euristica)
        noduriInMemorie += len(lSuccesori)
        for s in lSuccesori:
            i = 0
            while(i < len(c)):
                if c[i].f >= s.f:
                    break
                i += 1
            c.insert(i, s)


def ucs(gr, nrSolutiiCautate, output):
    if not gr.verifExistentaSol(gr.start):
        output.write("fara sol")
        return
    c = [NodParcurgere(gr.start, None, 0, 0)]

    start_time = time.time()
    noduriInMemorie = 1
    noduriCalculate = 0

    while len(c) > 0:
        # print(timp_timeout, " ", 1000*(time.time()-start_time))
        if(timp_timeout < 1000 * (time.time()-start_time)):
            output.write("\nTimeout\n")
            print("Timeout")
            return
        nodCurent = c.pop(0)
        noduriCalculate += 1

        if gr.testeaza_scop(nodCurent):
            solution_time = time.time()
            output.write("Solutie ucs: \n")
            output.write(
                "Timp: " + str(round(1000*(solution_time-start_time)))+" milisecunde\n")
            nodCurent.afisDrum(output_file=output)
            output.write("Numărul maxim de noduri: "+str(noduriInMemorie)+"\n")
            output.write("Numărul total de noduri calculate: " +
                         str(noduriCalculate))
            output.write("\n----------------\n")
            nrSolutiiCautate -= 1
            if nrSolutiiCautate == 0:
                return
        lSuccesori = gr.genereazaSuccesori(nodCurent)
        noduriInMemorie += len(lSuccesori)
        for s in lSuccesori:
            i = 0
            while i < len(c):
                if c[i].g > s.g:
                    break
                i += 1
            c.insert(i, s)


def a_star_optimizat(gr, tip_euristica, output):
    if not gr.verifExistentaSol(gr.start):
        output.write("fara sol")
        return
    # coada OPEN
    c = [
        NodParcurgere(
            gr.start, None, 0, gr.calculeaza_h(gr.start, tip_euristica)
        )
    ]
    closed = []
    start_time = time.time()
    noduriInMemorie = 1
    noduriCalculate = 0

    while len(c) > 0:
        if(timp_timeout < 1000 * (time.time()-start_time)):
            output.write("\nTimeout\n")
            print("Timeout")
            return
        nodCurent = c.pop(0)
        closed.append(nodCurent)
        noduriCalculate += 1

        if gr.testeaza_scop(nodCurent):
            solution_time = time.time()
            output.write("Solutie A* optimizat "+tip_euristica+" : \n")
            output.write(
                "Timp: " + str(round(1000*(solution_time-start_time)))+" milisecunde\n")
            nodCurent.afisDrum(output_file=output)
            output.write("Numărul maxim de noduri: "+str(noduriInMemorie)+"\n")
            output.write("Numărul total de noduri calculate: " +
                         str(noduriCalculate))
            output.write("\n--------------------\n")
            return

        lSuccesori = gr.genereazaSuccesori(nodCurent, tip_euristica)

        lSuccesoriCopy = lSuccesori.copy()
        for s in lSuccesoriCopy:
            gasitOpen = False
            for elem in c:
                if s.info == elem.info:
                    gasitOpen = True
                    if s.f < elem.f:
                        c.remove(elem)
                    else:
                        lSuccesori.remove(s)
                    break
            if not gasitOpen:
                for elem in closed:
                    if s.info == elem.info:
                        if s.f < elem.f:
                            closed.remove(elem)
                        else:
                            lSuccesori.remove(s)
                        break

        noduriInMemorie += len(lSuccesori)
        for s in lSuccesori:
            i = 0
            while i < len(c):
                if c[i].f >= s.f:
                    break
                i += 1
            c.insert(i, s)


# folosesc variabile globale pentu a tine numaratoarea nodurilor folosite la idastar
noduri_mem_idastar = 0
noduri_calculate_idastar = 0


def ida_star(gr, nrSolutiiCautate, tip_euristica, output):
    global noduri_calculate_idastar
    global noduri_mem_idastar
    if not gr.verifExistentaSol(gr.start):
        output.write("fara sol")
        return
    limita = gr.calculeaza_h(gr.start, tip_euristica)
    nodStart = NodParcurgere(
        gr.start, None, 0, gr.calculeaza_h(gr.start, tip_euristica)
    )
    noduri_mem_idastar = 1
    noduri_calculate_idastar = 1
    start_time = time.time()
    while True:
        # output.write("Limita de pornire: " + str(limita))

        nrSolutiiCautate, rez = construieste_drum(
            gr, nodStart, limita, nrSolutiiCautate, tip_euristica, output, start_time
        )
        if rez == "gata":
            break
        if rez == float("inf"):
            output.write("Nu exista suficiente solutii!")
            break
        limita = rez
        # output.write(">>> Limita noua: " + str(limita))


def construieste_drum(gr, nodCurent, limita, nrSolutiiCautate, tip_euristica, output, start_time):
    # output.write("A ajuns la: " + str(nodCurent))
    global noduri_calculate_idastar
    global noduri_mem_idastar
    if(timp_timeout < 1000 * (time.time()-start_time)):
        output.write("\nTimeout\n")
        print("Timeout")
        return nrSolutiiCautate, "gata"
    noduri_calculate_idastar += 1
    if nodCurent.f > limita:
        return nrSolutiiCautate, nodCurent.f

    if gr.testeaza_scop(nodCurent) and nodCurent.f == limita:
        output.write("Solutie: \n")
        nodCurent.afisDrum(output_file=output)
        output.write(str(limita))
        output.write("\nNoduri in memorie "+str(noduri_mem_idastar)+"\n")
        output.write("\nNoduri calculate "+str(noduri_calculate_idastar)+"\n")
        output.write("\n----------------\n")
        nrSolutiiCautate -= 1
        if nrSolutiiCautate == 0:
            return nrSolutiiCautate, "gata"
    lSuccesori = gr.genereazaSuccesori(nodCurent, tip_euristica)
    minim = float("inf")
    noduri_mem_idastar += len(lSuccesori)
    for s in lSuccesori:
        nrSolutiiCautate, rez = construieste_drum(
            gr, s, limita, nrSolutiiCautate, tip_euristica, output, start_time)
        if rez == "gata":
            return nrSolutiiCautate, "gata"
        # output.write("Compara "+str(rez) + " cu " + str(minim)+"\n")
        if rez < minim:
            minim = rez
            # output.write("Noul minim: " + str(minim)+"\n")
    return nrSolutiiCautate, minim


def main():
    global timp_timeout
    folder_input = sys.argv[1]
    folder_output = sys.argv[2]
    nrSolutiiCautate = int(sys.argv[3])
    timp_timeout = int(sys.argv[4]) * 1000
    if not os.path.exists(folder_output):
        os.mkdir(folder_output)
    for numeFisier in os.listdir(folder_input):
        gr = Graph(nume_fisier=folder_input+"/"+numeFisier)
        NodParcurgere.gr = gr
        g = open(folder_output+"/output_ucs_"+numeFisier, "w")
        ucs(gr, nrSolutiiCautate, g)
        for tip_euristica in ["euristica banala", "euristica admisibila 1", "euristica admisibila 2", "euristica neadmisibila"]:
            gr = Graph(nume_fisier=folder_input+"/"+numeFisier)
            NodParcurgere.gr = gr
            g = open(folder_output+"/output_astar_" +
                     tip_euristica+"_"+numeFisier, "w")
            a_star(gr, nrSocutiiCautate=nrSolutiiCautate,
                   tip_euristica=tip_euristica, output=g)

            gr = Graph(nume_fisier=folder_input+"/"+numeFisier)
            NodParcurgere.gr = gr
            g = open(folder_output+"/output_astaroptimizat_" +
                     tip_euristica+"_"+numeFisier, "w")
            a_star_optimizat(gr, tip_euristica=tip_euristica, output=g)

            gr = Graph(nume_fisier=folder_input+"/"+numeFisier)
            NodParcurgere.gr = gr
            g = open(folder_output+"/output_idastar_" +
                     tip_euristica+"_"+numeFisier, "w")
            ida_star(gr, nrSolutiiCautate,
                     tip_euristica=tip_euristica, output=g)


if __name__ == "__main__":
    main()

'''
Forma apelare
python3 placute.py inputs folder_output 3 1

'''
