library("rdatamarket")
library("googleVis")
library("plyr")

dminit(NULL)
life_expectancy <- dmlist("15r2!hrp")
population <- dmlist("1cfl!r3d")
gdp <- dmlist("15c9!hd1")

save(life_expectancy, population, gdp, file = "datasets/ex2.RData")

names(gdp)[3] <- "GDP"
names(life_expectancy)[3] <- "LifeExpectancy"
names(population)[3] <- "Population"
development <- join(gdp,life_expectancy)
development <- join(development,population)
selection <- c("Afghanistan","Australia","Austria","Belgium","Bolivia","Brazil","Cambodia",
               "Azerbaijan", "Chile","China","Denmark","Estonia","Ethiopia","Finland","France",
               "Georgia","Germany","Ghana","Greece","India","Indonesia","Iraq","Italy",
               "Japan","Lithuania","Luxembourg","Mexico","New Zealand", "Niger", "Norway", 
               "Poland", "Portugal","Rwanda", "Somalia", "South Africa", "Spain", "Sweden", 
               "Switzerland", "Turkey", "Uganda", "Ukraine", "United Kingdom", 
               "United States", "Vietnam")

save(development, selection, file = "datasets/ex3.RData")

development_complete <- subset(development, Year <= 2008)
development_motion <- subset(development_complete, Country %in% selection)

save(development_motion, file = "datasets/ex4.RData")

# first gvismotionchart

prelude <- gvisMotionChart(development_motion,
                           idvar = "Country",
                           timevar = "Year")
capture.output(plot(prelude, tag = "html"), file = "datasets/prelude.html")

interlude <- gvisMotionChart(development_motion,
                             idvar = "Country",
                             timevar = "Year",
                             xvar = "GDP",
                             yvar = "LifeExpectancy",
                             sizevar = "Population")
capture.output(plot(prelude, tag = "html"), file = "datasets/interlude.html")

development_motion$logGDP <- log(development_motion$GDP)
final_output <- gvisMotionChart(development_motion,
                                idvar = "Country",
                                timevar = "Year",
                                xvar = "logGDP",
                                yvar = "LifeExpectancy",
                                sizevar = "Population")
capture.output(plot(prelude, tag = "html"), file = "datasets/final_output.html")

motion_graph <- final_output
save(development_motion, motion_graph, file = "datasets/final_ex.RData")



