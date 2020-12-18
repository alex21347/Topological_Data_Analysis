install.packages("spatstat")
library(spatstat)

#Poisson Point Process
win <- owin(c(0,20),c(0,10))
intens <- 2
ppp <- rpoispp(intens,win = win)
plot(ppp)
plot(Kest(ppp))

#Case study : Swedish pines
data(swedishpines)
plot(swedishpines)
pcf_sp <- pcf(swedishpines)
plot(pcf_sp)
plot(Kest(swedishpines))

#Strauss Point Process
StraussPPP <- rStrauss(intens, gamma = 0, R = 0.5, W = win)
plot(StraussPPP)
pcf_strauss <- pcf(StraussPPP)
plot(pcf_strauss)
plot(Kest(StraussPPP))