#lucrul cu pachetul prob
#Aruncarea cu moneda

t3<-tosscoin(3)
str(t3)
t3$toss2
####################
##Extragerea de subvectori dintr-un vector
a<- 1:100
a1 <- a[1:43]
a1 <- c(a[1:43],a[89])
a2 <- a[c(1:43,80)]
a3 <- a[-2]#toti indicii mai putin 2
a4 <- a[a%%2==0]
a5 <- a[(a%%3==0)&!(a%%5==0)]
##############################
t3[1,]
t3[,1]
#Se arunca o moneda de 3 ori si vrem probabilitatea de aparitie de 
#cel putin doua ori a H


#se arunca o moneda o data si vrem prob de aparitie a H
omega1 <- tosscoin(1)

sum(omega1=='H')/nrow(omega1)

## cu 3 aruncari
omega3 <- tosscoin(3)
sum(rowSums(omega3=='H')>=2)/nrow(omega3)


## Calculati probabilitatea de aparitei a secventei T T
## la aruncarea monedei de 3 ori
probTT31 <- (sum((omega3[,1] == 'T') & (omega3[,2] == 'T')) + sum((omega3[,2] == 'T') & (omega3[,3] == 'T')))/ nrow(omega3)

## Calculati probabilitatea de aparitei a secventei T T
## la aruncarea monedei de 5 ori
##tema?

#aruncarea cu zarul
zar2 <- rolldie(2)
zar2$X1

#determinai prob ca la aruncareaa doua zaruri sa se obtina suma 7
sum(rowSums(zar2)==7)/nrow(zar2)
sum(zar2[,1]+zar2[,2]==7)

##alta varianta
t<-table(rowSums(zar2))/nrow(zar2)
str(t)
t[["7"]]

#jocuri de carti
s <- cards()
str(s)

#determinati prob de a extrage o carte cu inima
#?????
length(s[s['suit']=='Hearth'])

(table(s["suit"])/nrow(s))[['Heart']]
# de la prima linie a ajuns la asta
sum(s['suit']=='Heart') /nrow(s)

#to do: operatii cu evenimente(union,intesect,diff)

