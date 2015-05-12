setwd("~/Desktop/MCBS/data")
library(ggplot2) 
library(plyr)
library(reshape2)
library(gridExtra)

#-------------------- Read 4_mer files--------------------
path <- "."
filenames <- list.files(path, pattern="*.fasta.4_mer", all.files=TRUE)
ref <- read.table("ref/01-EscherichiaColiStrK-12SubstrMG1655.fasta.4_mer")
data <- lapply(filenames, read.table)

#-------------------- normalize data--------------------
len <- length(data)
#for(i in 1:len){
#        x = data[[i]]$V2;
#        data[[i]]$V2 = prop.table(x)*100
#}

#-------------------- combine data--------------------
#ref <- data[[12]];
#names <- sub(".fasta-4mer.sort", "", filenames)
#names <- sub("-4mer.sort", "", names)
for(i in 1:(len)){
        data[[i]] <- merge(data[[i]], ref, by="V1")
        names(data[[i]])[1] <- "Sequence"
        names(data[[i]])[2] <- "Reads"
        names(data[[i]])[3] <- "Reference"
        data[[i]]$Sequence <- factor(data[[i]]$Sequence, 
                                     levels=data[[i]][order(-data[[i]]$Reference), "Sequence"])
}        


#-------------------- plot  --------------------
len <- len+1
#pdf("mygraph.pdf") 
x <- as.list(rnorm(len-1))
names(x) <- paste("a", 1:(len-1), sep = "") 
for(i in 1:(len-1)){
        x[[i]] <- ggplot(data[[i]], aes(x=Sequence, y=value, color=variable)) +
                geom_bar(aes(y=Reference, col="Reference"), stat="identity") +
                geom_bar(aes(y=Reads, col="Reads"), stat="identity", alpha = 1/10) + 
                scale_y_continuous(limits = c(0,3)) 
        
        
        name <- paste("Read", i, sep="") 
        x[[i]] <- x[[i]] + ggtitle(name)

       # x[[i]]<- ggplot(data=melt(data[[i]], id="Sequence"),
       #                 aes(x=Sequence, y=value, colour=variable)) +
       #                 geom_bar(stat="identity")
}

grid.arrange(x[[1]], x[[2]], x[[3]], x[[4]], x[[5]], x[[6]], x[[7]], x[[8]],
             x[[9]], x[[10]], x[[11]], nrow=4, ncol=3)

grid.arrange(x[[1]], x[[2]], x[[3]], x[[4]], nrow = 2, ncol = 2)
grid.arrange(x[[5]], x[[6]], x[[7]], x[[8]], nrow = 2, ncol = 2)
grid.arrange(x[[9]], x[[10]], x[[11]], nrow = 2, ncol = 2)




