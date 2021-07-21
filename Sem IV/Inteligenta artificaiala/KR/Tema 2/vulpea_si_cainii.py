# Horjea Cosmin-Marian, 243

import time
import copy
import pygame
import sys
import statistics

ADANCIME_MAX = 6

timpi_calculator = []
noduri_calculator = []
noduri_curente = 0
numar_mutari_pc = 0
numar_mutari_player = 0
timp_start_joc = 0


def getFoxPosition(matr):
    """
        Primeste o matrice si intoarce pozitia vulpii
    """

    for i in range(8):
        for j in range(8):
            if matr[i][j] == "x":
                return (i, j)


def getMovesForFox(matr):
    """
        returns a list of pairs that are valid moves for a fox inside "matr"
    """
    moves = []
    directions = [[1, 1], [1, -1], [-1, 1], [-1, -1]]
    i, j = getFoxPosition(matr)
    if matr[i][j] == "x":
        for direction in directions:
            new_i = i+direction[0]
            new_j = j+direction[1]
            if new_i >= 0 and new_i < 8 and new_j >= 0 and new_j < 8:
                if(matr[new_i][new_j] == Joc.GOL):
                    moves.append((new_i, new_j))
    return moves


def getMovesForDog(matr, i, j):
    """
        matr - tabla de joc
        i,j - pozitita pe care se afla un caine
        Returns - perechi de care sunt valide pentru cainele de pe pozitia i,j
    """
    moves = []
    directions = [[+1, -1], [+1, +1]]  # mutam doar in jos pe diagonala
    for direction in directions:
        new_i = i+direction[0]
        new_j = j+direction[1]
        if new_i >= 0 and new_i < 8 and new_j >= 0 and new_j < 8:
            if(matr[new_i][new_j] == Joc.GOL):
                moves.append((new_i, new_j))
    # print("Mutari: ", len(moves))
    return moves


def estimare1(matr, jucator):
    """
        Calculam cat de despartiti sunt cainii pe randuri iar vulpea cat de sus se afla pe tabla
        daca vuplea este mai sus decat ultimul caine, atunci mutarea este foarte rea pentru caini si intoarcem -100
    """
    fox_y, fox_x = getFoxPosition(matr)
    max_y, min_y = 0, 8
    max_x, min_x = 0, 8

    for i in range(len(matr)):
        for j in range(len(matr[0])):
            if(matr[i][j] == "0"):
                max_y = max(max_y, i)
                min_y = min(min_y, i)
    if(jucator == "x"):
        return -fox_y * 2
    else:
        if(fox_y < min_y + 1):
            return -100
        return -(max_y - min_y) * 3


def estimare2(matr, jucator):
    """
        calculam cat de despartiti sunt cainii pe harta in stanga si dreapta vulpii
        vulpea are un scor mai mare cu cat este mai sus
    """
    fox_y, fox_x = getFoxPosition(matr)
    offset = 0
    min_y = 10
    for i in range(len(matr)):
        for j in range(len(matr[0])):
            if(matr[i][j] == "0" and i > fox_y):
                min_y = min(min_y, i)
                offset = abs(j - fox_x)
    if(jucator == "0"):
        if(fox_y < min_y + 1):
            return -100
        return -offset*3
    else:
        return -fox_y*2


