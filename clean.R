library(sf)
library(ggplot2)
library(rmapshaper)

#cleaning singapore
sf1 <- st_read("raw_data/master-plan-2014-planning-area-boundary-web-shp/MP14_PLNG_AREA_WEB_PL.shp")
sf1[,c("OBJECTID","PLN_AREA_C","CA_IND","REGION_N",
      "REGION_C","INC_CRC","FMEL_UPD_D",
      "X_ADDR","Y_ADDR","SHAPE_Leng","SHAPE_Area")] <- list(NULL)
colnames(sf1)[1] <- "division"
sf1 <- sf1[order(sf$division),]
rownames(sf) <- NULL

sf2 <- ms_simplify(sf1)
bbox <- st_bbox(sf1)
ratio <- as.numeric((bbox$xmax - bbox$xmin)/(bbox$ymax - bbox$ymin)) 

plot(sf1)
plot(sf2)

dir.create("processed_data/singapore/")
dir.create("processed_data/singapore/master-plan-2014-planning-area-boundary-web")
dirNew <- "processed_data/singapore/master-plan-2014-planning-area-boundary-web"

write(ratio,paste0(dirNew,"/ratio.txt"))
st_write(sf2,paste0(dirNew,"/data.shp"))
write.csv(data.frame(division=sf2$division),paste0(dirNew,"/division.csv"),row.names = F)


sf <- st_read("raw_data/World_Countries_Generalized/World_Countries_Generalized.shp")

ggplot(sf)+
  geom_sf()

sf[,c("FID","ISO","COUNTRYAFF","AFF_ISO")] <- list(NULL)
colnames(sf)[1] <- "division"

dir.create("processed_data/world/")
dir.create("processed_data/world/World_Countries_Generalized")

st_write(sf,"processed_data/world/World_Countries_Generalized/data.shp")
