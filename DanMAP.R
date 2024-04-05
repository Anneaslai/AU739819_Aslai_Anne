#Instaleringer af pakker: 
install.packages("leaflet")
install.packages("htmlwidget")

# Aktivering af libraries
library(leaflet)
library(htmlwidgets)


# Task 1: Create a Danish equivalent of AUSmap with esri layers, 
# but call it DANmap

#Jeg sætter kordinaterne for Danmark ind, som jeg har fundet i Googlemaps. Herefter bestemmer jeg kortets zoom.
leaflet() %>% 
  setView(9.9043941, 56.2020009, zoom = 7) %>%
  addTiles()

#Basekort
l_dan <- leaflet() %>%   # assign the base location to an object
  setView(9.9043941, 56.2020009, zoom = 7)

#Forberedelse til at kunne vælge baggrunde til kortet
esri <- grep("^Esri", providers, value = TRUE)

# Udvælgelse af baggrunde fra esri
for (provider in esri) {
  l_dan <- l_dan %>% addProviderTiles(provider, group = provider)
}

### KORT OVER DANMARK - Kortet hedder DanMAP
DanMAP <- l_dan %>%
  addLayersControl(baseGroups = names(esri),
                   options = layersControlOptions(collapsed = FALSE)) %>%
  addMiniMap(tiles = esri[[1]], toggleDisplay = TRUE,
             position = "bottomright") %>%
  addMeasure(
    position = "bottomleft",
    primaryLengthUnit = "meters",
    primaryAreaUnit = "sqmeters",
    activeColor = "#3D535D",
    completedColor = "#7D4479") %>% 
  htmlwidgets::onRender("
                        function(el, x) {
                        var myMap = this;
                        myMap.on('baselayerchange',
                        function (e) {
                        myMap.minimap.changeLayer(L.tileLayer.provider(e.name));
                        })
                        }") %>% 
  addControl("", position = "topright")

#Jeg kører dette for at se kortet:
DanMAP




######################################################

# Libraries
library(tidyverse)
library(googlesheets4)
library(leaflet)

# Read in a Google sheet


# load the coordinates in the map and check: are any points missing? Why?
leaflet() %>% 
  addTiles() %>% 
  addMarkers(lng = places$Longitude, 
             lat = places$Latitude,
             popup = places$Placename
             )

#########################################################


# Task 2: Read in the googlesheet data you and your colleagues 
# populated with data into the DANmap object you created in Task 1.
DanMAP %>% 
  addMarkers(lng = places$Longitude, 
             lat = places$Latitude,
             popup = places$Placename)


# Task 3: Can you cluster the points in Leaflet? Google "clustering options in Leaflet in R"
DanMAP %>% 
  addMarkers(lng = places$Longitude, 
             lat = places$Latitude,
             popup = places$Placename, 
             clusterOptions = markerClusterOptions()
  )

# Task 4: Look at the map and consider what it is good for and what not.
# Kortet kan give et godt overblik over, hvad der er værd at se og opleve i Danmark i fritiden.
# 


# Task 5: Find out how to display notes and classifications in the map.


