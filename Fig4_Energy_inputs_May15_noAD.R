library(ggplot2)
library(plyr)
library(grid)

#My code
setwd("/Users/Deborah/documents/R_BoxPlots")


#To import data
dry <- read.table('dry_ext_a.csv', header=FALSE, sep=',')
colnames(dry)<- c("Process", "min", "Q1", "median", "Q3", "max")
dry

wet <- read.table('wet_ext_a.csv', header=FALSE, sep=',')
colnames(wet)<- c("Process", "min", "Q1", "median", "Q3", "max")
wet

#Draw box plots with error bars

N <- ggplot(dry, aes(x = Process, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`))
N <- N + geom_errorbar(stat = "identity", width = 0.2) + 
    geom_boxplot(fill="#CC0000", stat = "identity", aes(width = 0.35)) + 
  xlim("Transesterefication", "Hexane Extraction", "Thermal Drying", "Centrifugation", "Cultivation") +
  ylim(0, 2.25) + coord_flip() + 
  theme_bw() +
  labs(x = "", y = "") +
  theme(axis.text.x = element_text(size= 12), axis.text.y = element_text(size=12), 
  axis.title.x = NULL, axis.title.y = NULL, legend.position = "none")

# For wet extraction
W <- ggplot(wet, aes(x = Process, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`))
W <- W + geom_errorbar(stat = "identity", width = 0.2) + 
  geom_boxplot(fill= "#CC0000", stat = "identity", aes(width = 0.35)) + 
  xlim("Hydrotreating", "Hydrothermal Liquefaction", "Belt Filter Press", "Cultivation") +
  ylim(0, 2.25) + coord_flip() + 
  theme_bw() +
  labs(x = "", y = "\nNon-renewable Energy Input (MJ per MJ of Biofuel Produced)") +
  theme(axis.text.x = element_text(size=12), axis.text.y = element_text(size=12), 
       axis.title.x = element_text(size=12, vjust= 1.4), axis.title.y = NULL, legend.position = "none")

pushViewport(viewport(layout = grid.layout(60, 102, just = "right")))
vplayout <- function(x, y)
  viewport(layout.pos.row = x, layout.pos.col = y)
print(N, vp = vplayout(1:32, 8:102))
print(W, vp = vplayout(31:60, 1:102))