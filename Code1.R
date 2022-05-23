## Maggie Lind
## Date: 06/21/2021
## Purpose: Playing with R (set up working space, load data, perform summary statistics, save results, make and save figure)
## Notes: all greened text is comment text and will not "run" in R  (## denotes a comment)

## Set up work space
  ## set the fold directory you want to pull and save data from/to
  setwd("/Users/Maggie/Dropbox/Yale/R_intro")
  ## load your packages 
  library(tidyverse) ## this is useful for data cleaning and includes ggplot2 which it good for data vis 
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  library(lubridate)
  library(MASS) ## this package holds the data that will be used in this exercise 
  
## load data 
  ## EXAMPLE for future: if loading from CSV file 
    ## boston <- read.csv(put filepath here in quotes and make sure all \ are replaced with /)
  ## load data from MASS package 
    boston <- Boston 
  
## View data and such
  ## What is the data class
    class(boston) 
  ## All data
    View(boston)
  ## Variable names
    names(boston)
  ## What class are the different variables
    class(boston$crim)
    class(boston$chas)
  ## frequency tables for variable rad and chas
    table(boston$rad)
    table(boston$chas)
  ## frequency tables for rad by chas
    table(boston$rad, boston$chas)
  ## variable summary
    summary(boston$zn)
  ## variable summary by another variable
    boston %>% group_by(chas) %>% summarize(min(zn), max(zn), mean(zn)) %>% ungroup
    
## Using the data
  ## Make a new variable with age in days instead of years
    boston$age_years <- boston$age * 356.5
    ## look at the summary of your new variable - does it look correct?
    summary(boston$age_years)
  ## Create a table of mean values of the rm, medv, and lstat variables by chas
    table1 <- aggregate(cbind(rm, medv, lstat)~chas, data = boston, FUN = mean)
    ## OR
    table1.1 <- boston %>% group_by(chas) %>% summarize_at(c("rm", "medv", "lstat"), funs(mean))
  ## save resulting table to a CSV file
    write.csv(table1, "table1_example.csv")
  ## Making proportions: proportion rm > 6
    proportion_table <- nrow(boston[which(boston$rm > 6),])/nrow(boston)
    ## present as percent 
    percent_table <- proportion_table*100
    class(percent_table) ## the result is currently of class numeric and can be used in math functions 
    ## format percent (round to the nearest tenth and add %)
    percent_table <- paste(round(percent_table, 1), "%", sep = "") 
    class(percent_table) ## the result is now a character string and can no longer be used in math functions 
  
## Visualizing data 
  ## Make a histogram (chart of observation frequencies) of the ages in years
  hist(boston$age) ## simple but SO ugly 
  ## Make a nicer histogram 
  ggplot(boston, aes(age)) + geom_histogram() + 
    labs(title = "Historgram of MASS Boston Age Data", y = "Count", x = "Age") + theme_minimal() + 
    theme(axis.line = element_line(color = "black")) 
  ## Historgram of ages by Chas 
  ggplot(boston, aes(x = age, fill = as.factor(chas))) + geom_histogram(position = "dodge") + 
    labs(title = "Historgram of MASS Boston Age Data", y = "Count", x = "Age", fill = "Chas") + 
    scale_fill_manual(values=c("#69b3a2", "#404080")) + theme_minimal() + 
    theme(axis.line = element_line(color = "black")) 
  ## make a historgram of all variables by Chas and save using a LOOP
    lst <- names(boston)[names(boston) != "chas"]
    for(var in lst){
      ggplot(boston, aes(x = boston[,var], fill = as.factor(chas))) + geom_histogram(position = "dodge") + 
        labs(title = "Historgram of MASS Boston Age Data", y = "Count", x = "Age", fill = "Chas") + 
        scale_fill_manual(values=c("#69b3a2", "#404080")) + theme_classic()
      ggsave(paste("Figures/Loop_histogram_", var, ".png", sep = ""))
    }
    
  ## make a historgram of all variables by Chas and save using a user defined FUNCTION called fig
    lst <- names(boston)[names(boston) != "chas"]
    ## Write function
    fig <- function(data, var1, var2){
      p <- ggplot(data, aes(x = data[,var1], fill = as.factor(data[,var2]))) + geom_histogram(position = "dodge") + 
        labs(title = "Historgram of MASS Boston Age Data", y = "Count", x = str_to_title(var1), fill = "Chas") + 
        scale_fill_manual(values=c("#69b3a2", "#404080")) + theme_classic() 
      return(ggsave(paste("Figures/function_histogram_", var1, ".png", sep = "")))
    }
    ## Apply function to specific variable
    fig(boston, "age", "chas")
    ## Apply to all variables 
    lapply(lst, function(x){fig(boston, x, "chas")})
    
    
  
    
    
    
    
  
  