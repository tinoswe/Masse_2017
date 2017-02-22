df <- read.table("Data/CSV/1685_MOB.csv", 
                 header = FALSE,
                 row.names = NULL,
                 sep=";",
                 stringsAsFactors = FALSE)
colnames(df) <- c("id","p1","p2","p3")

df$p1 <- gsub(",", ".", df$p1)
df$p2 <- gsub(",", ".", df$p2)
df$p3 <- gsub(",", ".", df$p3)

df$p1 <- 1e-3*sapply(df$p1, as.numeric)
df$p2 <- 1e-3*sapply(df$p2, as.numeric)
df$p3 <- 1e-3*sapply(df$p3, as.numeric)

df$id <- c()
df$avg <- rowMeans(df)
df$typeA <- apply(df[, c("p1","p2","p3")],
            1,
            sd)
df$typeB <- 1e-3*0.22/2 #0.22 g fino a 6 kg
df$u_c <- sqrt(df$typeA^2 + df$typeB^2)
df$Uk2 <- 2*df$u_c

#extract 100 random combinations of masses and comp unc.
#install.packages("dplyr")
library(dplyr)
N <- 10 #number of loaded masses
W_nom <- N*5
W_nom_up <- W_nom + 0.5*W_nom/100.
W_nom_down <- W_nom - 0.5*W_nom/100.

N_exp <- 1000
#create empty plot with axes
plot(0,
     xaxt='n',
     yaxt='n',
     bty='n',
     pch='',
     ylab='',
     xlab='',
     xlim=c(1,N_exp+1),
     ylim=c(W_nom - .7*W_nom/100., 
            W_nom + .7*W_nom/100.),
     main = paste("N exp = ",N_exp,sep=" "))
axis(1,
     at=seq(1,N_exp+1),
     labels="")
axis(2,
     at=seq(W_nom - 2*(W_nom_up - W_nom),
            W_nom + 2*(W_nom_up - W_nom),
            by=0.1))
abline(h=W_nom,
       col="darkgreen",
       lty=1)
abline(h=W_nom_up,
       col="darkred",
       lty=2)
abline(h=W_nom_down,
       col="darkred",
       lty=2)

sim_cnt <- 1

for (i in 1:N_exp){
  df_sim <- sample_n(df,
                    N)
  W_real <- sum(df_sim$avg)
  W_real_inc <- sum(df_sim$Uk2)

  points(sim_cnt,
         W_real,
         col="red",
         pch=26)

  arrows(sim_cnt, 
         W_real - W_real_inc, 
         sim_cnt, 
         W_real + W_real_inc, 
         length=0.05, 
         angle=90, 
         code=3)

  sim_cnt <- sim_cnt + 1
}

df_sim