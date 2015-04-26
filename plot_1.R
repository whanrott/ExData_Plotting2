## Exploratory Data Analysis - Coursera/Johns Hopkins University
## https://class.coursera.org/exdata-013/human_grading/view/courses/973507/assessments/4/submissions

## file references assume that this file is in the working directory and the data is in a subdirectory called data

call_nei_scc_summary <- function() {
  nei_scc_summary <- readRDS("./data/exdata_data_NEI_data/summarySCC_PM25.rds");            print("read part 1 complete");
  nei_scc         <- readRDS("./data/exdata_data_NEI_data/Source_Classification_Code.rds"); print("read part 2 complete"); 
  nei_scc_summary <- merge(nei_scc_summary,nei_scc);                                        print("read part 3 complete");
  return(nei_scc_summary);
}

#nei_scc_summary <- call_nei_scc_summary()

## Assignment Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all
## sources for each of the years 1999, 2002, 2005, and 2008.

q1 <- tapply(nei_scc_summary$Emissions/1000, INDEX = nei_scc_summary$year, FUN = sum)

## define png output 
png("plot_1.png", width = 800, height = 600, units = "px")

plot(names(q1),q1, 
     main =  "PM2.5 Emissions for all USA",
     xlab = "Year",
     ylab = "Thousand Tons of PM2.5 particulate matter",
     type = "b")

## conclusion: total emissions have fallen in every year measured

# ## close graphics device to release saved plot and close graphics
dev.off()
graphics.off()