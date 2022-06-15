## Maggie Lind
## Last Updated: June 15 2022
## Ko coding sessions
## Purpose: Setting up your code and loading data of different formats

## Load libraries
library(readxl)
library(ggplot2)
library(lubridate)
library(tidyverse)
library(dplyr)
library(boot)
library(table1)
library(stringi)
library(devtools)
library(grDevices)

## Pick a seed
set.seed(3538)

## Load data 
  ## CSV data 
  demo <- read.csv("/Users/mll69/Dropbox/Yale/Coding_Sessions/Data/Tester_data.csv")
  ## Excel data (by sheet)
  excel <- read_excel("/Users/mll69/Dropbox/Yale/Coding_Sessions/Data/Tester_excel.xlsx", sheet = "Sheet2")
