df <- read.table("Data/CSV/1685_MOB.csv", 
                 header = FALSE,
                 row.names = NULL,
                 sep=";",
                 stringsAsFactors = FALSE)
colnames(df) <- c("id","p1","p2","p3")

df$p1 <- gsub(",", ".", df$p1)
df$p2 <- gsub(",", ".", df$p2)
df$p3 <- gsub(",", ".", df$p3)

df$p1 <- sapply(df$p1, as.numeric)
df$p2 <- sapply(df$p2, as.numeric)
df$p3 <- sapply(df$p3, as.numeric)

df$id <- c()
df$avg <- rowMeans(df)
df$typeA <- apply(df[, c("p1","p2","p3")],
            1,
            sd)
df$typeB <- 0.22/2 #0.22 g fino a 6 kg
df$u_c <- sqrt(df$typeA^2 + df$typeB^2)
df$Uk2 <- 2*df$u_c

