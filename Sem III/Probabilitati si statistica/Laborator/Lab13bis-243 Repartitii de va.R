#Repartitii de v.a.

#1.d+nume_repartitie=functie de masa(caz discret)/functia de densitate(caz continuu)
#pe prima pozitie avem valoarea sau vectorul de valori in care vrem sa evaluam functia
#pe urmatoarele pozitii avem parametrii repatitiei, in ordine
#dgeom(x,p)
dgeom(5, 0.4)
#probabilitatea ca primul succes sa se realizeze la a 6-a incercare (am 5 esecuri) stiind ca
#probabilitatea de succes este 0.4
plot(0:10, dgeom(0:10, 0.4))
plot(0:10, dgeom(0:10, 0.9))
plot(0:10, dgeom(0:10, 0.05))

#dbinom(x,n,p)
dbinom(3, 5, 0.4)
#probabilitatea ca din 5 incercari independente cu probabilitatea de succes 0.4 sa avem 3 succese
plot(0:5, dbinom(0:5, 5, 0.4), type = "o")
plot(0:5, dbinom(0:5, 5, 0.9), type = "o")
plot(0:5, dbinom(0:5, 5, 0.1), type = "o")
plot(0:100, dbinom(0:100, 100, 0.5), type = "o")
plot(0:100, dbinom(0:100, 100, 0.1), type = "o")
plot(0:30, dbinom(0:30, 30, 0.3), type = "o")

t <- seq(-3, 7, 0.001)
#X~Unif(a,b)
#f(x)=1/(b-a) pt x in intervalul (a,b)
plot(t, dunif(t, 0, 2), col = "red")
abline(v = 0, col = "red")
abline(v = 2, col = "red")
abline(h = 0, col = "red")
abline(v = 1, col = "blue")
abline(v = 2, col = "blue")
abline(v = 3, col = "blue")
abline(v = 0.5, col = "blue")
abline(v = 1.5, col = "blue")

#P(X=3)
#dexp(x,lambda)
dexp(3, 1) #evaluez densitatea de probabilitate a unei v.a. repartizate exponential de parametru in punctul 3
#NU mai e o probabilitate

t <- seq(-4, 8, 0.001)
plot(t, dexp(t, 1), col = "blue")
abline(v = 0)
plot(t, dexp(t, 2), col = "green", type = "l")
plot(t, dexp(t, 0.5), col = "magenta", type = "l")
#f(x) = lambda*exp(-lambda*x),x>0 si 0 in rest
#2. p+nume_repartitie=functia de repartitie
#  pbinom(x,n,p)
#P(X<=x)
pbinom(3, 5, 0.4)
# probabilitatea ca din 5 incercari idependente cu prob de succes
# 0.4 sa reusim de cel mult 3 ori
t <- seq(-1, 6, 0.001)
plot(t, pbinom(t, 5, 0.4), col = "blue")
plot(t, pexp(t, 1), col = "red", type = "l")
lines(t, pexp(t, 2), col = "green", type = "l")
lines(t, pexp(t, 0.5), col = "magenta", type = "l")
#3. r+nume_repartitie=genereaza valori din acel tip de repartitie
#  rbinom(nr,n,p) #nr-numaril de valori pe care vrem sa le geneream
set.seed(15129)
rbinom(3, 5, 0.4)
#Reprezentari grafice de functii
#Functia densitate de probabilitate a repartitiei normale
t <- seq(-6, 6, 0.001)
plot(t, dnorm(t, 0, 1))
plot(t, dexp(t, 2), ylim = c(0, 0.))
#ATENTIE: IN R parametrii normalei sunt media si abaterea medie standard
y <- rnorm(100, 0, 1)
# length(y[y>0])
# length(y[y<0])
poz <- y[y > 0]
prob_nr_poz <- length(poz) / 10 ^ 2
neg <- y[y < 0]
prob_nr_neg <- length(neg) / 10 ^ 2

y <- rnorm(10^6, 0, 1)

length(y[(y > -3) & (y < 3)])
poz <- y[y > 0]
prob_nr_poz <- length(poz) / 10 ^ 6
neg <- y[y < 0]
prob_nr_neg <- length(neg) / 10 ^ 6
prob_nr_neg
prob_nr_poz


lines(t, dnorm(t, 0, 1))
plot(t, dnorm(t, 0, 1), col = "magenta", xlim = c(-8, 8), ylim = c(0, 1), type="l")
lines(t, dnorm(t, 0, 4), col = 2)
lines(t, dnorm(t, 0, 0.5), col = 3)
lines(t, dnorm(t, 0, 2), col = 5)
lines(t, dnorm(t, 0, 0.5), col = 1)

plot(t, dnorm(t, 0, 1), col = "magenta", xlim = c(-8, 8), ylim = c(0, 0.45), type="l")
lines(t, dnorm(t, -2, 1), col = 2)
lines(t, dnorm(t, 2, 1), col = 3)
lines(t, dnorm(t, 3, 1), col = 5)
lines(t, dnorm(t, 5, 1), col = 1)
abline(v=0)
abline(v=-2,col=2)
abline(v=3,col=3)

z <- rnorm(1000, 2, 1)
length(z[z < -2])

plot(t, dnorm(t, 0, 1), col = "magenta", ylim = c(0, 1.8))
for (i in c(0.25, 0.5, 0.3, 0.9, 1.3, 2))
  lines(t, dnorm(t, 0, i), col = i * 20)
