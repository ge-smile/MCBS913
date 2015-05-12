setwd("~/Desktop/MCBS/data")
library(ggplot2) 
library(plyr)
library(gridExtra)

#-------------------- Read 4_mer files--------------------
path <- "."
filenames <- list.files(path, pattern="*-4mer.sort", all.files=TRUE)
data <- lapply(filenames, read.table)

#-------------------- normalize data--------------------
len <- length(data)
for(i in 1:len){
        x = data[[i]]$V2;
        data[[i]]$V2 = prop.table(x)*100
}

#-------------------- combine data--------------------
files <- data[[1]];
names <- sub(".fasta-4mer.sort", "", filenames)
names <- sub("-4mer.sort", "", names)
names[1] = paste("V", names[1], "_4mer", sep="") 
for(i in 2:len){
        files <- merge(files, data[[i]], by="V1")
        names[i] = paste("V", names[i], "_4mer", sep="")
}
colnames(files)<- c("Sequence", names)

# from here need to specify the name
#-------------------- reorder file --------------------
files$Sequence <- factor(files$Sequence, levels=files[order(-files$VEscherichiaColiStrK_4mer), "Sequence"])

#-------------------- plot  --------------------
#pdf("mygraph.pdf") 
a <- ggplot(files, aes(x=Sequence, y=VEscherichiaColiStrK_4mer)) + 
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4)) 

b <- ggplot(files, aes(x=Sequence, y=V1_4mer))+        
        geom_bar(stat="identity") +  coord_cartesian(ylim = c(0, 4))

c <- ggplot(files, aes(x=Sequence, y=V2_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

d <- ggplot(files, aes(x=Sequence, y=V3_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

e <- ggplot(files, aes(x=Sequence, y=V4_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

f <- ggplot(files, aes(x=Sequence, y=V5_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

g <- ggplot(files, aes(x=Sequence, y=V6_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

h <- ggplot(files, aes(x=Sequence, y=V7_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

i <- ggplot(files, aes(x=Sequence, y=V8_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

j <- ggplot(files, aes(x=Sequence, y=V9_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

k <- ggplot(files, aes(x=Sequence, y=V10_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

l <- ggplot(files, aes(x=Sequence, y=V11_4mer))+        
        geom_bar(stat="identity") + coord_cartesian(ylim = c(0, 4))

grid.arrange(a, b, c, d, e, f, g, h, i, j, k, l, ncol=4, nrow=3)


ggplot(files, aes(x=Sequence)) + 
        geom_line(aes(y=VEscherichiaColiStrK_4mer), colour = "gray") + 
        geom_line(aes(y=V1_4mer), colour = "blue")

multiplot(a, b, cols=2)
#-------------------- Maybe used in future --------------------
# color vector
# plot_colors <- c("orangered", "chocolate1", "gold1", "chartreuse3", 
#            "blue", "blueviolet")
      

#colors <- rainbow(len)
#linetype <- c(1:len)
#plotchar <- seq(18 , 18+len, 1)

#plot(files$Sequence, files$acido_4mer, type = "n")

# add lines
#for(i in 2:len){
#        lines(data[[i]]$Sequence, data[[i]]$V2, type = "l", lwd = 1.5,
#              lty=linetype[i], col=colors[i], pch=plotchar[i])
#}

# add title
#title("4-mer Spectrum for Our Six Genomes")
# add a legend
#legend("topleft", filenames, cex = 0.8, col=colors, lty=linetype)

#dev.off()

