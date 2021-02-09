#Statistica descriptiva
data()

y <- Departament_facultate$y
minim <- min(y)
maxim <- max(y)
# range(y)
media <- mean(y)
dispersia <- var(y)
deviatia_standard <-sd(y)
mediana <- median(y)
q1 <- quantile(y,1/4)
q3 <- quantile(y,3/4)

# quantile(y,13/43)

summary(y)

#Vizualizam datele cu o histograma
hist(y,col="darkblue")

#Vizualizam datele cu diagrama boxplot

boxplot(y,col="pink")
abline(h=mediana,col="red")
abline(h=q1,col="red")
abline(h=q3,col="red")
abline(h=minim,col="red")
abline(h=maxim,col="red")

y1 <- c(y,40,4)
boxplot(y1,col="magenta")
g <- Departament_facultate$g
boxplot(y~g,col="lightblue")
#aici nu am outlier
boxplot(y,col="lightblue")
#aici am outlier, dar numai la nivelul subpopulatiei de fete
g1 <- sample(c(0,1,3),37,replace=T)
boxplot(y~g1,col="lightblue")

