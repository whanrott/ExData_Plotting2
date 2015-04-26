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

## Assignment Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
## variable, which of these four sources have seen decreases in emissions from 1999-2008 for
## Baltimore City? Which have seen increases in emissions from 1999-2008? Use the ggplot2
## plotting system to make a plot answer this question.

## subset on values for Baltimore, MD region
bm <- nei_scc_summary[nei_scc_summary$fips == "24510",]

## using tapply to show what the summed values should be. GGPlot2 can't use matrix data so this is just for interest
bm_t <- tapply(bm$Emissions, bm[, c(1,4)], sum)

## using aggregate will give something which ggplot can use.
bm_a <- aggregate(bm$Emissions,by = list(bm$year,bm$type), FUN = sum)
names(bm_a) <- c("Year","Type","Emissions")

## define png output 
png("plot_3.png", width = 800, height = 600, units = "px")

q3 <- ggplot(bm_a, aes(Year, Emissions/1000), fill = Type)
print(q3 +
        geom_line() +
        facet_grid(. ~ Type) +
        ggtitle("M2.5 emissions for Baltimore, MD, USA") +
        xlab("Year") +
        ylab("Thousand Tons of PM2.5 particulate matter")
      )

## conclusion: Non-Point, On-Road and Non-Road have shown definite and progressive decreases over the period.
# Point values saw a rise and then a fall back to 1999 values

# ## close graphics device to release saved plot and close graphics
dev.off()
graphics.off()