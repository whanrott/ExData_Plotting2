## Exploratory Data Analysis - Coursera/Johns Hopkins University
## https://class.coursera.org/exdata-013/human_grading/view/courses/973507/assessments/4/submissions

## file references assume that this file is in the working directory and the data is in a subdirectory called data

call_nei_scc_summary <- function() {
  nei_scc_summary <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds");            print("read part 1 complete");
  nei_scc         <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds"); print("read part 2 complete"); 
  nei_scc_summary <- merge(nei_scc_summary,nei_scc);                                        print("read part 3 complete");
  return(nei_scc_summary);
}

nei_scc_summary <- call_nei_scc_summary()

## Assignment Question 5
## How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

## subset on values for Baltimore, MD region
bm <- nei_scc_summary[nei_scc_summary$fips == "24510",]

## there are 2 different results according to whether you grep for 'Veh' on Short.Name or EI.Sector. 
## Short Names includes
##   Motor Vehicle Fires /Unspecified
##   Off-highway Diesel /Recreational Equipt /Specialty Vehicles/Carts
##   Off-highway Gasoline, 4-Stroke /Recreational Equipt /All Terrain Vehicles
##   Off-highway Gasoline, 4-Stroke /Recreational Equipt /Specialty Vehicles/Carts
## I've chosen to include more by using Short.Name

mv <-bm[grepl("Veh", bm$Short.Name),]

q5 <- tapply(
  mv$Emissions/1000,
  INDEX = mv$year,
  FUN = sum)

## define png output 
png("plot_5.png", width = 800, height = 600, units = "px")

plot(names(q5),q5,
     main =  "PM2.5 emissions from Vehicles for Baltimore, MD, USA",
     xlab = "Year",
     ylab = "Thousand Tons of PM2.5 particulate matter", type = "b" )

## conclusion: Emissions fell steeply 1999-2002 and have fallen progressively across the period

## close graphics device to release saved plot and close graphics
dev.off()
graphics.off()