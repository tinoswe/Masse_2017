df <- read.table("Data/CSV/1686_MOB.csv", 
                 header = FALSE,
                 row.names = NULL,
                 sep=";",
                 stringsAsFactors = FALSE)

colnames(df) <- c("p1")#,"p2","p3")
df$p1 <- gsub(",", ".", df$p1)
#df$p2 <- gsub(",", ".", df$p2)
#df$p3 <- gsub(",", ".", df$p3)
df$p1 <- sapply(df$p1, as.numeric)
#df$p2 <- sapply(df$p2, as.numeric)
#df$p3 <- sapply(df$p3, as.numeric)

df$avg <- df$p1 #rowMeans(df)
df$avg

hist(df$avg,
     breaks=round(sqrt(length(df$avg))),
     main="1686_MOB",
     xlim=c(10000-100,10000+100),
     xlab="",
     ylab="",
     axes=F)
axis(1,
     pos=0)
axis(2,
     pos=0)
abline(v=10000-50,
       col="red")
abline(v=10000+50,
       col="red")
legend("topleft", 
       legend=c("0.5% limit"),
       col=c("red"), 
       lty=1, 
       cex=0.8,
       bty="n")