class Joc:
    """
    Clasa care defineste jocul. Se va schimba de la un joc la altul.
    """

    JMIN = None
    JMAX = None
    GOL = "#"
    NR_LINII = None
    NR_COLOANE = None
    scor_maxim = 0

    def __init__(self, matr=None):

        if matr:
            # e data tabla, deci suntem in timpul jocului
            self.matr = matr
        else:
            # nu e data tabla deci suntem la initializare
            self.matr = [
                [self.__class__.GOL] * self.__class__.NR_COLOANE
                for i in range(self.__class__.NR_LINII)
            ]
            self.matr[0][1] = "0"
            self.matr[0][3] = "0"
            self.matr[0][5] = "0"
            self.matr[0][7] = "0"
            self.matr[7][0] = "x"

    def deseneaza_grid(self, possible_moves=None):
        """
            possible_moves = o lsita cu perechi i,j de mutai valide pentru piesa selectata
        """
        for linie in range(self.__class__.NR_LINII):
            for coloana in range(self.__class__.NR_COLOANE):
                if possible_moves and (linie, coloana) in possible_moves:
                    # daca am o patratica selectata, o desenez cu rosu
                    culoare = (255, 255, 0)
                else:
                    if((linie + coloana) % 2):
                        culoare = (61, 235, 52)
                    else:
                        culoare = (22, 99, 18)

                pygame.draw.rect(
                    self.__class__.display,
                    culoare,
                    self.__class__.celuleGrid[
                        linie * self.__class__.NR_COLOANE + coloana
                    ],
                )
                if self.matr[linie][coloana] == "x":
                    self.__class__.display.blit(
                        self.__class__.x_img,
                        (
                            coloana * (self.__class__.dim_celula + 1),
                            linie * (self.__class__.dim_celula + 1),
                        ),
                    )
                elif self.matr[linie][coloana] == "0":
                    self.__class__.display.blit(
                        self.__class__.zero_img,
                        (
                            coloana * (self.__class__.dim_celula + 1),
                            linie * (self.__class__.dim_celula + 1),
                        ),
                    )
        pygame.display.update()

    @classmethod
    def jucator_opus(cls, jucator):
        return cls.JMAX if jucator == cls.JMIN else cls.JMIN

    @classmethod
    def initializeaza(cls, display, NR_LINII=6, NR_COLOANE=7, dim_celula=200):
        cls.NR_LINII = NR_LINII
        cls.NR_COLOANE = NR_COLOANE

        cls.display = display
        cls.dim_celula = dim_celula
        cls.scor_maxim = 100
        cls.x_img = pygame.image.load("fox.png")
        cls.x_img = pygame.transform.scale(cls.x_img, (dim_celula, dim_celula))
        cls.zero_img = pygame.image.load("dog2.png")
        cls.zero_img = pygame.transform.scale(
            cls.zero_img, (dim_celula, dim_celula))
        cls.celuleGrid = []  # este lista cu patratelele din grid
        for linie in range(NR_LINII):
            for coloana in range(NR_COLOANE):
                patr = pygame.Rect(
                    coloana * (dim_celula + 1),
                    linie * (dim_celula + 1),
                    dim_celula,
                    dim_celula,
                )
                cls.celuleGrid.append(patr)

    def final(self):
        """
            Daca vulpea ajunge pe ultimul rand, castiga
            Daca vulpea nu mai are mutari disponibile pierde
            Atunci cand cainii nu mai au mutari, vuplea castiga
        """
        # if not self.ultima_mutare:  # daca e inainte de prima mutare
        #     return False
        rez = False
        for i in range(8):
            if self.matr[0][i] == "x":
                rez = "x"
        if len(getMovesForFox(self.matr)) == 0:
            rez = "0"
        len_mutari_caini = 0
        for i in range(Joc.NR_LINII):  # daca nu mai pot face mutari cu cainii
            for j in range(Joc.NR_COLOANE):
                if(self.matr[i][j] == "0"):
                    len_mutari_caini += len(getMovesForDog(self.matr, i, j))
        if len_mutari_caini == 0:
            rez = "x"
        if rez:
            return rez
        else:
            return False

    def mutari(self, jucator):
        """
            Calculez mutarile posibile cu functiile de mai sus, in functie de jucator
        """
        # print("Jucator: ", jucator)
        l_mutari = []
        if(jucator == "x"):  # vulpea
            possible = getMovesForFox(self.matr)
            fox_x, fox_y = getFoxPosition(self.matr)
            for x, y in possible:
                matr_tabla_noua = copy.deepcopy(self.matr)
                matr_tabla_noua[fox_x][fox_y] = Joc.GOL
                matr_tabla_noua[x][y] = jucator
                jn = Joc(matr_tabla_noua)
                # jn.ultima_mutare = (x, y)
                l_mutari.append(jn)
        elif(jucator == "0"):  # cainii
            for linie in range(len(self.matr)):
                for coloana in range(len(self.matr[0])):
                    if(self.matr[linie][coloana] == "0"):
                        possible = getMovesForDog(self.matr, linie, coloana)
                        for x, y in possible:
                            matr_tabla_noua = copy.deepcopy(self.matr)
                            matr_tabla_noua[linie][coloana] = Joc.GOL
                            matr_tabla_noua[x][y] = jucator
                            jn = Joc(matr_tabla_noua)
                            # jn.ultima_mutare = (x, y)
                            l_mutari.append(jn)
        return l_mutari

    def estimeaza_scor(self, adancime):
        t_final = self.final()

        if t_final == self.__class__.JMAX:
            return self.__class__.scor_maxim + adancime
        elif t_final == self.__class__.JMIN:
            return -self.__class__.scor_maxim - adancime
        elif t_final == "remiza":
            return 0
        else:
            return estimare2(self.matr, self.__class__.JMAX) - estimare2(self.matr, self.__class__.JMIN)

    def sirAfisare(self):
        sir = "  |"
        sir += " ".join([str(i) for i in range(self.NR_COLOANE)]) + "\n"
        sir += "-" * (self.NR_COLOANE + 1) * 2 + "\n"
        sir += "\n".join(
            [
                str(i) + " |" + " ".join([str(x) for x in self.matr[i]])
                for i in range(len(self.matr))
            ]
        )
        return sir

    def __str__(self):
        return self.sirAfisare()

    def __repr__(self):
        return self.sirAfisare()


