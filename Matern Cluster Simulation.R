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

sims <- sapply(rpoispp(50, nsim = 100), npoints) #number of points in unit sqaure of homogeneous ppp over 100 sims
#sapply just finds the number of points in each sim and then restructures the data into a vector


#Matern-cluster process

kappa = 20
scale = 0.1
mu = 5

matclust <- rMatClust(kappa, scale, mu, win = owin(c(0,1),c(0,1)))
plot(matclust)

#Matern-cluster Type II

kappa1 =  100
r = 0.05

MatII <- rMaternII(kappa1, r, win = owin(c(0,1),c(0,1)))
plot(MatII)

#ppp with intenstiy 100
intens <- 100
ppp <- rpoispp(intens,win = owin(c(0,1),c(0,1)))
plot(ppp)

#dont forget pcf and Kest for comparison, and also mean/var/index of disp.


#index of dispersion for ppp
sims_ppp <- sapply(rpoispp(100, nsim = 100000, win = owin(c(0,1),c(0,1))), npoints)
index_disp_ppp <- var(sims_ppp)/mean(sims_ppp)
#1.004889

#index of dispersion for matern I

kappa = 20   #IM parameter for underlying parent ppp
scale = 0.1  #radius of disk around each parent point
mu = 5  #IM parameter for child ppp

sims_mat1 <- sapply(rMatClust(kappa, scale, mu, win = owin(c(0,1),c(0,1)), nsim=10000), npoints)
index_disp_mat1 <- var(sims_mat1)/mean(sims_mat1)
#5.383


#index of dispersion for matern II

kappa1 =  100
r = 0.05

sims_mat2 <- sapply(rMaternII(kappa1, r, win = owin(c(0,1),c(0,1)), nsim=10000), npoints)
index_disp_mat2 <- var(sims_mat2)/mean(sims_mat2)
#0.519?


############

#disclaimer: the static vars may not be optimal

its <- 50

kappas <- c(seq(1, 200,199/its))

indexes_ppp <- c(replicate(its,0))

for(i in 1:its) {
  sims_ppp <- sapply(rpoispp(kappas[i], nsim = 1000, win = owin(c(0,1),c(0,1))), npoints)
  index_disp_ppp <- var(sims_ppp)/mean(sims_ppp)
  indexes_ppp[i] <- index_disp_ppp
}

plot(indexes_ppp)
mean(indexes_ppp)

#############

#Matern Clustering 1 - varying kappa

its <- 30

kappas <- c(seq(1, 100,100/its))

indexes_mat1<- c(replicate(its,0))

for(i in 1:its){
  sims_mat1 <- sapply(rMatClust(kappas[i], 0.1, 10, win = owin(c(0,1),c(0,1)), nsim=500), npoints)
  index_disp_mat1 <- var(sims_mat1)/mean(sims_mat1)
  indexes_mat1[i] <- index_disp_mat1
}

plot(kappas, indexes_mat1)
mean(indexes_mat1)

model <- lm(indexes_mat1 ~ kappas)
summary(model)

#Matern Clustering 1 - varying scale

its <- 50

scales <- c(seq(0.01, 1, 1/its))
mus <- c(seq(0.1, 50, 50/its))

indexes_mat1<- c(replicate(its,0))

for(i in 1:its){
  sims_mat1 <- sapply(rMatClust(100, scales[i], 10, win = owin(c(0,1),c(0,1)), nsim=100), npoints)
  index_disp_mat1 <- var(sims_mat1)/mean(sims_mat1)
  indexes_mat1[i] <- index_disp_mat1
}

plot(scales, indexes_mat1)
mean(indexes_mat1)

model <- lm(indexes_mat1 ~ scales)
summary(model)

plot(scales, indexes_mat1)
abline(model, col = "red")

#Matern Clustering 1 - varying mus

its <- 50

mus <- c(seq(1, 50, 50/its))

indexes_mat1<- c(replicate(its,0))

for(i in 1:its){
  sims_mat1 <- sapply(rMatClust(100, 0.2, mus[i], win = owin(c(0,1),c(0,1)), nsim=100), npoints)
  index_disp_mat1 <- var(sims_mat1)/mean(sims_mat1)
  indexes_mat1[i] <- index_disp_mat1
}

plot(mus, indexes_mat1)
mean(indexes_mat1)

model <- lm(indexes_mat1 ~ mus)
summary(model)

plot(mus, indexes_mat1)
abline(model, col = "red")

#############

#Matern Clustering 2 - varying kappa

its <- 30

kappa1s <- c(seq(1, 100,100/its))

indexes_mat2<- c(replicate(its,0))

for(i in 1:its){
  sims_mat2 <- sapply(rMaternII(kappa1s[i], r, win = owin(c(0,1),c(0,1)), nsim=500), npoints)
  index_disp_mat2 <- var(sims_mat2)/mean(sims_mat2)
  indexes_mat2[i] <- index_disp_mat2
}

plot(kappa1s, indexes_mat2)
mean(indexes_mat2)

model <- lm(indexes_mat2 ~ kappa1s)
summary(model)

plot(kappa1s, indexes_mat2)
abline(model, col = "red")

#Matern Clustering 2 - varying r

its <- 30

rs <- c(seq(0.01, 1, 1/its))

indexes_mat2<- c(replicate(its,0))

for(i in 1:its){
  sims_mat2 <- sapply(rMaternII(10, rs[i], win = owin(c(0,1),c(0,1)), nsim=500), npoints)
  index_disp_mat2 <- var(sims_mat2)/mean(sims_mat2)
  indexes_mat2[i] <- index_disp_mat2
}

plot(rs, indexes_mat2)
mean(indexes_mat2)

rs2 <- rs^2 

model <- lm(indexes_mat2[1:10] ~ rs[1:10] + rs2[1:10])
summary(model)

preds <- c(seq(0.01, 0.4, 0.4/10))
preds2 <- preds^2

predictions <- predict(model, list(rs = preds, rs2 = preds2))


model1 <- lm(indexes_mat2[10:its] ~ rs[10:its])
summary(model1)



plot(rs, indexes_mat2)
lines(preds, predictions, col = 'red')
abline(model1, col = "blue")

