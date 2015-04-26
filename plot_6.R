## Exploratory Data Analysis - Coursera/Johns Hopkins University
## https://class.coursera.org/exdata-013/human_grading/view/courses/973507/assessments/4/submissions

## file references assume that this file is in the working directory and the data is in a subdirectory called data

library(ggplot2)

call_nei_scc_summary <- function() {
  nei_scc_summary <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds");            print("read part 1 complete");
  nei_scc         <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds"); print("read part 2 complete"); 
  nei_scc_summary <- merge(nei_scc_summary,nei_scc);                                        print("read part 3 complete");
  return(nei_scc_summary);
}

#nei_scc_summary <- call_nei_scc_summary()

## Assignment Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
## vehicle sources in Los Angeles County, California (fips == "06037"). Which city has seen
## greater changes over time in motor vehicle emissions?

bmla <- nei_scc_summary[nei_scc_summary$fips == "24510" | nei_scc_summary$fips == "06037",]

## there are 2 different results according to whether you grep for 'Veh' on Short.Name or EI.Sector. 
## Short Names includes: Motor Vehicle Fires /Unspecified
## I've chosen to include more by using Short.Name
bmlav <- bmla[grepl("Veh", bmla$Short.Name), ]

bmlav_a <- aggregate(bmlav$Emissions,by = list(bmlav$year,bmlav$fips), FUN = sum)
names(bmlav_a) <- c("Year","fips","Emissions")

# data needs suitable labels for the region. Add them by merging a data frame on FIPS data
bmlav_a_fips <- data.frame(c("06037","24510"),c("Los Angeles County, California","Baltimore City, Maryland"))
names(bmlav_a_fips) <- c("fips","Region")
bmlav_a <- merge(bmlav_a, bmlav_a_fips)
bmlav_a$fips <- NULL

## define png output 
png("plot_6.png", width = 800, height = 600, units = "px")

q6 <- ggplot(bmlav_a, aes(Year, Emissions/1000), fill = Region)
print(q6 + 
        geom_line() + 
        facet_grid(. ~ Region) +
        ggtitle("PM2.5 emissions for Baltimore, MD, and Los Angeles regions, USA") +
        xlab("Year") +
        ylab("Thousand Tons of PM2.5 particulate matter")
      )

## conclusion: Los Angeles had a consistently higher level of PM2.5 over the period. 
# Los Angeles PM2.5 levels rose over the period whilst (4005 to 4168) Baltimore fell (347 to 88).

## close graphics device to release saved plot and close graphics
dev.off()
graphics.off()