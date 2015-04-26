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

## Assignment Question 4
## Across the United States, how have emissions from coal combustion-related sources changed
## from 1999-2008?

coal <- nei_scc_summary[grepl("Coal",nei_scc_summary$Short.Name), c("year","Emissions","fips","type")]

q4 <- tapply(
  coal$Emissions/1000,
  INDEX = coal$year,
  FUN = sum)

## define png output 
png("plot_4.png", width = 800, height = 600, units = "px")

plot(names(q4),q4,
     main =  "PM2.5 emissions from Coal for all USA",
     xlab = "Year",
     ylab = "Thousand Tons of PM2.5 particulate matter", type = "b" )

## conclusion: Emissions from coal compbustion were mostly stable from 1995-2005 and then fell sharply in 2008

# ## close graphics device to release saved plot and close graphics
dev.off()
graphics.off()