class Stare:
    """
    Clasa folosita de algoritmii minimax si alpha-beta
    Are ca proprietate tabla de joc
    Functioneaza cu conditia ca in cadrul clasei Joc sa fie definiti JMIN si JMAX (cei doi jucatori posibili)
    De asemenea cere ca in clasa Joc sa fie definita si o metoda numita mutari() care ofera lista cu configuratiile posibile in urma mutarii unui jucator
    """

    def __init__(self, tabla_joc, j_curent, adancime, parinte=None, scor=None):
        self.tabla_joc = tabla_joc
        self.j_curent = j_curent

        # adancimea in arborele de stari
        self.adancime = adancime

        # scorul starii (daca e finala) sau al celei mai bune stari-fiice (pentru jucatorul curent)
        self.scor = scor

        # lista de mutari posibile din starea curenta
        self.mutari_posibile = []

        # cea mai buna mutare din lista de mutari posibile pentru jucatorul curent
        self.stare_aleasa = None

    def mutari(self):
        l_mutari = self.tabla_joc.mutari(self.j_curent)
        juc_opus = Joc.jucator_opus(self.j_curent)
        l_stari_mutari = [
            Stare(mutare, juc_opus, self.adancime - 1, parinte=self)
            for mutare in l_mutari
        ]

        return l_stari_mutari

    def __str__(self):
        sir = str(self.tabla_joc) + "(Juc curent:" + self.j_curent + ")\n"
        return sir

    def __repr__(self):
        sir = str(self.tabla_joc) + "(Juc curent:" + self.j_curent + ")\n"
        return sir


""" Algoritmul MinMax """


def min_max(stare):
    global noduri_curente
    noduri_curente += 1
    if stare.adancime == 0 or stare.tabla_joc.final():
        stare.scor = stare.tabla_joc.estimeaza_scor(stare.adancime)
        return stare

    # calculez toate mutarile posibile din starea curenta
    stare.mutari_posibile = stare.mutari()

    # aplic algoritmul minimax pe toate mutarile posibile (calculand astfel subarborii lor)
    mutari_scor = [min_max(mutare) for mutare in stare.mutari_posibile]

    if stare.j_curent == Joc.JMAX:
        # daca jucatorul e JMAX aleg starea-fiica cu scorul maxim
        stare.stare_aleasa = max(mutari_scor, key=lambda x: x.scor)
    else:
        # daca jucatorul e JMIN aleg starea-fiica cu scorul minim
        stare.stare_aleasa = min(mutari_scor, key=lambda x: x.scor)
    stare.scor = stare.stare_aleasa.scor
    return stare


def alpha_beta(alpha, beta, stare):
    global noduri_curente
    noduri_curente += 1
    if stare.adancime == 0 or stare.tabla_joc.final():
        stare.scor = stare.tabla_joc.estimeaza_scor(stare.adancime)
        return stare

    if alpha > beta:
        return stare  # este intr-un interval invalid deci nu o mai procesez

    stare.mutari_posibile = stare.mutari()

    if stare.j_curent == Joc.JMAX:
        scor_curent = float("-inf")

        for mutare in stare.mutari_posibile:
            # calculeaza scorul
            stare_noua = alpha_beta(alpha, beta, mutare)

            if scor_curent < stare_noua.scor:
                stare.stare_aleasa = stare_noua
                scor_curent = stare_noua.scor
            if alpha < stare_noua.scor:
                alpha = stare_noua.scor
                if alpha >= beta:
                    break

    elif stare.j_curent == Joc.JMIN:
        scor_curent = float("inf")

        for mutare in stare.mutari_posibile:

            stare_noua = alpha_beta(alpha, beta, mutare)

            if scor_curent > stare_noua.scor:
                stare.stare_aleasa = stare_noua
                scor_curent = stare_noua.scor

            if beta > stare_noua.scor:
                beta = stare_noua.scor
                if alpha >= beta:
                    break
    stare.scor = stare.stare_aleasa.scor

    return stare


