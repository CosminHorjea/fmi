x <- 7 #de preferat asa (alt + -)
y = 6
#alt+enter pt rulare 

print(x) #sau daca selectam x si rulam il printeaza

a <- c(0,pi,2*pi) #concatenare

#indexarea vectorilor se face de la 1

b <- -3:15 #tipul este int deoarece pasul de incrementare e 1 si se incepe de la -3
           #deci se face o optimizare
c <- -3.05:15.2 

d <- seq(4,7,0.001) #sequence 

plot(d,log(d), col="blue") #(x, f(X))

#incercam discretizarea intervalului pt a face un grafic
#ref: ca diviziunile de la Riemann

f <- a+c[1:3]

aa <- c(1,3,5)
bb <- c(4,5,6,7)
g <- aa+bb


cc <- c(4,5,6,7,8,9)
h <- aa+cc

#vectorul cu lungime mai mica se repeta la adunare
#daca dim celui mic nu e divizor al dim celui mare avem warning

