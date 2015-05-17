setwd("~/git/MSF_NutritionMaps")
library(useful)
require(stringr)
library(rworldmap)
library(RColorBrewer)
library(ggplot2)
library(ggmap)
library(raster)
?RColorBrewer
#read in data files
nutrition <- read.table("2014admissions.csv", sep=",", header = TRUE, stringsAsFactors = FALSE, na.strings=c("NA", "NULL"))
codes <- read.table("CountryCodes.csv", sep=",", header = TRUE, stringsAsFactors = FALSE)

head(nutrition)
head(codes)
#merge tables for country code
mapdata <- merge (x=nutrition, y=codes,
                   by.x=c("Country"),
                   by.y=c("Country"),
                   all.x=TRUE)
head(mapdata)
#map heatmap
#overview map
heatmap <- joinCountryData2Map (mapdata, joinCode = "ISO3", nameJoinColumn = "CountryCode")
mapCountryData(mapToPlot = heatmap, mapRegion = "world", nameColumnToPlot = "Admissions", catMethod  = "pretty", addLegend = FALSE ,oceanCol = "white", lwd = 0.5, colourPalette = c("#FEE5D9", "#FCAE91", "#FB6A4A", "#DE2D26", "#A50F15"), numCats = 5 )

#get color palette from RColorBrewer
brewer.pal(5, "Reds")

#add country names to map
labelCountries(heatmap, nameCountryColumn = "Country", cex = .3 , col= "black")

#add legend boxes
addMapLegendBoxes(cutVector = c("75,000+",
                                "20,000-25,000",
                                "10,000-20,000",
                                "5,000-10,000",
                                "1,000-5,000",
                                "0-1000"
                ),colourVector = c("#FEE5D9", "#FCAE91", "#FB6A4A", "#DE2D26", "#A50F15"),
                 cex = 0.5, pt.cex = 1, title="Total Admissions")