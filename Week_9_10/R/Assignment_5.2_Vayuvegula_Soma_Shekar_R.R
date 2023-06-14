#Import required libraries
library(ggplot2)
library(dplyr)
library(gapminder)
library(readxl)
library(tidyverse)
library(reshape2)
library(dplyr)
library(plyr)
library(mapview)

  
## Set the working directory to the root of your DSC 520 directory
setwd("/Users/somashekarvayuvegula/Documents/Workspace/Data_Presentation_Visualization/Week_9_10/R/")

#Read CSV files
df_ppg <- read.csv("ppg2008.csv")
head(df_ppg,5)

df_costco <- read.csv("costcos-geocoded.csv")
head(df_costco,5)

#Heat Map
library(scales)
df_melt<-melt(df_ppg)
df_melt<-ddply(df_melt, .(variable),transform,rescale=rescale(value))
base_size<-9

ggp <- ggplot(df_melt, aes(variable,Name))+geom_tile(aes(fill=rescale),color='white')+scale_fill_gradient(low="white",high = "steelblue")+ theme_grey(base_size = base_size) + labs(x = "", y = "") + scale_x_discrete(expand = c(0, 0)) +
  scale_y_discrete(expand = c(0, 0)) + 
  theme(axis.text.x=element_text(angle=90, hjust=0, vjust= 0.1)) +
  theme(axis.text.y=element_text(hjust=0, vjust= 0.1)) +
  ggtitle("2008 Basketball Player Statistics") +
  xlab("Statistics") + 
  ylab("Basketball Player")
ggp  

#Spatial chart
mapview(df_costco, xcol = "Longitude", ycol = "Latitude",cex = 3,crs = 4269, grid = FALSE)


#Contour chart
ggplot(df_costco, aes(x = Longitude, y = Latitude, fill = ..level..)) +
  stat_density_2d(geom = "polygon") + ggtitle("Costcos - Contour Chart")