def afis_daca_final(stare_curenta):
    final = stare_curenta.tabla_joc.final()
    if final:
        if final == "remiza":
            print("Remiza!")
        else:
            if(final == "x"):
                final = "vulpea"
            else:
                final = "cainii"
            print("*************************")
            print("A castigat jucatorul cu " + final)
            print("*************************")
        afiseaza_statistici()
        return True

    return False


class Buton:
    def __init__(
        self,
        display=None,
        left=0,
        top=0,
        w=0,
        h=0,
        culoareFundal=(53, 80, 115),
        culoareFundalSel=(89, 134, 194),
        text="",
        font="arial",
        fontDimensiune=16,
        culoareText=(255, 255, 255),
        valoare="",
    ):
        self.display = display
        self.culoareFundal = culoareFundal
        self.culoareFundalSel = culoareFundalSel
        self.text = text
        self.font = font
        self.w = w
        self.h = h
        self.selectat = False
        self.fontDimensiune = fontDimensiune
        self.culoareText = culoareText
        fontObj = pygame.font.SysFont(self.font, self.fontDimensiune)
        self.textRandat = fontObj.render(self.text, True, self.culoareText)
        self.dreptunghi = pygame.Rect(left, top, w, h)
        self.dreptunghiText = self.textRandat.get_rect(
            center=self.dreptunghi.center)
        self.valoare = valoare

    def selecteaza(self, sel):
        self.selectat = sel
        self.deseneaza()

    def selecteazaDupacoord(self, coord):
        if self.dreptunghi.collidepoint(coord):
            self.selecteaza(True)
            return True
        return False

    def updateDreptunghi(self):
        self.dreptunghi.left = self.left
        self.dreptunghi.top = self.top
        self.dreptunghiText = self.textRandat.get_rect(
            center=self.dreptunghi.center)

    def deseneaza(self):
        culoareF = self.culoareFundalSel if self.selectat else self.culoareFundal
        pygame.draw.rect(self.display, culoareF, self.dreptunghi)
        self.display.blit(self.textRandat, self.dreptunghiText)


class GrupButoane:
    def __init__(
        self, listaButoane=[], indiceSelectat=0, spatiuButoane=10, left=0, top=0
    ):
        self.listaButoane = listaButoane
        self.indiceSelectat = indiceSelectat
        self.listaButoane[self.indiceSelectat].selectat = True
        self.top = top
        self.left = left
        leftCurent = self.left
        for b in self.listaButoane:
            b.top = self.top
            b.left = leftCurent
            b.updateDreptunghi()
            leftCurent += spatiuButoane + b.w

    def selecteazaDupacoord(self, coord):
        for ib, b in enumerate(self.listaButoane):
            if b.selecteazaDupacoord(coord):
                self.listaButoane[self.indiceSelectat].selecteaza(False)
                self.indiceSelectat = ib
                return True
        return False

    def deseneaza(self):
        # atentie, nu face wrap
        for b in self.listaButoane:
            b.deseneaza()

    def getValoare(self):
        return self.listaButoane[self.indiceSelectat].valoare


