mtcars3 <-mtcars2 <-data.frame(car=rownames(mtcars), mtcars, row.names=NULL)
#mtcars3$cyl  <-mtcars2$cyl <-as.factor(mtcars2$cyl)
head(mtcars2)

library(ggplot2)
library(gridExtra)
x <-ggplot(mtcars3, aes(y=car, x=mpg)) + 
        geom_point(stat="identity")

y <-ggplot(mtcars3, aes(x=car, y=mpg)) + 
        geom_bar(stat="identity") + 
        coord_flip()

grid.arrange(x, y, ncol=2)

## Relevel the cars by mpg
mtcars3$car <-factor(mtcars2$car, levels=mtcars2[order(mtcars$mpg), "car"])

x <-ggplot(mtcars3, aes(y=car, x=mpg)) + 
        geom_point(stat="identity")

y <-ggplot(mtcars3, aes(x=car, y=mpg)) + 
        geom_bar(stat="identity") + 
        coord_flip()

grid.arrange(x, y, ncol=2)