setwd("~/git/MSF_NutritionMaps")
library(useful)
require(stringr)
library(rworldmap)
library(RColorBrewer)

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
mapCountryData(mapToPlot = heatmap, mapRegion = "world", nameColumnToPlot = "Admissions", catMethod  = "quantiles", addLegend = FALSE ,oceanCol = "white", lwd = 0.5, colourPalette = c("#efd3d3", "#f47171", "#e22634", "#bb1c29", "#940f1a", "#560404"), numCats = 6 )

#get color palette from RColorBrewer
# brewer.pal(5, "Reds")
# decided to match colors from last year's graph instead of using colorbrewer

#add country names to map
labelCountries(heatmap, nameCountryColumn = "Country", cex = .1 , col= "black")

#add legend boxes
addMapLegendBoxes(cutVector = c("75,000+",
                                "20,000-25,000",
                                "10,000-20,000",
                                "5,000-10,000",
                                "1,000-5,000",
                                "0-1000"
                ),colourVector = c("#efd3d3", "#f47171", "#e22634", "#bb1c29", "#940f1a", "#560404"),
                 cex = 0.2, pt.cex = 1, title="Total Admissions")