############# ecran initial ########################
def deseneaza_alegeri(display, tabla_curenta):
    btn_alg = GrupButoane(
        top=30,
        left=30,
        listaButoane=[
            Buton(display=display, w=80, h=30,
                  text="minimax", valoare="minimax"),
            Buton(display=display, w=80, h=30,
                  text="alphabeta", valoare="alphabeta"),
        ],
        indiceSelectat=1,
    )
    btn_juc = GrupButoane(
        top=100,
        left=30,
        listaButoane=[
            Buton(display=display, w=50, h=30, text="vulpea", valoare="x"),
            Buton(display=display, w=45, h=30, text="cainii", valoare="0"),
        ],
        indiceSelectat=0,
    )
    btn_dif = GrupButoane(
        top=150,
        left=30,
        listaButoane=[
            Buton(display=display, w=45, h=30, text="usor", valoare="2"),
            Buton(display=display, w=45, h=30, text="mediu", valoare="5"),
            Buton(display=display, w=45, h=30, text="greu", valoare="7")
        ],
        indiceSelectat=0
    )
    ok = Buton(
        display=display,
        top=200,
        left=30,
        w=40,
        h=30,
        text="ok",
        culoareFundal=(155, 0, 55),
    )
    btn_alg.deseneaza()
    btn_juc.deseneaza()
    btn_dif.deseneaza()
    ok.deseneaza()
    while True:
        for ev in pygame.event.get():
            if ev.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif ev.type == pygame.MOUSEBUTTONDOWN:
                pos = pygame.mouse.get_pos()
                if not btn_alg.selecteazaDupacoord(pos):
                    if not btn_juc.selecteazaDupacoord(pos):
                        if not btn_dif.selecteazaDupacoord(pos):
                            if ok.selecteazaDupacoord(pos):
                                tabla_curenta.deseneaza_grid()
                                return btn_juc.getValoare(), btn_alg.getValoare(), btn_dif.getValoare()
        pygame.display.update()


def afiseaza_statistici():
    global timpi_calculator
    global noduri_calculator
    global numar_mutari_pc, numar_mutari_player
    print("Timp minim ", min(timpi_calculator))
    print("Timp maxim ", max(timpi_calculator))
    print("Timp mediu ", statistics.mean(timpi_calculator))
    print("Timp median ", statistics.median(timpi_calculator))
    print("----------------------")
    print("Numar minim noduri: ", min(noduri_calculator))
    print("Numar maxim noduri: ", max(noduri_calculator))
    print("Numar mediu noduri: ", statistics.mean(noduri_calculator))
    print("Numarul median de noduri: ", statistics.median(noduri_calculator))
    print()
    print("Numar mutari pc : ", numar_mutari_pc)
    print("Numar mutari player: ", numar_mutari_player)
    print("Timp Joc: ", int(round(time.time() * 1000))-timp_start_joc)


