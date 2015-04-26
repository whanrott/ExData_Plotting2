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

## Assignment Question 2
## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510")
## from 1999 to 2008? Use the base plotting system to make a plot answering this question.

## subset on values for Baltimore, MD region
bm <- nei_scc_summary[nei_scc_summary$fips == "24510",]

q2 <- tapply(
  bm$Emissions/1000,
  INDEX = bm$year,
  FUN = sum)

## define png output 
png("plot_2.png", width = 800, height = 600, units = "px")

plot(names(q2),q2,
     main =  "PM2.5 emissions for Baltimore, MD, USA",
     xlab = "Year",
     ylab = "Thousand Tons of PM2.5 particulate matter", type = "b" )

## conclusion: total emissions fell 1999-2002; then rose in 2005; then fell in 2008. The overall trend is falling.

## close graphics device to release saved plot and close graphics
dev.off()
graphics.off()