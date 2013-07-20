library(ggplot2)
library(plyr)
library(grid)

#Set working directory
setwd("/Users/Deborah/documents/R_BoxPlots")

#To import data
abc <- read.table('Lit_NER_June2012.csv', header=FALSE, sep=',')
colnames(abc)<- c("Author","EROI")
abc

# Input Cornell Values
cornell <- read.table('cornell_worst_best.csv', header=FALSE, sep=',')
colnames(cornell)<- c("Author", "min", "Q1", "median", "Q3", "max")
cornell

#######Draw lit values

a <- ggplot() 
a <- a + geom_point( data = abc, aes(x= Author, y = EROI),shape = 22, fill = "black", size = 3)+
  xlim("Vasudevan et al. (2012)","Stephenson et al. (2010)", "Shirvani et al. (2011)", "Sawayama et al. (1999)", "Sander & Murthy (2010)", 
       "Razon & Tan (2011)", "Lardon et al. (2009)", "Khoo et al. (2011)", "Jorquera et al. (2010)", "Frank et al. (2011)", "Clarens et al. (2011)", 
       "Chowdhury et al. (2012)", "Campbell et al. (2011)", "Brentner et al. (2011)", "Batan et al. (2010)") +
  ylim(c(0, 4.3)) +
  geom_hline(yintercept = 1, color = "red") +
  coord_flip() + labs(x = "", y = "EROI (MJ Output per MJ Nonrenewable Energy Input)") +
  theme(axis.ticks= element_blank(), axis.text.x = NULL,  axis.text.y = element_text(size=12, color = 'black'),
  axis.title.x = NULL, axis.title.y = NULL, legend.position = "none")

#Create boxplots for Cornell data
b <- ggplot()
b <- b + geom_errorbar(data = cornell, aes( x = Author, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`), 
                stat = "identity", width = 0.25)+
    geom_boxplot(data = cornell, aes (x = Author, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`, width = 0.45), 
    stat = "identity", fill = "royalblue1") + 
    xlim( "Best Case", "Worst Case") + 
    ylim(c(0, 4.3)) +
    geom_hline(yintercept = 1, color = "red") +
    coord_flip() + labs(x = "", y = "EROI (MJ Biofuel Produced/MJ Energy Input)") +
    theme_bw() + theme(axis.text.x = element_text(size=12), axis.text.y = element_text(size=12), 
    axis.title.x = element_text(size=12, vjust=0.3),axis.title.y = NULL, legend.position = "none") +
    theme(axis.ticks = element_blank(), panel.grid.major = element_line(colour = "dark gray", size = 0.3))
#save plot as eps
# ggsave(file = "NERlitb.eps", width = 9, height = 6)

# ggsave(file = "NER_litB.png", dpi = 600, width = 9, height = 6)

#####
#pdf("polishing-layout1.pdf", width = 8, height = 6)
#grid.newpage()
pushViewport(viewport(layout = grid.layout(15, 8, just = "right")))
vplayout <- function(x, y)
  viewport(layout.pos.row = x, layout.pos.col = y)
print(a, vp = vplayout(1:12, 1:8))
print(b, vp = vplayout(12:15, 1:8))
#dev.off()

######
