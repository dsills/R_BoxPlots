library(ggplot2)
library(plyr)
library(grid)

#Set working directory
setwd("/Users/Deborah/documents/R_BoxPlots")
     
# do it for wet and dry extractions only
#To import data
abc <- read.table('NER12_Mar_29.csv', header=FALSE, sep=',')
colnames(abc)<- c("Productivity", "Process", "min", "Q1", "median", "Q3", "max")
abc

#order facet
abc$titles <- ordered(abc$Productivity, levels = c("Low Productivity", "Base Productivity", "High Productivity"),
              labels = c("Low Productivity", "Base Productivity", "High Productivity"))

#Draw box plots of NER values for low, base, and high productiviteis 
#Use facet_wrap

N <- ggplot(abc)
N + geom_errorbar(aes(x = Process, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`), stat = "identity", width = 0.2) + 
  geom_boxplot(fill="royalblue1", stat = "identity", aes(x = Process, ymin = `min`, lower = `Q1`, middle = `median`, upper = `Q3`, ymax = `max`, width = 0.35)) + 
  geom_hline(yintercept = 1, color = "#CC0000", size = 0.8) +
  facet_wrap(~ titles, ncol = 1) +
  xlim("Wet Extraction", "Dry Extraction") +
  coord_flip() + 
  theme_bw() + 
  labs(x = "\nProcess Technology", y = "\nEROI (MJ Output per MJ Nonrenewable Energy Input)") +
  theme(axis.text.y = element_text(size = 10),axis.text.x = element_text(size = 10),
       axis.title.x = element_text(size=10, vjust = 2), axis.title.y = element_text(size = 10, angle = 90, vjust = 0.3)) +
         theme(strip.text.x = element_text(size = 10)) +
         theme(axis.ticks.length = unit(.2, "cm"), plot.margin = unit(c(1, 1, 2, 2), "lines"))


