
##############################################################################
# transformacja Boxa-Coxa 	flambda(X)=(X^lambda-1)/lambda  dla lambda=!0
#                        	flambda(X)=ln(X)                dla lambda=0

#Xt=f(t)*St*et     model multiplikatywny 
#log_Xt=log_f(t)+log_st+log_et   model addytywny

library(forecast)
library(datasets)
data(AirPassengers)
AirPassengers.sqrt <-BoxCox(AirPassengers, lambda=0.5) #sqrt(Xt)
AirPassengers.log <-BoxCox(AirPassengers, lambda=0)    #log(Xt)

par(mfrow = c(3,1))
plot(AirPassengers, main="AirPassengers-dane orginalne")
grid()

plot(AirPassengers.sqrt, main="AirPassengers-lambda=0,5")
grid()

plot(AirPassengers.log, main="AirPassengers-lambda=0")
grid()

# Odwrotna transformacja Boxa-Coxa 	

# f'lambda(X)= (X*lambda+1)^(1/lambda) dla lambda=!0
#      f'lambda(X)=exp(X)                dla lambda=0

y <-InvBoxCox(AirPassengers.log, lambda=0)

par(mfrow = c(2,1))
plot(AirPassengers, main="AirPassengers-dane orginalne")
grid()


plot(y, main="AirPassengers-InvBoxCox(BoxCox)")
grid()

############################################################################
# Roznicowanie - differencing

# roznicowanie z opoznieniem 1

library(forecast)
library(datasets)
data(AirPassengers)

tsdisplay(AirPassengers, main="orginalne dane")
AirPassengers.diff <-diff(AirPassengers)
tsdisplay(AirPassengers.diff, main="zróżnicowane dane")
AirPassengers.log.diff <-diff(AirPassengers.log)
tsdisplay(AirPassengers.log.diff, main="zlogarytmowane i zróżnicowane dane")


# roznicowanie 2-krotne
AirPassengers.diff_2 <- diff(AirPassengers.diff)
tsdisplay(AirPassengers.diff_2, main="zróżnicowane dane 2-krotnie")
# roznicowanie 3-krotne
AirPassengers.diff_3 <-diff(AirPassengers.diff_2)
tsdisplay(AirPassengers.diff_3, main="zróżnicowane dane 3-krotnie")


# roznicowanie k-krotne
# AirPassengers.diff_k <-diff(AirPassengers, differences = k)

AirPassengers.diff_3k <-diff(AirPassengers, differences = 3)

par(mfrow = c(2,1))
plot(AirPassengers.diff_3, main="3-krotnie zróżnicowane dane")
plot(AirPassengers.diff_3k, main="3-krotnie zróżnicowane dane")

###############################################################################
# Roznicowanie z opoznieniem sezonowym

# Delta_s_X=X(t)-X(t-s)

# s - lag(4, 12, 24)

AirPassengers.diff12 <-diff(AirPassengers, lag=12)
tsdisplay(AirPassengers.diff12, main="szereg zroznicowany z opoznieniem sezonowym = 12")

AirPassengers.diff12.diff1 <-diff(AirPassengers.diff12)
tsdisplay(AirPassengers.diff12.diff1, main="szereg zroznicowany z opoznieniem sezonowym = 12 i trendem")

AirPassengers.diff.diff12 <-diff(AirPassengers.diff, lag=12)
tsdisplay(AirPassengers.diff.diff12, main="szereg zroznicowany z opoznieniem sezonowym = 12 i trendem")


par(mfrow = c(2,1))
plot(AirPassengers.diff12.diff1, main="szereg zroznicowany z opoznieniem sezonowym = 12 i trendem")
plot(AirPassengers.diff.diff12, main="szereg zroznicowany z opoznieniem =1 i sezonowym = 12 ")

AirPassengers.delta <-diff(AirPassengers, lag=1, differences=1)
tsdisplay(AirPassengers.delta, main="szereg zroznicowany trendem")

AirPassengers.delta.delta12 <-diff(AirPassengers.delta, lag=12, differences=1)
tsdisplay(AirPassengers.delta.delta12, main="szereg zróznicowany z opoznieniem sezonowym = 12 i trendem")

par(mfrow = c(3,1))
plot(AirPassengers.diff12.diff1, main="szereg zroznicowany  z opoznieniem sezonowym = 12 i trendem")
plot(AirPassengers.diff.diff12, main="szereg zroznicowany z opoznieniem =1 i sezonowym = 12 ")
plot(AirPassengers.delta.delta12, main="szereg zroznicowany z opoznieniem =1 i sezonowym = 12 ")


###############################################################################
# Agregacja danych

# funkcja - aggregate() 
# pakiet sats

# aggregate(x, nfrequency = 1, FUN = sum, ...)
# x		 - szereg czasowy
# nfrequency - nowa czstotliwosc danych
# FUN		 - funkcja agregujaca

# agregacja sum? w kwartalach

AirPassengers.Qsum <- aggregate(AirPassengers, nfrequency=4, FUN=sum)
AirPassengers.Qsum


# agregacja wartoscia maksymalna w kwartalach
AirPassengers.Qmax <- aggregate(AirPassengers, nfrequency=4, FUN=max)
AirPassengers.Qmax

par(mfrow = c(3,1))
plot(AirPassengers, main="AirPassengers-dane miesieczne")
plot(AirPassengers.Qsum, main="Agregacja suma w kwartalach")
plot(AirPassengers.Qmax, main="Agregacja wartoscia maksymalna w kwartalach")

# agregacja srednia w latach

AirPassengers.Ymean <-aggregate(AirPassengers, nfrequency=1, FUN=mean)
AirPassengers.Ymean


par(mfrow = c(4,1))
plot(AirPassengers, main="AirPassengers-dane miesieczne")
plot(AirPassengers.Qsum, main="Agregacja suma w kwartalach")
plot(AirPassengers.Qmax, main="Agregacja wartoscia maksymalna w kwartalach")
plot(AirPassengers.Ymean, main="Agregacja wartoscia srednia w latach")


###########################################################################################

# Zadanie 1
# Dla wybranych danych wykonaj odpowiednie transormacje
# aby przeksztalcic je do postaci stacjonarnej - bialy szum

# Zadanie 2
# Porownaj na wykresie wybrane dane przed i po agregacji (dowolnej)
# Jakie wlasnosci szeregow obserwujesz przed i po agregacji?