def main():
    global timp_start_joc
    timp_start_joc = int(round(time.time() * 1000))
    global timpi_calculator
    global ADANCIME_MAX
    global numar_mutari_pc, numar_mutari_player
    # setari interf grafica
    pygame.init()
    pygame.display.set_caption("Horjea Cosmin-Marian | Vulpea si cainii")
    # dimensiunea ferestrei in pixeli
    nl = 8
    nc = 8
    w = 100
    ecran = pygame.display.set_mode(
        size=(nc * (w + 1) - 1, nl * (w + 1) - 1)
    )  # N *100+ N-1= N*(100+1)-1
    Joc.initializeaza(ecran, NR_LINII=nl, NR_COLOANE=nc, dim_celula=w)

    # initializare tabla
    tabla_curenta = Joc()
    Joc.JMIN, tip_algoritm, depth_alg = deseneaza_alegeri(ecran, tabla_curenta)
    ADANCIME_MAX = int(depth_alg)
    print(Joc.JMIN, tip_algoritm)

    Joc.JMAX = "0" if Joc.JMIN == "x" else "x"

    print("Tabla initiala")
    print(str(tabla_curenta))

    # creare stare initiala
    stare_curenta = Stare(tabla_curenta, "x", ADANCIME_MAX)
    print("Adancime", ADANCIME_MAX)

    tabla_curenta.deseneaza_grid()
    piesa_aleasa = []
    t_initial = int(round(time.time() * 1000))
    timpi = [t_initial]
    while True:
        if stare_curenta.j_curent == Joc.JMIN:
            for event in pygame.event.get():
                if event.type == pygame.QUIT:
                    afiseaza_statistici()
                    pygame.quit()
                    sys.exit()
                elif event.type == pygame.MOUSEBUTTONDOWN:

                    pos = pygame.mouse.get_pos()  # coordonatele cursorului

                    for np in range(len(Joc.celuleGrid)):
                        if Joc.celuleGrid[np].collidepoint(pos):
                            coloana = np % Joc.NR_COLOANE
                            linie = np // Joc.NR_LINII
                            # daca am selectat piesa pe care vreau sa o mut
                            if len(piesa_aleasa):
                                numar_mutari_player += 1
                                if(stare_curenta.tabla_joc.matr[linie][coloana] == stare_curenta.j_curent):
                                    # schimb piesa aleasa
                                    piesa_aleasa = [linie, coloana]
                                    stare_curenta.tabla_joc.deseneaza_grid(
                                        possible_moves=getMovesForDog(
                                            stare_curenta.tabla_joc.matr, linie, coloana)
                                    )
                                    continue
                                x = piesa_aleasa[0]
                                y = piesa_aleasa[1]
                                if(stare_curenta.tabla_joc.matr[x][y] == "x"):
                                    if((linie, coloana) not in getMovesForFox(stare_curenta.tabla_joc.matr)):
                                        break
                                if(stare_curenta.tabla_joc.matr[x][y] == "0"):
                                    if((linie, coloana) not in getMovesForDog(stare_curenta.tabla_joc.matr, x, y)):
                                        break
                                stare_curenta.tabla_joc.matr[linie][coloana] = Joc.JMIN
                                stare_curenta.tabla_joc.matr[x][y] = Joc.GOL
                                piesa_aleasa = []

                                stare_curenta.tabla_joc.deseneaza_grid()
                                # testez daca jocul a ajuns intr-o stare finala
                                # si afisez un mesaj corespunzator in caz ca da
                                t_dupa = int(round(time.time() * 1000))
                                print(
                                    'Jucatorul a "gandit" timp de '
                                    + str(t_dupa - timpi[-1])
                                    + " milisecunde."
                                )

                                if afis_daca_final(stare_curenta):
                                    break

                                # S-a realizat o mutare. Schimb jucatorul cu cel opus
                                stare_curenta.j_curent = Joc.jucator_opus(
                                    stare_curenta.j_curent
                                )
                            else:
                                # ma asigur ca am apasat pe o piesa care imi apartine
                                if(stare_curenta.tabla_joc.matr[linie][coloana] != stare_curenta.j_curent):
                                    continue
                                # daca nu am selectat un partat gol, setez variabila de piesa
                                if(stare_curenta.tabla_joc.matr[linie][coloana] != Joc.GOL):
                                    piesa_aleasa = [linie, coloana]
                                    possible_moves = []
                                    if(stare_curenta.j_curent == "x"):
                                        possible_moves = getMovesForFox(
                                            stare_curenta.tabla_joc.matr)
                                    else:
                                        possible_moves = getMovesForDog(
                                            stare_curenta.tabla_joc.matr, linie, coloana)
                                    # desenez tabla cu mutarile posibile
                                    stare_curenta.tabla_joc.deseneaza_grid(
                                        possible_moves=possible_moves
                                    )
                            print(str(stare_curenta))
        # --------------------------------
        else:  # jucatorul e JMAX (calculatorul)
            # Mutare calculator
            global noduri_calculator, noduri_curente
            noduri_curente = 0
            numar_mutari_pc += 1
            # preiau timpul in milisecunde de dinainte de mutare
            t_inainte = int(round(time.time() * 1000))

            if tip_algoritm == "minimax":
                stare_actualizata = min_max(stare_curenta)
            else:  # tip_algoritm=="alphabeta"
                stare_actualizata = alpha_beta(-500, 500, stare_curenta)
            stare_curenta.tabla_joc = stare_actualizata.stare_aleasa.tabla_joc
            noduri_calculator.append(noduri_curente)
            print("Estimare facuta de calculator scor: ", stare_actualizata.scor)
            print("Numar noduri generate: ", noduri_curente)

            print("Tabla dupa mutarea calculatorului\n" + str(stare_curenta))

            # preiau timpul in milisecunde de dupa mutare
            t_dupa = int(round(time.time() * 1000))
            print(
                'Calculatorul a "gandit" timp de '
                + str(t_dupa - t_inainte)
                + " milisecunde."
            )
            timpi.append(t_dupa)
            timpi_calculator.append(t_dupa-t_inainte)

            stare_curenta.tabla_joc.deseneaza_grid()
            if afis_daca_final(stare_curenta):
                break

            # S-a realizat o mutare. Schimb jucatorul cu cel opus
            stare_curenta.j_curent = Joc.jucator_opus(stare_curenta.j_curent)


if __name__ == "__main__":

    main()
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                afiseaza_statistici()
                pygame.quit()
                sys.exit()
