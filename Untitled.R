install.packages(c("tidyverse","purrr", "R.matlab"))
library(tidyverse)
library(R.matlab)
library(dplyr)

#convert matrix to data frame
district_data <- read.csv("recom_function/district_data.csv") |> group_by(district_id)

fullstate_stats <- ungroup(district_data) |> summarize(sum = sum(Turnout),
                                           Biden = sum(Biden),
                                           Biden_Percent = 100 * Biden / sum,
                                           Trump = sum(Trump),
                                           Trump_Percent = 100 * Trump / sum,
                                           Point_Difference = Trump_Percent - Biden_Percent,
                                           if (Trump > Biden) {
                                             "Trump"
                                           } else {
                                             "Biden"
                                           })

district_stats <- district_data |> summarize(sum = sum(Turnout),
                                             Biden = sum(Biden),
                                             Biden_Percent = 100 * Biden / sum,
                                             Trump = sum(Trump),
                                             Trump_Percent = 100 * Trump / sum,
                                             Voter_Weight = 1/sum * 1000000,
                                             Point_Difference = Trump_Percent - Biden_Percent,
                                             if (Trump > Biden) {
                                               "Trump"
                                             } else {
                                               "Biden"
                                             })




# district1_data <- filter(district_data, district_id == 1)


