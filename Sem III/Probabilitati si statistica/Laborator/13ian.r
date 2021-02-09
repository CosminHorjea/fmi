data()
quakes
?quakes
install.packages("readxl")
library(readxl)

dept <- read_excel("C://Users//horje//OneDrive//Desktop//R playground//lab 13 ian//Departament facultate.xlsx")
View(dept);
y <- dept$y
minim <- min(y)
maxim <- max(y)
# range(y)
media<- mean(y)
dispersia <- var(y)
deviatia_standard <- sd(y)
mediana <- median(y)

q1<- quantile(y,1/4)
q3<- quantile(y,3/4)
# QUANTILE(y,13/43) imi imparte setul de date in 43 de intervale si imi ia partea care imi da al 13-lea interval

summary(y)
#vizualizare date cu histograma
hist(y,col="blue")

#vizualizare deate cu diagrama boxplot
boxplot(y,col="pink")
abline(h=mediana,col="red")
abline(h=q1,col="red")
abline(h=q3,col="red")
abline(h=minim,col="red")
abline(h=maxim,col="red")

y1 <- c(y,40)

boxplot(y1)

g<- dept$g

boxplot(y~g) # g trebuie sa fie o var categoriala(im cazul asta are aceeasi lungime cu y si pentru fiecare element este 0 - baiat sau 1 - fata)

g1<- sample(c(0,1),37,replace=T)
boxplot(y~g1,col="lightblue")

g1<- sample(c(0,1,2),100,replace=T)
hist(g1)

