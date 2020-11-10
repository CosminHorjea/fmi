#Lucru cu functii in R
f <- function()
{
  #optional return()
}

f1 <- function(x)
{
  2^x
}

f1(3)

#Sa se scrie o functie care afiseaza toate numerele prime mai mici decat un n dat
is_prim <- function(x)
{
  for (i in 2:ceiling(sqrt(x)))
  {
    if (x%%i==0) return(F)
  }
  return(T)
}
for (i in 2:1) print(i)
for (i in c(1,6,9)) print(i)
#ATENTIE: operatorul : genereaza toate numerele intregi cuprinse intre
#cele doua capete, fie ele in ordine crescatoare, fie descrescatoare
10:1
is_prim(101)
f_prim <- function(n)
{
  v <- c()
  for (i in 2:n) if (is_prim(i)==T) {print(i)
                                    v <- c(v,i)}
  return(v)
}

t <- f_prim(101)

#Integrarea unei functii in R
integrate(f1,0,3)
7/log(2)
f2 <- function(x)
{
  2*x
}

a <- integrate(f2,1,2)
a$value

#Integram functia gama
f_gama <- function(x,a)
{
  x^(a-1)*exp(-x)
}

integrate(f_gama,0,Inf, a=4)

#Tema creati o functie in R numita gama_nume care sa implementeze proprietatile
#pe care le are functia gama(vezi documentul Integrale euleriene) si sa 
#foloseasca apelul functiei integrate doar atunci cand parametrul nu satisface 
#nicio conditie "buna"

# gama_nume <- function(....)
#{
#daca n e natural atunci foloseste propr. 3)     #folosim functia din R numita factorial
#daca n e de forma b/2(cu b natural) foloseste formula 2) si 4)
#altfel foloseste formula 2) pana cand argumentul devine subunitar
#si doar pentru acea valoare calculeaza cu integrate

#}
#TEMA:
#Se amesteca 3 seturi de carti de joc si apoi se extrag succesiv 3 carti
#Scrieti o functie care calculeaza probabilitatea ca cele 3 carti extrase
#sa fie identice
#Scrieti o functie care calculeaza probabilitatea ca extragand cate o carte
#din 3 pachete diferite sa obtinem aceeasi carte in cele 3 extrageri
#Comparati rezultatele intoarse de cele 2 functii. Cum justificati diferenta?
#Folositi functia cards()

# Reprezentarea grafica a functiilor
t <- seq(-1,3,0.001)
plot(t,f1(t),col="blue",xlim=c(-1,0),ylim=c(0,1))


