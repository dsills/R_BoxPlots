library(ggplot2)
library(plyr)
library(grid)

#Set working directory
setwd("/Users/Deborah/documents/R_BoxPlots")

#To import data
abc <- read.table('Prod123_May12.csv', header=FALSE, sep=',')
colnames(abc)<- c("Productivity", "Process", "min", "Q1", "median", "Q3", "max")
abc


#order facets
abc$titles <- ordered(abc$Productivity, levels = c("Low Productivity", "Base Productivity", "High Productivity"),
              labels = c("Low Productivity", "Base Productivity", "High Productivity"))

#Draw box plots of NER values for Productivity 4 with error bars
#Use facet_wrap

N <- ggplot(abc)
N + geom_errorbar(aes(x = Process, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`), stat = "identity", width = 0.2) + 
  geom_boxplot(fill="royalblue1", stat = "identity", aes(x = Process, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`, width = 0.35)) + 
  facet_wrap(~ titles, ncol = 1) +
  xlim("Nutrients", "CO2 Compression", "Mixing", "Water Transport", "Reactor Construction") +
  coord_flip() + 
  theme_bw() + 
  labs(x = "\nProcess Technology", y = "\nNonrenewable Energy Demand (MJ/MJ Biofuel Produced)") +
  theme(axis.text.y = element_text(size = 12),axis.text.x = element_text(size = 12),
       axis.title.x = element_text(size=12, vjust = 2), axis.title.y = element_text(size = 14, angle = 90, vjust = 0.3)) +
         theme(strip.text.x = element_text(size = 14)) 
