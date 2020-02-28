# Se consideră o bucată de tablă de formă dreptunghiulară avand coltul stanga-jos in punctul (0,0)
# si coltul dreapta-sus in punctul (xdr, ydr). Placa are pe suprafaţa ei n găuri avand coordonate numere întregi.
# Se cere să se decupeze din ea o bucată de arie maximă fără găuri.
# Sunt permise numai tăieturi orizontale şi verticale.

def citireDate():
    f = open("dreptunghi.txt")

    aux = f.readline().split()
    xdr = int(aux[0])
    ydr = int(aux[1])

    coordonateGauri = []
    for linie in f:
        aux = linie.split()
        coordonateGauri += [(int(aux[0]), int(aux[1]))]

    f.close()

    return xdr, ydr, coordonateGauri


def dreptunghiArieMaxima(xst, yst, xdr, ydr):
    global arieMaxima, coordonateGauri, dMaxim

    for g in coordonateGauri:
        if xst < g[0] < xdr and yst < g[1] < ydr:
            dreptunghiArieMaxima(xst, yst, g[0], ydr)
            dreptunghiArieMaxima(g[0], yst, xdr, ydr)
            dreptunghiArieMaxima(xst, yst, xdr, g[1])
            dreptunghiArieMaxima(xst, g[1], xdr, ydr)
            break
    else:
        if (xdr-xst)*(ydr-yst) > arieMaxima:
            arieMaxima = (xdr-xst)*(ydr-yst)
            dMaxim = (xst, yst, xdr, ydr)


xdr, ydr, coordonateGauri = citireDate()
arieMaxima = 0
dMaxim = (0, 0, 0, 0)
dreptunghiArieMaxima(0, 0, xdr, ydr)
print(arieMaxima)
print(dMaxim)