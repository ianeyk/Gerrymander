install.packages(c("tidyverse","dplyr", "R.matlab", "ggplot2", "gg.gap"))
library(tidyverse)
library(R.matlab)
library(dplyr)
library(ggplot2)
library(plotly)

# Convert matrix to data frame
redistrict_data <- read.csv("vtd_election_results.csv")

# Get stats on the full state (i.e., popular vote)
fullstate_stats <- redistrict_data |> summarize(sum = sum(Turnout),
                                                       Biden = sum(Biden),
                                                       Biden_Percent = 100 * Biden / sum,
                                                       Trump = sum(Trump),
                                                       Trump_Percent = 100 * Trump / sum,
                                                       Point_Difference = Trump_Percent - Biden_Percent,
                                                       Winner = if (Trump > Biden) {
                                                         "Trump"
                                                       } else {
                                                         "Biden"
                                                       })


# Get statistical summary on districts fro a particular redistricting
redistrict_stats <- function(redistrict_number) {
  redistrict_number |> summarize(sum = sum(Turnout),
                                 Biden = sum(Biden),
                                 Biden_Percent = 100 * Biden / sum,
                                 Trump = sum(Trump),
                                 Trump_Percent = 100 * Trump / sum,
                                 Voter_Weight = 1/sum * 1000000,
                                 Point_Difference = Trump_Percent - Biden_Percent,
                                 Winner = if (Trump > Biden) {
                                   "Trump"
                                 } else if (Biden > Trump) {
                                   "Biden"
                                 } else {
                                   "Tie"
                                 }) |> 
    colnames(my_dataframe)[1] ="district_id"
}

# Count district winner breakdown for a particular redistricting
vote_summary <- function(redistrict_vote_number){
  vote_summary <- redistrict_vote_number |> summarize(Trump = length(which(Winner=="Trump")),
                                                      Biden = length(which(Winner=="Biden")),
                                                      District_Number = sum(Trump, Biden),
                                                      Trump_Percent = Trump/District_Number,
                                                      Biden_Percent = Biden/District_Number,
                                                      Winner = if (Trump_Percent > 0.5) {
                                                          "Trump"
                                                        } else if (Trump_Percent < 0.5){
                                                          "Biden"
                                                        } else{
                                                          "Tie"
                                                        })
}

# Plot the district election outcomes for each redistricting
redistrict_plot <- function(redistrict_stats, rd_title){
  
  district_plot <- ggplot(data = redistrict_stats,
                          mapping = aes(x = Winner, fill = Winner)) +
  geom_bar(show.legend = FALSE) +
  scale_fill_manual(values = c("#131ccf", "#c22517", "6b6b6b")) +
  labs(title = rd_title,
       x = "Winning Candidate",
       y = "Districts Won") +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  ylim(0,30) +
  theme(plot.title = element_text(size=25))
}

# export redistrict summary as .csv
write.csv(district_outcomes, "election_outcomes.csv", row.names=TRUE)

# Reference Statistics
Trump_Win_Count <- length(which(district_outcomes$Winner == 'Trump'))
Tied_Count <- length(which(district_outcomes$Winner == "Biden"))
Biden_Win_Count <- length(which(district_outcomes$Winner == "Tie"))

Avg_Trump_Percent <- mean(district_outcomes$Trump_Percent)
Avg_Biden_Percent <- mean(district_outcomes$Biden_Percent)


# Save redistrict election plots as .png
png(file="./subplot_generation/rd78_testplot.png",
    width=400, height=400)
rd78_testplot
dev.off()

# I am very sorry about this following sections. I know it is not efficient (I do not
# know nor had the time to properly learn R syntax), but at least I generated
# these with a python script and not by hand 

# Group election data by district
redistrict1 <- redistrict_data |> group_by(district1)
redistrict2 <- redistrict_data |> group_by(district2)
redistrict3 <- redistrict_data |> group_by(district3)
redistrict4 <- redistrict_data |> group_by(district4)
redistrict5 <- redistrict_data |> group_by(district5)
redistrict6 <- redistrict_data |> group_by(district6)
redistrict7 <- redistrict_data |> group_by(district7)
redistrict8 <- redistrict_data |> group_by(district8)
redistrict9 <- redistrict_data |> group_by(district9)
redistrict10 <- redistrict_data |> group_by(district10)
redistrict11 <- redistrict_data |> group_by(district11)
redistrict12 <- redistrict_data |> group_by(district12)
redistrict13 <- redistrict_data |> group_by(district13)
redistrict14 <- redistrict_data |> group_by(district14)
redistrict15 <- redistrict_data |> group_by(district15)
redistrict16 <- redistrict_data |> group_by(district16)
redistrict17 <- redistrict_data |> group_by(district17)
redistrict18 <- redistrict_data |> group_by(district18)
redistrict19 <- redistrict_data |> group_by(district19)
redistrict20 <- redistrict_data |> group_by(district20)
redistrict21 <- redistrict_data |> group_by(district21)
redistrict22 <- redistrict_data |> group_by(district22)
redistrict23 <- redistrict_data |> group_by(district23)
redistrict24 <- redistrict_data |> group_by(district24)
redistrict25 <- redistrict_data |> group_by(district25)
redistrict26 <- redistrict_data |> group_by(district26)
redistrict27 <- redistrict_data |> group_by(district27)
redistrict28 <- redistrict_data |> group_by(district28)
redistrict29 <- redistrict_data |> group_by(district29)
redistrict30 <- redistrict_data |> group_by(district30)
redistrict31 <- redistrict_data |> group_by(district31)
redistrict32 <- redistrict_data |> group_by(district32)
redistrict33 <- redistrict_data |> group_by(district33)
redistrict34 <- redistrict_data |> group_by(district34)
redistrict35 <- redistrict_data |> group_by(district35)
redistrict36 <- redistrict_data |> group_by(district36)
redistrict37 <- redistrict_data |> group_by(district37)
redistrict38 <- redistrict_data |> group_by(district38)
redistrict39 <- redistrict_data |> group_by(district39)
redistrict40 <- redistrict_data |> group_by(district40)
redistrict41 <- redistrict_data |> group_by(district41)
redistrict42 <- redistrict_data |> group_by(district42)
redistrict43 <- redistrict_data |> group_by(district43)
redistrict44 <- redistrict_data |> group_by(district44)
redistrict45 <- redistrict_data |> group_by(district45)
redistrict46 <- redistrict_data |> group_by(district46)
redistrict47 <- redistrict_data |> group_by(district47)
redistrict48 <- redistrict_data |> group_by(district48)
redistrict49 <- redistrict_data |> group_by(district49)
redistrict50 <- redistrict_data |> group_by(district50)
redistrict51 <- redistrict_data |> group_by(district51)
redistrict52 <- redistrict_data |> group_by(district52)
redistrict53 <- redistrict_data |> group_by(district53)
redistrict54 <- redistrict_data |> group_by(district54)
redistrict55 <- redistrict_data |> group_by(district55)
redistrict56 <- redistrict_data |> group_by(district56)
redistrict57 <- redistrict_data |> group_by(district57)
redistrict58 <- redistrict_data |> group_by(district58)
redistrict59 <- redistrict_data |> group_by(district59)
redistrict60 <- redistrict_data |> group_by(district60)
redistrict61 <- redistrict_data |> group_by(district61)
redistrict62 <- redistrict_data |> group_by(district62)
redistrict63 <- redistrict_data |> group_by(district63)
redistrict64 <- redistrict_data |> group_by(district64)
redistrict65 <- redistrict_data |> group_by(district65)
redistrict66 <- redistrict_data |> group_by(district66)
redistrict67 <- redistrict_data |> group_by(district67)
redistrict68 <- redistrict_data |> group_by(district68)
redistrict69 <- redistrict_data |> group_by(district69)
redistrict70 <- redistrict_data |> group_by(district70)
redistrict71 <- redistrict_data |> group_by(district71)
redistrict72 <- redistrict_data |> group_by(district72)
redistrict73 <- redistrict_data |> group_by(district73)
redistrict74 <- redistrict_data |> group_by(district74)
redistrict75 <- redistrict_data |> group_by(district75)
redistrict76 <- redistrict_data |> group_by(district76)
redistrict77 <- redistrict_data |> group_by(district77)
redistrict78 <- redistrict_data |> group_by(district78)
redistrict79 <- redistrict_data |> group_by(district79)
redistrict80 <- redistrict_data |> group_by(district80)
redistrict81 <- redistrict_data |> group_by(district81)
redistrict82 <- redistrict_data |> group_by(district82)
redistrict83 <- redistrict_data |> group_by(district83)
redistrict84 <- redistrict_data |> group_by(district84)
redistrict85 <- redistrict_data |> group_by(district85)
redistrict86 <- redistrict_data |> group_by(district86)
redistrict87 <- redistrict_data |> group_by(district87)
redistrict88 <- redistrict_data |> group_by(district88)
redistrict89 <- redistrict_data |> group_by(district89)
redistrict90 <- redistrict_data |> group_by(district90)
redistrict91 <- redistrict_data |> group_by(district91)
redistrict92 <- redistrict_data |> group_by(district92)
redistrict93 <- redistrict_data |> group_by(district93)
redistrict94 <- redistrict_data |> group_by(district94)
redistrict95 <- redistrict_data |> group_by(district95)
redistrict96 <- redistrict_data |> group_by(district96)
redistrict97 <- redistrict_data |> group_by(district97)
redistrict98 <- redistrict_data |> group_by(district98)
redistrict99 <- redistrict_data |> group_by(district99)
redistrict100 <- redistrict_data |> group_by(district100)
redistrict101 <- redistrict_data |> group_by(district101)
redistrict102 <- redistrict_data |> group_by(district102)
redistrict103 <- redistrict_data |> group_by(district103)
redistrict104 <- redistrict_data |> group_by(district104)
redistrict105 <- redistrict_data |> group_by(district105)
redistrict106 <- redistrict_data |> group_by(district106)
redistrict107 <- redistrict_data |> group_by(district107)
redistrict108 <- redistrict_data |> group_by(district108)
redistrict109 <- redistrict_data |> group_by(district109)
redistrict110 <- redistrict_data |> group_by(district110)
redistrict111 <- redistrict_data |> group_by(district111)
redistrict112 <- redistrict_data |> group_by(district112)
redistrict113 <- redistrict_data |> group_by(district113)
redistrict114 <- redistrict_data |> group_by(district114)
redistrict115 <- redistrict_data |> group_by(district115)
redistrict116 <- redistrict_data |> group_by(district116)
redistrict117 <- redistrict_data |> group_by(district117)
redistrict118 <- redistrict_data |> group_by(district118)
redistrict119 <- redistrict_data |> group_by(district119)
redistrict120 <- redistrict_data |> group_by(district120)
redistrict121 <- redistrict_data |> group_by(district121)
redistrict122 <- redistrict_data |> group_by(district122)
redistrict123 <- redistrict_data |> group_by(district123)
redistrict124 <- redistrict_data |> group_by(district124)
redistrict125 <- redistrict_data |> group_by(district125)
redistrict126 <- redistrict_data |> group_by(district126)
redistrict127 <- redistrict_data |> group_by(district127)
redistrict128 <- redistrict_data |> group_by(district128)
redistrict129 <- redistrict_data |> group_by(district129)
redistrict130 <- redistrict_data |> group_by(district130)
redistrict131 <- redistrict_data |> group_by(district131)
redistrict132 <- redistrict_data |> group_by(district132)
redistrict133 <- redistrict_data |> group_by(district133)
redistrict134 <- redistrict_data |> group_by(district134)
redistrict135 <- redistrict_data |> group_by(district135)
redistrict136 <- redistrict_data |> group_by(district136)
redistrict137 <- redistrict_data |> group_by(district137)
redistrict138 <- redistrict_data |> group_by(district138)
redistrict139 <- redistrict_data |> group_by(district139)
redistrict140 <- redistrict_data |> group_by(district140)
redistrict141 <- redistrict_data |> group_by(district141)
redistrict142 <- redistrict_data |> group_by(district142)
redistrict143 <- redistrict_data |> group_by(district143)
redistrict144 <- redistrict_data |> group_by(district144)
redistrict145 <- redistrict_data |> group_by(district145)
redistrict146 <- redistrict_data |> group_by(district146)
redistrict147 <- redistrict_data |> group_by(district147)
redistrict148 <- redistrict_data |> group_by(district148)
redistrict149 <- redistrict_data |> group_by(district149)
redistrict150 <- redistrict_data |> group_by(district150)
redistrict151 <- redistrict_data |> group_by(district151)
redistrict152 <- redistrict_data |> group_by(district152)
redistrict153 <- redistrict_data |> group_by(district153)
redistrict154 <- redistrict_data |> group_by(district154)
redistrict155 <- redistrict_data |> group_by(district155)
redistrict156 <- redistrict_data |> group_by(district156)
redistrict157 <- redistrict_data |> group_by(district157)
redistrict158 <- redistrict_data |> group_by(district158)
redistrict159 <- redistrict_data |> group_by(district159)
redistrict160 <- redistrict_data |> group_by(district160)
redistrict161 <- redistrict_data |> group_by(district161)
redistrict162 <- redistrict_data |> group_by(district162)
redistrict163 <- redistrict_data |> group_by(district163)
redistrict164 <- redistrict_data |> group_by(district164)
redistrict165 <- redistrict_data |> group_by(district165)
redistrict166 <- redistrict_data |> group_by(district166)
redistrict167 <- redistrict_data |> group_by(district167)
redistrict168 <- redistrict_data |> group_by(district168)
redistrict169 <- redistrict_data |> group_by(district169)
redistrict170 <- redistrict_data |> group_by(district170)
redistrict171 <- redistrict_data |> group_by(district171)
redistrict172 <- redistrict_data |> group_by(district172)
redistrict173 <- redistrict_data |> group_by(district173)
redistrict174 <- redistrict_data |> group_by(district174)
redistrict175 <- redistrict_data |> group_by(district175)
redistrict176 <- redistrict_data |> group_by(district176)
redistrict177 <- redistrict_data |> group_by(district177)
redistrict178 <- redistrict_data |> group_by(district178)
redistrict179 <- redistrict_data |> group_by(district179)
redistrict180 <- redistrict_data |> group_by(district180)
redistrict181 <- redistrict_data |> group_by(district181)
redistrict182 <- redistrict_data |> group_by(district182)
redistrict183 <- redistrict_data |> group_by(district183)
redistrict184 <- redistrict_data |> group_by(district184)
redistrict185 <- redistrict_data |> group_by(district185)
redistrict186 <- redistrict_data |> group_by(district186)
redistrict187 <- redistrict_data |> group_by(district187)
redistrict188 <- redistrict_data |> group_by(district188)
redistrict189 <- redistrict_data |> group_by(district189)
redistrict190 <- redistrict_data |> group_by(district190)
redistrict191 <- redistrict_data |> group_by(district191)
redistrict192 <- redistrict_data |> group_by(district192)
redistrict193 <- redistrict_data |> group_by(district193)
redistrict194 <- redistrict_data |> group_by(district194)
redistrict195 <- redistrict_data |> group_by(district195)
redistrict196 <- redistrict_data |> group_by(district196)
redistrict197 <- redistrict_data |> group_by(district197)
redistrict198 <- redistrict_data |> group_by(district198)
redistrict199 <- redistrict_data |> group_by(district199)
redistrict200 <- redistrict_data |> group_by(district200)


# Get Redistrict Stats
redistrict1_stats <- redistrict_stats(redistrict1)
redistrict2_stats <- redistrict_stats(redistrict2)
redistrict3_stats <- redistrict_stats(redistrict3)
redistrict4_stats <- redistrict_stats(redistrict4)
redistrict5_stats <- redistrict_stats(redistrict5)
redistrict6_stats <- redistrict_stats(redistrict6)
redistrict7_stats <- redistrict_stats(redistrict7)
redistrict8_stats <- redistrict_stats(redistrict8)
redistrict9_stats <- redistrict_stats(redistrict9)
redistrict10_stats <- redistrict_stats(redistrict10)
redistrict11_stats <- redistrict_stats(redistrict11)
redistrict12_stats <- redistrict_stats(redistrict12)
redistrict13_stats <- redistrict_stats(redistrict13)
redistrict14_stats <- redistrict_stats(redistrict14)
redistrict15_stats <- redistrict_stats(redistrict15)
redistrict16_stats <- redistrict_stats(redistrict16)
redistrict17_stats <- redistrict_stats(redistrict17)
redistrict18_stats <- redistrict_stats(redistrict18)
redistrict19_stats <- redistrict_stats(redistrict19)
redistrict20_stats <- redistrict_stats(redistrict20)
redistrict21_stats <- redistrict_stats(redistrict21)
redistrict22_stats <- redistrict_stats(redistrict22)
redistrict23_stats <- redistrict_stats(redistrict23)
redistrict24_stats <- redistrict_stats(redistrict24)
redistrict25_stats <- redistrict_stats(redistrict25)
redistrict26_stats <- redistrict_stats(redistrict26)
redistrict27_stats <- redistrict_stats(redistrict27)
redistrict28_stats <- redistrict_stats(redistrict28)
redistrict29_stats <- redistrict_stats(redistrict29)
redistrict30_stats <- redistrict_stats(redistrict30)
redistrict31_stats <- redistrict_stats(redistrict31)
redistrict32_stats <- redistrict_stats(redistrict32)
redistrict33_stats <- redistrict_stats(redistrict33)
redistrict34_stats <- redistrict_stats(redistrict34)
redistrict35_stats <- redistrict_stats(redistrict35)
redistrict36_stats <- redistrict_stats(redistrict36)
redistrict37_stats <- redistrict_stats(redistrict37)
redistrict38_stats <- redistrict_stats(redistrict38)
redistrict39_stats <- redistrict_stats(redistrict39)
redistrict40_stats <- redistrict_stats(redistrict40)
redistrict41_stats <- redistrict_stats(redistrict41)
redistrict42_stats <- redistrict_stats(redistrict42)
redistrict43_stats <- redistrict_stats(redistrict43)
redistrict44_stats <- redistrict_stats(redistrict44)
redistrict45_stats <- redistrict_stats(redistrict45)
redistrict46_stats <- redistrict_stats(redistrict46)
redistrict47_stats <- redistrict_stats(redistrict47)
redistrict48_stats <- redistrict_stats(redistrict48)
redistrict49_stats <- redistrict_stats(redistrict49)
redistrict50_stats <- redistrict_stats(redistrict50)
redistrict51_stats <- redistrict_stats(redistrict51)
redistrict52_stats <- redistrict_stats(redistrict52)
redistrict53_stats <- redistrict_stats(redistrict53)
redistrict54_stats <- redistrict_stats(redistrict54)
redistrict55_stats <- redistrict_stats(redistrict55)
redistrict56_stats <- redistrict_stats(redistrict56)
redistrict57_stats <- redistrict_stats(redistrict57)
redistrict58_stats <- redistrict_stats(redistrict58)
redistrict59_stats <- redistrict_stats(redistrict59)
redistrict60_stats <- redistrict_stats(redistrict60)
redistrict61_stats <- redistrict_stats(redistrict61)
redistrict62_stats <- redistrict_stats(redistrict62)
redistrict63_stats <- redistrict_stats(redistrict63)
redistrict64_stats <- redistrict_stats(redistrict64)
redistrict65_stats <- redistrict_stats(redistrict65)
redistrict66_stats <- redistrict_stats(redistrict66)
redistrict67_stats <- redistrict_stats(redistrict67)
redistrict68_stats <- redistrict_stats(redistrict68)
redistrict69_stats <- redistrict_stats(redistrict69)
redistrict70_stats <- redistrict_stats(redistrict70)
redistrict71_stats <- redistrict_stats(redistrict71)
redistrict72_stats <- redistrict_stats(redistrict72)
redistrict73_stats <- redistrict_stats(redistrict73)
redistrict74_stats <- redistrict_stats(redistrict74)
redistrict75_stats <- redistrict_stats(redistrict75)
redistrict76_stats <- redistrict_stats(redistrict76)
redistrict77_stats <- redistrict_stats(redistrict77)
redistrict78_stats <- redistrict_stats(redistrict78)
redistrict79_stats <- redistrict_stats(redistrict79)
redistrict80_stats <- redistrict_stats(redistrict80)
redistrict81_stats <- redistrict_stats(redistrict81)
redistrict82_stats <- redistrict_stats(redistrict82)
redistrict83_stats <- redistrict_stats(redistrict83)
redistrict84_stats <- redistrict_stats(redistrict84)
redistrict85_stats <- redistrict_stats(redistrict85)
redistrict86_stats <- redistrict_stats(redistrict86)
redistrict87_stats <- redistrict_stats(redistrict87)
redistrict88_stats <- redistrict_stats(redistrict88)
redistrict89_stats <- redistrict_stats(redistrict89)
redistrict90_stats <- redistrict_stats(redistrict90)
redistrict91_stats <- redistrict_stats(redistrict91)
redistrict92_stats <- redistrict_stats(redistrict92)
redistrict93_stats <- redistrict_stats(redistrict93)
redistrict94_stats <- redistrict_stats(redistrict94)
redistrict95_stats <- redistrict_stats(redistrict95)
redistrict96_stats <- redistrict_stats(redistrict96)
redistrict97_stats <- redistrict_stats(redistrict97)
redistrict98_stats <- redistrict_stats(redistrict98)
redistrict99_stats <- redistrict_stats(redistrict99)
redistrict100_stats <- redistrict_stats(redistrict100)
redistrict101_stats <- redistrict_stats(redistrict101)
redistrict102_stats <- redistrict_stats(redistrict102)
redistrict103_stats <- redistrict_stats(redistrict103)
redistrict104_stats <- redistrict_stats(redistrict104)
redistrict105_stats <- redistrict_stats(redistrict105)
redistrict106_stats <- redistrict_stats(redistrict106)
redistrict107_stats <- redistrict_stats(redistrict107)
redistrict108_stats <- redistrict_stats(redistrict108)
redistrict109_stats <- redistrict_stats(redistrict109)
redistrict110_stats <- redistrict_stats(redistrict110)
redistrict111_stats <- redistrict_stats(redistrict111)
redistrict112_stats <- redistrict_stats(redistrict112)
redistrict113_stats <- redistrict_stats(redistrict113)
redistrict114_stats <- redistrict_stats(redistrict114)
redistrict115_stats <- redistrict_stats(redistrict115)
redistrict116_stats <- redistrict_stats(redistrict116)
redistrict117_stats <- redistrict_stats(redistrict117)
redistrict118_stats <- redistrict_stats(redistrict118)
redistrict119_stats <- redistrict_stats(redistrict119)
redistrict120_stats <- redistrict_stats(redistrict120)
redistrict121_stats <- redistrict_stats(redistrict121)
redistrict122_stats <- redistrict_stats(redistrict122)
redistrict123_stats <- redistrict_stats(redistrict123)
redistrict124_stats <- redistrict_stats(redistrict124)
redistrict125_stats <- redistrict_stats(redistrict125)
redistrict126_stats <- redistrict_stats(redistrict126)
redistrict127_stats <- redistrict_stats(redistrict127)
redistrict128_stats <- redistrict_stats(redistrict128)
redistrict129_stats <- redistrict_stats(redistrict129)
redistrict130_stats <- redistrict_stats(redistrict130)
redistrict131_stats <- redistrict_stats(redistrict131)
redistrict132_stats <- redistrict_stats(redistrict132)
redistrict133_stats <- redistrict_stats(redistrict133)
redistrict134_stats <- redistrict_stats(redistrict134)
redistrict135_stats <- redistrict_stats(redistrict135)
redistrict136_stats <- redistrict_stats(redistrict136)
redistrict137_stats <- redistrict_stats(redistrict137)
redistrict138_stats <- redistrict_stats(redistrict138)
redistrict139_stats <- redistrict_stats(redistrict139)
redistrict140_stats <- redistrict_stats(redistrict140)
redistrict141_stats <- redistrict_stats(redistrict141)
redistrict142_stats <- redistrict_stats(redistrict142)
redistrict143_stats <- redistrict_stats(redistrict143)
redistrict144_stats <- redistrict_stats(redistrict144)
redistrict145_stats <- redistrict_stats(redistrict145)
redistrict146_stats <- redistrict_stats(redistrict146)
redistrict147_stats <- redistrict_stats(redistrict147)
redistrict148_stats <- redistrict_stats(redistrict148)
redistrict149_stats <- redistrict_stats(redistrict149)
redistrict150_stats <- redistrict_stats(redistrict150)
redistrict151_stats <- redistrict_stats(redistrict151)
redistrict152_stats <- redistrict_stats(redistrict152)
redistrict153_stats <- redistrict_stats(redistrict153)
redistrict154_stats <- redistrict_stats(redistrict154)
redistrict155_stats <- redistrict_stats(redistrict155)
redistrict156_stats <- redistrict_stats(redistrict156)
redistrict157_stats <- redistrict_stats(redistrict157)
redistrict158_stats <- redistrict_stats(redistrict158)
redistrict159_stats <- redistrict_stats(redistrict159)
redistrict160_stats <- redistrict_stats(redistrict160)
redistrict161_stats <- redistrict_stats(redistrict161)
redistrict162_stats <- redistrict_stats(redistrict162)
redistrict163_stats <- redistrict_stats(redistrict163)
redistrict164_stats <- redistrict_stats(redistrict164)
redistrict165_stats <- redistrict_stats(redistrict165)
redistrict166_stats <- redistrict_stats(redistrict166)
redistrict167_stats <- redistrict_stats(redistrict167)
redistrict168_stats <- redistrict_stats(redistrict168)
redistrict169_stats <- redistrict_stats(redistrict169)
redistrict170_stats <- redistrict_stats(redistrict170)
redistrict171_stats <- redistrict_stats(redistrict171)
redistrict172_stats <- redistrict_stats(redistrict172)
redistrict173_stats <- redistrict_stats(redistrict173)
redistrict174_stats <- redistrict_stats(redistrict174)
redistrict175_stats <- redistrict_stats(redistrict175)
redistrict176_stats <- redistrict_stats(redistrict176)
redistrict177_stats <- redistrict_stats(redistrict177)
redistrict178_stats <- redistrict_stats(redistrict178)
redistrict179_stats <- redistrict_stats(redistrict179)
redistrict180_stats <- redistrict_stats(redistrict180)
redistrict181_stats <- redistrict_stats(redistrict181)
redistrict182_stats <- redistrict_stats(redistrict182)
redistrict183_stats <- redistrict_stats(redistrict183)
redistrict184_stats <- redistrict_stats(redistrict184)
redistrict185_stats <- redistrict_stats(redistrict185)
redistrict186_stats <- redistrict_stats(redistrict186)
redistrict187_stats <- redistrict_stats(redistrict187)
redistrict188_stats <- redistrict_stats(redistrict188)
redistrict189_stats <- redistrict_stats(redistrict189)
redistrict190_stats <- redistrict_stats(redistrict190)
redistrict191_stats <- redistrict_stats(redistrict191)
redistrict192_stats <- redistrict_stats(redistrict192)
redistrict193_stats <- redistrict_stats(redistrict193)
redistrict194_stats <- redistrict_stats(redistrict194)
redistrict195_stats <- redistrict_stats(redistrict195)
redistrict196_stats <- redistrict_stats(redistrict196)
redistrict197_stats <- redistrict_stats(redistrict197)
redistrict198_stats <- redistrict_stats(redistrict198)
redistrict199_stats <- redistrict_stats(redistrict199)
redistrict200_stats <- redistrict_stats(redistrict200)


redistrict1_vote <- (redistrict1_stats)
redistrict2_vote <- (redistrict2_stats)
redistrict3_vote <- (redistrict3_stats)
redistrict4_vote <- (redistrict4_stats)
redistrict5_vote <- (redistrict5_stats)
redistrict6_vote <- (redistrict6_stats)
redistrict7_vote <- (redistrict7_stats)
redistrict8_vote <- (redistrict8_stats)
redistrict9_vote <- (redistrict9_stats)
redistrict10_vote <- (redistrict10_stats)
redistrict11_vote <- (redistrict11_stats)
redistrict12_vote <- (redistrict12_stats)
redistrict13_vote <- (redistrict13_stats)
redistrict14_vote <- (redistrict14_stats)
redistrict15_vote <- (redistrict15_stats)
redistrict16_vote <- (redistrict16_stats)
redistrict17_vote <- (redistrict17_stats)
redistrict18_vote <- (redistrict18_stats)
redistrict19_vote <- (redistrict19_stats)
redistrict20_vote <- (redistrict20_stats)
redistrict21_vote <- (redistrict21_stats)
redistrict22_vote <- (redistrict22_stats)
redistrict23_vote <- (redistrict23_stats)
redistrict24_vote <- (redistrict24_stats)
redistrict25_vote <- (redistrict25_stats)
redistrict26_vote <- (redistrict26_stats)
redistrict27_vote <- (redistrict27_stats)
redistrict28_vote <- (redistrict28_stats)
redistrict29_vote <- (redistrict29_stats)
redistrict30_vote <- (redistrict30_stats)
redistrict31_vote <- (redistrict31_stats)
redistrict32_vote <- (redistrict32_stats)
redistrict33_vote <- (redistrict33_stats)
redistrict34_vote <- (redistrict34_stats)
redistrict35_vote <- (redistrict35_stats)
redistrict36_vote <- (redistrict36_stats)
redistrict37_vote <- (redistrict37_stats)
redistrict38_vote <- (redistrict38_stats)
redistrict39_vote <- (redistrict39_stats)
redistrict40_vote <- (redistrict40_stats)
redistrict41_vote <- (redistrict41_stats)
redistrict42_vote <- (redistrict42_stats)
redistrict43_vote <- (redistrict43_stats)
redistrict44_vote <- (redistrict44_stats)
redistrict45_vote <- (redistrict45_stats)
redistrict46_vote <- (redistrict46_stats)
redistrict47_vote <- (redistrict47_stats)
redistrict48_vote <- (redistrict48_stats)
redistrict49_vote <- (redistrict49_stats)
redistrict50_vote <- (redistrict50_stats)
redistrict51_vote <- (redistrict51_stats)
redistrict52_vote <- (redistrict52_stats)
redistrict53_vote <- (redistrict53_stats)
redistrict54_vote <- (redistrict54_stats)
redistrict55_vote <- (redistrict55_stats)
redistrict56_vote <- (redistrict56_stats)
redistrict57_vote <- (redistrict57_stats)
redistrict58_vote <- (redistrict58_stats)
redistrict59_vote <- (redistrict59_stats)
redistrict60_vote <- (redistrict60_stats)
redistrict61_vote <- (redistrict61_stats)
redistrict62_vote <- (redistrict62_stats)
redistrict63_vote <- (redistrict63_stats)
redistrict64_vote <- (redistrict64_stats)
redistrict65_vote <- (redistrict65_stats)
redistrict66_vote <- (redistrict66_stats)
redistrict67_vote <- (redistrict67_stats)
redistrict68_vote <- (redistrict68_stats)
redistrict69_vote <- (redistrict69_stats)
redistrict70_vote <- (redistrict70_stats)
redistrict71_vote <- (redistrict71_stats)
redistrict72_vote <- (redistrict72_stats)
redistrict73_vote <- (redistrict73_stats)
redistrict74_vote <- (redistrict74_stats)
redistrict75_vote <- (redistrict75_stats)
redistrict76_vote <- (redistrict76_stats)
redistrict77_vote <- (redistrict77_stats)
redistrict78_vote <- (redistrict78_stats)
redistrict79_vote <- (redistrict79_stats)
redistrict80_vote <- (redistrict80_stats)
redistrict81_vote <- (redistrict81_stats)
redistrict82_vote <- (redistrict82_stats)
redistrict83_vote <- (redistrict83_stats)
redistrict84_vote <- (redistrict84_stats)
redistrict85_vote <- (redistrict85_stats)
redistrict86_vote <- (redistrict86_stats)
redistrict87_vote <- (redistrict87_stats)
redistrict88_vote <- (redistrict88_stats)
redistrict89_vote <- (redistrict89_stats)
redistrict90_vote <- (redistrict90_stats)
redistrict91_vote <- (redistrict91_stats)
redistrict92_vote <- (redistrict92_stats)
redistrict93_vote <- (redistrict93_stats)
redistrict94_vote <- (redistrict94_stats)
redistrict95_vote <- (redistrict95_stats)
redistrict96_vote <- (redistrict96_stats)
redistrict97_vote <- (redistrict97_stats)
redistrict98_vote <- (redistrict98_stats)
redistrict99_vote <- (redistrict99_stats)
redistrict100_vote <- (redistrict100_stats)
redistrict101_vote <- (redistrict101_stats)
redistrict102_vote <- (redistrict102_stats)
redistrict103_vote <- (redistrict103_stats)
redistrict104_vote <- (redistrict104_stats)
redistrict105_vote <- (redistrict105_stats)
redistrict106_vote <- (redistrict106_stats)
redistrict107_vote <- (redistrict107_stats)
redistrict108_vote <- (redistrict108_stats)
redistrict109_vote <- (redistrict109_stats)
redistrict110_vote <- (redistrict110_stats)
redistrict111_vote <- (redistrict111_stats)
redistrict112_vote <- (redistrict112_stats)
redistrict113_vote <- (redistrict113_stats)
redistrict114_vote <- (redistrict114_stats)
redistrict115_vote <- (redistrict115_stats)
redistrict116_vote <- (redistrict116_stats)
redistrict117_vote <- (redistrict117_stats)
redistrict118_vote <- (redistrict118_stats)
redistrict119_vote <- (redistrict119_stats)
redistrict120_vote <- (redistrict120_stats)
redistrict121_vote <- (redistrict121_stats)
redistrict122_vote <- (redistrict122_stats)
redistrict123_vote <- (redistrict123_stats)
redistrict124_vote <- (redistrict124_stats)
redistrict125_vote <- (redistrict125_stats)
redistrict126_vote <- (redistrict126_stats)
redistrict127_vote <- (redistrict127_stats)
redistrict128_vote <- (redistrict128_stats)
redistrict129_vote <- (redistrict129_stats)
redistrict130_vote <- (redistrict130_stats)
redistrict131_vote <- (redistrict131_stats)
redistrict132_vote <- (redistrict132_stats)
redistrict133_vote <- (redistrict133_stats)
redistrict134_vote <- (redistrict134_stats)
redistrict135_vote <- (redistrict135_stats)
redistrict136_vote <- (redistrict136_stats)
redistrict137_vote <- (redistrict137_stats)
redistrict138_vote <- (redistrict138_stats)
redistrict139_vote <- (redistrict139_stats)
redistrict140_vote <- (redistrict140_stats)
redistrict141_vote <- (redistrict141_stats)
redistrict142_vote <- (redistrict142_stats)
redistrict143_vote <- (redistrict143_stats)
redistrict144_vote <- (redistrict144_stats)
redistrict145_vote <- (redistrict145_stats)
redistrict146_vote <- (redistrict146_stats)
redistrict147_vote <- (redistrict147_stats)
redistrict148_vote <- (redistrict148_stats)
redistrict149_vote <- (redistrict149_stats)
redistrict150_vote <- (redistrict150_stats)
redistrict151_vote <- (redistrict151_stats)
redistrict152_vote <- (redistrict152_stats)
redistrict153_vote <- (redistrict153_stats)
redistrict154_vote <- (redistrict154_stats)
redistrict155_vote <- (redistrict155_stats)
redistrict156_vote <- (redistrict156_stats)
redistrict157_vote <- (redistrict157_stats)
redistrict158_vote <- (redistrict158_stats)
redistrict159_vote <- (redistrict159_stats)
redistrict160_vote <- (redistrict160_stats)
redistrict161_vote <- (redistrict161_stats)
redistrict162_vote <- (redistrict162_stats)
redistrict163_vote <- (redistrict163_stats)
redistrict164_vote <- (redistrict164_stats)
redistrict165_vote <- (redistrict165_stats)
redistrict166_vote <- (redistrict166_stats)
redistrict167_vote <- (redistrict167_stats)
redistrict168_vote <- (redistrict168_stats)
redistrict169_vote <- (redistrict169_stats)
redistrict170_vote <- (redistrict170_stats)
redistrict171_vote <- (redistrict171_stats)
redistrict172_vote <- (redistrict172_stats)
redistrict173_vote <- (redistrict173_stats)
redistrict174_vote <- (redistrict174_stats)
redistrict175_vote <- (redistrict175_stats)
redistrict176_vote <- (redistrict176_stats)
redistrict177_vote <- (redistrict177_stats)
redistrict178_vote <- (redistrict178_stats)
redistrict179_vote <- (redistrict179_stats)
redistrict180_vote <- (redistrict180_stats)
redistrict181_vote <- (redistrict181_stats)
redistrict182_vote <- (redistrict182_stats)
redistrict183_vote <- (redistrict183_stats)
redistrict184_vote <- (redistrict184_stats)
redistrict185_vote <- (redistrict185_stats)
redistrict186_vote <- (redistrict186_stats)
redistrict187_vote <- (redistrict187_stats)
redistrict188_vote <- (redistrict188_stats)
redistrict189_vote <- (redistrict189_stats)
redistrict190_vote <- (redistrict190_stats)
redistrict191_vote <- (redistrict191_stats)
redistrict192_vote <- (redistrict192_stats)
redistrict193_vote <- (redistrict193_stats)
redistrict194_vote <- (redistrict194_stats)
redistrict195_vote <- (redistrict195_stats)
redistrict196_vote <- (redistrict196_stats)
redistrict197_vote <- (redistrict197_stats)
redistrict198_vote <- (redistrict198_stats)
redistrict199_vote <- (redistrict199_stats)
redistrict200_vote <- (redistrict200_stats)


vote1_summary <- vote_summary(redistrict1_vote)
vote2_summary <- vote_summary(redistrict2_vote)
vote3_summary <- vote_summary(redistrict3_vote)
vote4_summary <- vote_summary(redistrict4_vote)
vote5_summary <- vote_summary(redistrict5_vote)
vote6_summary <- vote_summary(redistrict6_vote)
vote7_summary <- vote_summary(redistrict7_vote)
vote8_summary <- vote_summary(redistrict8_vote)
vote9_summary <- vote_summary(redistrict9_vote)
vote10_summary <- vote_summary(redistrict10_vote)
vote11_summary <- vote_summary(redistrict11_vote)
vote12_summary <- vote_summary(redistrict12_vote)
vote13_summary <- vote_summary(redistrict13_vote)
vote14_summary <- vote_summary(redistrict14_vote)
vote15_summary <- vote_summary(redistrict15_vote)
vote16_summary <- vote_summary(redistrict16_vote)
vote17_summary <- vote_summary(redistrict17_vote)
vote18_summary <- vote_summary(redistrict18_vote)
vote19_summary <- vote_summary(redistrict19_vote)
vote20_summary <- vote_summary(redistrict20_vote)
vote21_summary <- vote_summary(redistrict21_vote)
vote22_summary <- vote_summary(redistrict22_vote)
vote23_summary <- vote_summary(redistrict23_vote)
vote24_summary <- vote_summary(redistrict24_vote)
vote25_summary <- vote_summary(redistrict25_vote)
vote26_summary <- vote_summary(redistrict26_vote)
vote27_summary <- vote_summary(redistrict27_vote)
vote28_summary <- vote_summary(redistrict28_vote)
vote29_summary <- vote_summary(redistrict29_vote)
vote30_summary <- vote_summary(redistrict30_vote)
vote31_summary <- vote_summary(redistrict31_vote)
vote32_summary <- vote_summary(redistrict32_vote)
vote33_summary <- vote_summary(redistrict33_vote)
vote34_summary <- vote_summary(redistrict34_vote)
vote35_summary <- vote_summary(redistrict35_vote)
vote36_summary <- vote_summary(redistrict36_vote)
vote37_summary <- vote_summary(redistrict37_vote)
vote38_summary <- vote_summary(redistrict38_vote)
vote39_summary <- vote_summary(redistrict39_vote)
vote40_summary <- vote_summary(redistrict40_vote)
vote41_summary <- vote_summary(redistrict41_vote)
vote42_summary <- vote_summary(redistrict42_vote)
vote43_summary <- vote_summary(redistrict43_vote)
vote44_summary <- vote_summary(redistrict44_vote)
vote45_summary <- vote_summary(redistrict45_vote)
vote46_summary <- vote_summary(redistrict46_vote)
vote47_summary <- vote_summary(redistrict47_vote)
vote48_summary <- vote_summary(redistrict48_vote)
vote49_summary <- vote_summary(redistrict49_vote)
vote50_summary <- vote_summary(redistrict50_vote)
vote51_summary <- vote_summary(redistrict51_vote)
vote52_summary <- vote_summary(redistrict52_vote)
vote53_summary <- vote_summary(redistrict53_vote)
vote54_summary <- vote_summary(redistrict54_vote)
vote55_summary <- vote_summary(redistrict55_vote)
vote56_summary <- vote_summary(redistrict56_vote)
vote57_summary <- vote_summary(redistrict57_vote)
vote58_summary <- vote_summary(redistrict58_vote)
vote59_summary <- vote_summary(redistrict59_vote)
vote60_summary <- vote_summary(redistrict60_vote)
vote61_summary <- vote_summary(redistrict61_vote)
vote62_summary <- vote_summary(redistrict62_vote)
vote63_summary <- vote_summary(redistrict63_vote)
vote64_summary <- vote_summary(redistrict64_vote)
vote65_summary <- vote_summary(redistrict65_vote)
vote66_summary <- vote_summary(redistrict66_vote)
vote67_summary <- vote_summary(redistrict67_vote)
vote68_summary <- vote_summary(redistrict68_vote)
vote69_summary <- vote_summary(redistrict69_vote)
vote70_summary <- vote_summary(redistrict70_vote)
vote71_summary <- vote_summary(redistrict71_vote)
vote72_summary <- vote_summary(redistrict72_vote)
vote73_summary <- vote_summary(redistrict73_vote)
vote74_summary <- vote_summary(redistrict74_vote)
vote75_summary <- vote_summary(redistrict75_vote)
vote76_summary <- vote_summary(redistrict76_vote)
vote77_summary <- vote_summary(redistrict77_vote)
vote78_summary <- vote_summary(redistrict78_vote)
vote79_summary <- vote_summary(redistrict79_vote)
vote80_summary <- vote_summary(redistrict80_vote)
vote81_summary <- vote_summary(redistrict81_vote)
vote82_summary <- vote_summary(redistrict82_vote)
vote83_summary <- vote_summary(redistrict83_vote)
vote84_summary <- vote_summary(redistrict84_vote)
vote85_summary <- vote_summary(redistrict85_vote)
vote86_summary <- vote_summary(redistrict86_vote)
vote87_summary <- vote_summary(redistrict87_vote)
vote88_summary <- vote_summary(redistrict88_vote)
vote89_summary <- vote_summary(redistrict89_vote)
vote90_summary <- vote_summary(redistrict90_vote)
vote91_summary <- vote_summary(redistrict91_vote)
vote92_summary <- vote_summary(redistrict92_vote)
vote93_summary <- vote_summary(redistrict93_vote)
vote94_summary <- vote_summary(redistrict94_vote)
vote95_summary <- vote_summary(redistrict95_vote)
vote96_summary <- vote_summary(redistrict96_vote)
vote97_summary <- vote_summary(redistrict97_vote)
vote98_summary <- vote_summary(redistrict98_vote)
vote99_summary <- vote_summary(redistrict99_vote)
vote100_summary <- vote_summary(redistrict100_vote)
vote101_summary <- vote_summary(redistrict101_vote)
vote102_summary <- vote_summary(redistrict102_vote)
vote103_summary <- vote_summary(redistrict103_vote)
vote104_summary <- vote_summary(redistrict104_vote)
vote105_summary <- vote_summary(redistrict105_vote)
vote106_summary <- vote_summary(redistrict106_vote)
vote107_summary <- vote_summary(redistrict107_vote)
vote108_summary <- vote_summary(redistrict108_vote)
vote109_summary <- vote_summary(redistrict109_vote)
vote110_summary <- vote_summary(redistrict110_vote)
vote111_summary <- vote_summary(redistrict111_vote)
vote112_summary <- vote_summary(redistrict112_vote)
vote113_summary <- vote_summary(redistrict113_vote)
vote114_summary <- vote_summary(redistrict114_vote)
vote115_summary <- vote_summary(redistrict115_vote)
vote116_summary <- vote_summary(redistrict116_vote)
vote117_summary <- vote_summary(redistrict117_vote)
vote118_summary <- vote_summary(redistrict118_vote)
vote119_summary <- vote_summary(redistrict119_vote)
vote120_summary <- vote_summary(redistrict120_vote)
vote121_summary <- vote_summary(redistrict121_vote)
vote122_summary <- vote_summary(redistrict122_vote)
vote123_summary <- vote_summary(redistrict123_vote)
vote124_summary <- vote_summary(redistrict124_vote)
vote125_summary <- vote_summary(redistrict125_vote)
vote126_summary <- vote_summary(redistrict126_vote)
vote127_summary <- vote_summary(redistrict127_vote)
vote128_summary <- vote_summary(redistrict128_vote)
vote129_summary <- vote_summary(redistrict129_vote)
vote130_summary <- vote_summary(redistrict130_vote)
vote131_summary <- vote_summary(redistrict131_vote)
vote132_summary <- vote_summary(redistrict132_vote)
vote133_summary <- vote_summary(redistrict133_vote)
vote134_summary <- vote_summary(redistrict134_vote)
vote135_summary <- vote_summary(redistrict135_vote)
vote136_summary <- vote_summary(redistrict136_vote)
vote137_summary <- vote_summary(redistrict137_vote)
vote138_summary <- vote_summary(redistrict138_vote)
vote139_summary <- vote_summary(redistrict139_vote)
vote140_summary <- vote_summary(redistrict140_vote)
vote141_summary <- vote_summary(redistrict141_vote)
vote142_summary <- vote_summary(redistrict142_vote)
vote143_summary <- vote_summary(redistrict143_vote)
vote144_summary <- vote_summary(redistrict144_vote)
vote145_summary <- vote_summary(redistrict145_vote)
vote146_summary <- vote_summary(redistrict146_vote)
vote147_summary <- vote_summary(redistrict147_vote)
vote148_summary <- vote_summary(redistrict148_vote)
vote149_summary <- vote_summary(redistrict149_vote)
vote150_summary <- vote_summary(redistrict150_vote)
vote151_summary <- vote_summary(redistrict151_vote)
vote152_summary <- vote_summary(redistrict152_vote)
vote153_summary <- vote_summary(redistrict153_vote)
vote154_summary <- vote_summary(redistrict154_vote)
vote155_summary <- vote_summary(redistrict155_vote)
vote156_summary <- vote_summary(redistrict156_vote)
vote157_summary <- vote_summary(redistrict157_vote)
vote158_summary <- vote_summary(redistrict158_vote)
vote159_summary <- vote_summary(redistrict159_vote)
vote160_summary <- vote_summary(redistrict160_vote)
vote161_summary <- vote_summary(redistrict161_vote)
vote162_summary <- vote_summary(redistrict162_vote)
vote163_summary <- vote_summary(redistrict163_vote)
vote164_summary <- vote_summary(redistrict164_vote)
vote165_summary <- vote_summary(redistrict165_vote)
vote166_summary <- vote_summary(redistrict166_vote)
vote167_summary <- vote_summary(redistrict167_vote)
vote168_summary <- vote_summary(redistrict168_vote)
vote169_summary <- vote_summary(redistrict169_vote)
vote170_summary <- vote_summary(redistrict170_vote)
vote171_summary <- vote_summary(redistrict171_vote)
vote172_summary <- vote_summary(redistrict172_vote)
vote173_summary <- vote_summary(redistrict173_vote)
vote174_summary <- vote_summary(redistrict174_vote)
vote175_summary <- vote_summary(redistrict175_vote)
vote176_summary <- vote_summary(redistrict176_vote)
vote177_summary <- vote_summary(redistrict177_vote)
vote178_summary <- vote_summary(redistrict178_vote)
vote179_summary <- vote_summary(redistrict179_vote)
vote180_summary <- vote_summary(redistrict180_vote)
vote181_summary <- vote_summary(redistrict181_vote)
vote182_summary <- vote_summary(redistrict182_vote)
vote183_summary <- vote_summary(redistrict183_vote)
vote184_summary <- vote_summary(redistrict184_vote)
vote185_summary <- vote_summary(redistrict185_vote)
vote186_summary <- vote_summary(redistrict186_vote)
vote187_summary <- vote_summary(redistrict187_vote)
vote188_summary <- vote_summary(redistrict188_vote)
vote189_summary <- vote_summary(redistrict189_vote)
vote190_summary <- vote_summary(redistrict190_vote)
vote191_summary <- vote_summary(redistrict191_vote)
vote192_summary <- vote_summary(redistrict192_vote)
vote193_summary <- vote_summary(redistrict193_vote)
vote194_summary <- vote_summary(redistrict194_vote)
vote195_summary <- vote_summary(redistrict195_vote)
vote196_summary <- vote_summary(redistrict196_vote)
vote197_summary <- vote_summary(redistrict197_vote)
vote198_summary <- vote_summary(redistrict198_vote)
vote199_summary <- vote_summary(redistrict199_vote)
vote200_summary <- vote_summary(redistrict200_vote)

district_outcomes <- rbind(
  vote1_summary,
  vote2_summary,
  vote3_summary,
  vote4_summary,
  vote5_summary,
  vote6_summary,
  vote7_summary,
  vote8_summary,
  vote9_summary,
  vote10_summary,
  vote11_summary,
  vote12_summary,
  vote13_summary,
  vote14_summary,
  vote15_summary,
  vote16_summary,
  vote17_summary,
  vote18_summary,
  vote19_summary,
  vote20_summary,
  vote21_summary,
  vote22_summary,
  vote23_summary,
  vote24_summary,
  vote25_summary,
  vote26_summary,
  vote27_summary,
  vote28_summary,
  vote29_summary,
  vote30_summary,
  vote31_summary,
  vote32_summary,
  vote33_summary,
  vote34_summary,
  vote35_summary,
  vote36_summary,
  vote37_summary,
  vote38_summary,
  vote39_summary,
  vote40_summary,
  vote41_summary,
  vote42_summary,
  vote43_summary,
  vote44_summary,
  vote45_summary,
  vote46_summary,
  vote47_summary,
  vote48_summary,
  vote49_summary,
  vote50_summary,
  vote51_summary,
  vote52_summary,
  vote53_summary,
  vote54_summary,
  vote55_summary,
  vote56_summary,
  vote57_summary,
  vote58_summary,
  vote59_summary,
  vote60_summary,
  vote61_summary,
  vote62_summary,
  vote63_summary,
  vote64_summary,
  vote65_summary,
  vote66_summary,
  vote67_summary,
  vote68_summary,
  vote69_summary,
  vote70_summary,
  vote71_summary,
  vote72_summary,
  vote73_summary,
  vote74_summary,
  vote75_summary,
  vote76_summary,
  vote77_summary,
  vote78_summary,
  vote79_summary,
  vote80_summary,
  vote81_summary,
  vote82_summary,
  vote83_summary,
  vote84_summary,
  vote85_summary,
  vote86_summary,
  vote87_summary,
  vote88_summary,
  vote89_summary,
  vote90_summary,
  vote91_summary,
  vote92_summary,
  vote93_summary,
  vote94_summary,
  vote95_summary,
  vote96_summary,
  vote97_summary,
  vote98_summary,
  vote99_summary,
  vote100_summary,
  vote101_summary,
  vote102_summary,
  vote103_summary,
  vote104_summary,
  vote105_summary,
  vote106_summary,
  vote107_summary,
  vote108_summary,
  vote109_summary,
  vote110_summary,
  vote111_summary,
  vote112_summary,
  vote113_summary,
  vote114_summary,
  vote115_summary,
  vote116_summary,
  vote117_summary,
  vote118_summary,
  vote119_summary,
  vote120_summary,
  vote121_summary,
  vote122_summary,
  vote123_summary,
  vote124_summary,
  vote125_summary,
  vote126_summary,
  vote127_summary,
  vote128_summary,
  vote129_summary,
  vote130_summary,
  vote131_summary,
  vote132_summary,
  vote133_summary,
  vote134_summary,
  vote135_summary,
  vote136_summary,
  vote137_summary,
  vote138_summary,
  vote139_summary,
  vote140_summary,
  vote141_summary,
  vote142_summary,
  vote143_summary,
  vote144_summary,
  vote145_summary,
  vote146_summary,
  vote147_summary,
  vote148_summary,
  vote149_summary,
  vote150_summary,
  vote151_summary,
  vote152_summary,
  vote153_summary,
  vote154_summary,
  vote155_summary,
  vote156_summary,
  vote157_summary,
  vote158_summary,
  vote159_summary,
  vote160_summary,
  vote161_summary,
  vote162_summary,
  vote163_summary,
  vote164_summary,
  vote165_summary,
  vote166_summary,
  vote167_summary,
  vote168_summary,
  vote169_summary,
  vote170_summary,
  vote171_summary,
  vote172_summary,
  vote173_summary,
  vote174_summary,
  vote175_summary,
  vote176_summary,
  vote177_summary,
  vote178_summary,
  vote179_summary,
  vote180_summary,
  vote181_summary,
  vote182_summary,
  vote183_summary,
  vote184_summary,
  vote185_summary,
  vote186_summary,
  vote187_summary,
  vote188_summary,
  vote189_summary,
  vote190_summary,
  vote191_summary,
  vote192_summary,
  vote193_summary,
  vote194_summary,
  vote195_summary,
  vote196_summary,
  vote197_summary,
  vote198_summary,
  vote199_summary,
  vote200_summary
)


rd1_plot <- redistrict_plot(redistrict1_stats)
rd2_plot <- redistrict_plot(redistrict2_stats)
rd3_plot <- redistrict_plot(redistrict3_stats)
rd4_plot <- redistrict_plot(redistrict4_stats)
rd5_plot <- redistrict_plot(redistrict5_stats)
rd6_plot <- redistrict_plot(redistrict6_stats)
rd7_plot <- redistrict_plot(redistrict7_stats)
rd8_plot <- redistrict_plot(redistrict8_stats)
rd9_plot <- redistrict_plot(redistrict9_stats)
rd10_plot <- redistrict_plot(redistrict10_stats)
rd11_plot <- redistrict_plot(redistrict11_stats)
rd12_plot <- redistrict_plot(redistrict12_stats)
rd13_plot <- redistrict_plot(redistrict13_stats)
rd14_plot <- redistrict_plot(redistrict14_stats)
rd15_plot <- redistrict_plot(redistrict15_stats)
rd16_plot <- redistrict_plot(redistrict16_stats)
rd17_plot <- redistrict_plot(redistrict17_stats)
rd18_plot <- redistrict_plot(redistrict18_stats)
rd19_plot <- redistrict_plot(redistrict19_stats)
rd20_plot <- redistrict_plot(redistrict20_stats)
rd21_plot <- redistrict_plot(redistrict21_stats)
rd22_plot <- redistrict_plot(redistrict22_stats)
rd23_plot <- redistrict_plot(redistrict23_stats)
rd24_plot <- redistrict_plot(redistrict24_stats)
rd25_plot <- redistrict_plot(redistrict25_stats)
rd26_plot <- redistrict_plot(redistrict26_stats)
rd27_plot <- redistrict_plot(redistrict27_stats)
rd28_plot <- redistrict_plot(redistrict28_stats)
rd29_plot <- redistrict_plot(redistrict29_stats)
rd30_plot <- redistrict_plot(redistrict30_stats)
rd31_plot <- redistrict_plot(redistrict31_stats)
rd32_plot <- redistrict_plot(redistrict32_stats)
rd33_plot <- redistrict_plot(redistrict33_stats)
rd34_plot <- redistrict_plot(redistrict34_stats)
rd35_plot <- redistrict_plot(redistrict35_stats)
rd36_plot <- redistrict_plot(redistrict36_stats)
rd37_plot <- redistrict_plot(redistrict37_stats)
rd38_plot <- redistrict_plot(redistrict38_stats)
rd39_plot <- redistrict_plot(redistrict39_stats)
rd40_plot <- redistrict_plot(redistrict40_stats)
rd41_plot <- redistrict_plot(redistrict41_stats)
rd42_plot <- redistrict_plot(redistrict42_stats)
rd43_plot <- redistrict_plot(redistrict43_stats)
rd44_plot <- redistrict_plot(redistrict44_stats)
rd45_plot <- redistrict_plot(redistrict45_stats)
rd46_plot <- redistrict_plot(redistrict46_stats)
rd47_plot <- redistrict_plot(redistrict47_stats)
rd48_plot <- redistrict_plot(redistrict48_stats)
rd49_plot <- redistrict_plot(redistrict49_stats)
rd50_plot <- redistrict_plot(redistrict50_stats)
rd51_plot <- redistrict_plot(redistrict51_stats)
rd52_plot <- redistrict_plot(redistrict52_stats)
rd53_plot <- redistrict_plot(redistrict53_stats)
rd54_plot <- redistrict_plot(redistrict54_stats)
rd55_plot <- redistrict_plot(redistrict55_stats)
rd56_plot <- redistrict_plot(redistrict56_stats)
rd57_plot <- redistrict_plot(redistrict57_stats)
rd58_plot <- redistrict_plot(redistrict58_stats)
rd59_plot <- redistrict_plot(redistrict59_stats)
rd60_plot <- redistrict_plot(redistrict60_stats)
rd61_plot <- redistrict_plot(redistrict61_stats)
rd62_plot <- redistrict_plot(redistrict62_stats)
rd63_plot <- redistrict_plot(redistrict63_stats)
rd64_plot <- redistrict_plot(redistrict64_stats)
rd65_plot <- redistrict_plot(redistrict65_stats)
rd66_plot <- redistrict_plot(redistrict66_stats)
rd67_plot <- redistrict_plot(redistrict67_stats)
rd68_plot <- redistrict_plot(redistrict68_stats)
rd69_plot <- redistrict_plot(redistrict69_stats)
rd70_plot <- redistrict_plot(redistrict70_stats)
rd71_plot <- redistrict_plot(redistrict71_stats)
rd72_plot <- redistrict_plot(redistrict72_stats)
rd73_plot <- redistrict_plot(redistrict73_stats)
rd74_plot <- redistrict_plot(redistrict74_stats)
rd75_plot <- redistrict_plot(redistrict75_stats)
rd76_plot <- redistrict_plot(redistrict76_stats)
rd77_plot <- redistrict_plot(redistrict77_stats)
rd78_plot <- redistrict_plot(redistrict78_stats)
rd79_plot <- redistrict_plot(redistrict79_stats)
rd80_plot <- redistrict_plot(redistrict80_stats)
rd81_plot <- redistrict_plot(redistrict81_stats)
rd82_plot <- redistrict_plot(redistrict82_stats)
rd83_plot <- redistrict_plot(redistrict83_stats)
rd84_plot <- redistrict_plot(redistrict84_stats)
rd85_plot <- redistrict_plot(redistrict85_stats)
rd86_plot <- redistrict_plot(redistrict86_stats)
rd87_plot <- redistrict_plot(redistrict87_stats)
rd88_plot <- redistrict_plot(redistrict88_stats)
rd89_plot <- redistrict_plot(redistrict89_stats)
rd90_plot <- redistrict_plot(redistrict90_stats)
rd91_plot <- redistrict_plot(redistrict91_stats)
rd92_plot <- redistrict_plot(redistrict92_stats)
rd93_plot <- redistrict_plot(redistrict93_stats)
rd94_plot <- redistrict_plot(redistrict94_stats)
rd95_plot <- redistrict_plot(redistrict95_stats)
rd96_plot <- redistrict_plot(redistrict96_stats)
rd97_plot <- redistrict_plot(redistrict97_stats)
rd98_plot <- redistrict_plot(redistrict98_stats)
rd99_plot <- redistrict_plot(redistrict99_stats)
rd100_plot <- redistrict_plot(redistrict100_stats)
rd101_plot <- redistrict_plot(redistrict101_stats)
rd102_plot <- redistrict_plot(redistrict102_stats)
rd103_plot <- redistrict_plot(redistrict103_stats)
rd104_plot <- redistrict_plot(redistrict104_stats)
rd105_plot <- redistrict_plot(redistrict105_stats)
rd106_plot <- redistrict_plot(redistrict106_stats)
rd107_plot <- redistrict_plot(redistrict107_stats)
rd108_plot <- redistrict_plot(redistrict108_stats)
rd109_plot <- redistrict_plot(redistrict109_stats)
rd110_plot <- redistrict_plot(redistrict110_stats)
rd111_plot <- redistrict_plot(redistrict111_stats)
rd112_plot <- redistrict_plot(redistrict112_stats)
rd113_plot <- redistrict_plot(redistrict113_stats)
rd114_plot <- redistrict_plot(redistrict114_stats)
rd115_plot <- redistrict_plot(redistrict115_stats)
rd116_plot <- redistrict_plot(redistrict116_stats)
rd117_plot <- redistrict_plot(redistrict117_stats)
rd118_plot <- redistrict_plot(redistrict118_stats)
rd119_plot <- redistrict_plot(redistrict119_stats)
rd120_plot <- redistrict_plot(redistrict120_stats)
rd121_plot <- redistrict_plot(redistrict121_stats)
rd122_plot <- redistrict_plot(redistrict122_stats)
rd123_plot <- redistrict_plot(redistrict123_stats)
rd124_plot <- redistrict_plot(redistrict124_stats)
rd125_plot <- redistrict_plot(redistrict125_stats)
rd126_plot <- redistrict_plot(redistrict126_stats)
rd127_plot <- redistrict_plot(redistrict127_stats)
rd128_plot <- redistrict_plot(redistrict128_stats)
rd129_plot <- redistrict_plot(redistrict129_stats)
rd130_plot <- redistrict_plot(redistrict130_stats)
rd131_plot <- redistrict_plot(redistrict131_stats)
rd132_plot <- redistrict_plot(redistrict132_stats)
rd133_plot <- redistrict_plot(redistrict133_stats)
rd134_plot <- redistrict_plot(redistrict134_stats)
rd135_plot <- redistrict_plot(redistrict135_stats)
rd136_plot <- redistrict_plot(redistrict136_stats)
rd137_plot <- redistrict_plot(redistrict137_stats)
rd138_plot <- redistrict_plot(redistrict138_stats)
rd139_plot <- redistrict_plot(redistrict139_stats)
rd140_plot <- redistrict_plot(redistrict140_stats)
rd141_plot <- redistrict_plot(redistrict141_stats)
rd142_plot <- redistrict_plot(redistrict142_stats)
rd143_plot <- redistrict_plot(redistrict143_stats)
rd144_plot <- redistrict_plot(redistrict144_stats)
rd145_plot <- redistrict_plot(redistrict145_stats)
rd146_plot <- redistrict_plot(redistrict146_stats)
rd147_plot <- redistrict_plot(redistrict147_stats)
rd148_plot <- redistrict_plot(redistrict148_stats)
rd149_plot <- redistrict_plot(redistrict149_stats)
rd150_plot <- redistrict_plot(redistrict150_stats)
rd151_plot <- redistrict_plot(redistrict151_stats)
rd152_plot <- redistrict_plot(redistrict152_stats)
rd153_plot <- redistrict_plot(redistrict153_stats)
rd154_plot <- redistrict_plot(redistrict154_stats)
rd155_plot <- redistrict_plot(redistrict155_stats)
rd156_plot <- redistrict_plot(redistrict156_stats)
rd157_plot <- redistrict_plot(redistrict157_stats)
rd158_plot <- redistrict_plot(redistrict158_stats)
rd159_plot <- redistrict_plot(redistrict159_stats)
rd160_plot <- redistrict_plot(redistrict160_stats)
rd161_plot <- redistrict_plot(redistrict161_stats)
rd162_plot <- redistrict_plot(redistrict162_stats)
rd163_plot <- redistrict_plot(redistrict163_stats)
rd164_plot <- redistrict_plot(redistrict164_stats)
rd165_plot <- redistrict_plot(redistrict165_stats)
rd166_plot <- redistrict_plot(redistrict166_stats)
rd167_plot <- redistrict_plot(redistrict167_stats)
rd168_plot <- redistrict_plot(redistrict168_stats)
rd169_plot <- redistrict_plot(redistrict169_stats)
rd170_plot <- redistrict_plot(redistrict170_stats)
rd171_plot <- redistrict_plot(redistrict171_stats)
rd172_plot <- redistrict_plot(redistrict172_stats)
rd173_plot <- redistrict_plot(redistrict173_stats)
rd174_plot <- redistrict_plot(redistrict174_stats)
rd175_plot <- redistrict_plot(redistrict175_stats)
rd176_plot <- redistrict_plot(redistrict176_stats)
rd177_plot <- redistrict_plot(redistrict177_stats)
rd178_plot <- redistrict_plot(redistrict178_stats)
rd179_plot <- redistrict_plot(redistrict179_stats)
rd180_plot <- redistrict_plot(redistrict180_stats)
rd181_plot <- redistrict_plot(redistrict181_stats)
rd182_plot <- redistrict_plot(redistrict182_stats)
rd183_plot <- redistrict_plot(redistrict183_stats)
rd184_plot <- redistrict_plot(redistrict184_stats)
rd185_plot <- redistrict_plot(redistrict185_stats)
rd186_plot <- redistrict_plot(redistrict186_stats)
rd187_plot <- redistrict_plot(redistrict187_stats)
rd188_plot <- redistrict_plot(redistrict188_stats)
rd189_plot <- redistrict_plot(redistrict189_stats)
rd190_plot <- redistrict_plot(redistrict190_stats)
rd191_plot <- redistrict_plot(redistrict191_stats)
rd192_plot <- redistrict_plot(redistrict192_stats)
rd193_plot <- redistrict_plot(redistrict193_stats)
rd194_plot <- redistrict_plot(redistrict194_stats)
rd195_plot <- redistrict_plot(redistrict195_stats)
rd196_plot <- redistrict_plot(redistrict196_stats)
rd197_plot <- redistrict_plot(redistrict197_stats)
rd198_plot <- redistrict_plot(redistrict198_stats)
rd199_plot <- redistrict_plot(redistrict199_stats)
rd200_plot <- redistrict_plot(redistrict200_stats)

subplot(
        rd1_plot,
        rd2_plot,
        rd3_plot,
        rd4_plot,
        rd5_plot,
        rd6_plot,
        rd7_plot,
        rd8_plot,
        rd9_plot,
        rd10_plot,
        rd11_plot,
        rd12_plot,
        rd13_plot,
        rd14_plot,
        rd15_plot,
        rd16_plot,
        rd17_plot,
        rd18_plot,
        rd19_plot,
        rd20_plot,
        rd21_plot,
        rd22_plot,
        rd23_plot,
        rd24_plot,
        rd25_plot,
        rd26_plot,
        rd27_plot,
        rd28_plot,
        rd29_plot,
        rd30_plot,
        rd31_plot,
        rd32_plot,
        rd33_plot,
        rd34_plot,
        rd35_plot,
        rd36_plot,
        rd37_plot,
        rd38_plot,
        rd39_plot,
        rd40_plot,
        rd41_plot,
        rd42_plot,
        rd43_plot,
        rd44_plot,
        rd45_plot,
        rd46_plot,
        rd47_plot,
        rd48_plot,
        rd49_plot,
        rd50_plot,
        rd51_plot,
        rd52_plot,
        rd53_plot,
        rd54_plot,
        rd55_plot,
        rd56_plot,
        rd57_plot,
        rd58_plot,
        rd59_plot,
        rd60_plot,
        rd61_plot,
        rd62_plot,
        rd63_plot,
        rd64_plot,
        rd65_plot,
        rd66_plot,
        rd67_plot,
        rd68_plot,
        rd69_plot,
        rd70_plot,
        rd71_plot,
        rd72_plot,
        rd73_plot,
        rd74_plot,
        rd75_plot,
        rd76_plot,
        rd77_plot,
        rd78_plot,
        rd79_plot,
        rd80_plot,
        rd81_plot,
        rd82_plot,
        rd83_plot,
        rd84_plot,
        rd85_plot,
        rd86_plot,
        rd87_plot,
        rd88_plot,
        rd89_plot,
        rd90_plot,
        rd91_plot,
        rd92_plot,
        rd93_plot,
        rd94_plot,
        rd95_plot,
        rd96_plot,
        rd97_plot,
        rd98_plot,
        rd99_plot,
        rd100_plot,
        rd101_plot,
        rd102_plot,
        rd103_plot,
        rd104_plot,
        rd105_plot,
        rd106_plot,
        rd107_plot,
        rd108_plot,
        rd109_plot,
        rd110_plot,
        rd111_plot,
        rd112_plot,
        rd113_plot,
        rd114_plot,
        rd115_plot,
        rd116_plot,
        rd117_plot,
        rd118_plot,
        rd119_plot,
        rd120_plot,
        rd121_plot,
        rd122_plot,
        rd123_plot,
        rd124_plot,
        rd125_plot,
        rd126_plot,
        rd127_plot,
        rd128_plot,
        rd129_plot,
        rd130_plot,
        rd131_plot,
        rd132_plot,
        rd133_plot,
        rd134_plot,
        rd135_plot,
        rd136_plot,
        rd137_plot,
        rd138_plot,
        rd139_plot,
        rd140_plot,
        rd141_plot,
        rd142_plot,
        rd143_plot,
        rd144_plot,
        rd145_plot,
        rd146_plot,
        rd147_plot,
        rd148_plot,
        rd149_plot,
        rd150_plot,
        rd151_plot,
        rd152_plot,
        rd153_plot,
        rd154_plot,
        rd155_plot,
        rd156_plot,
        rd157_plot,
        rd158_plot,
        rd159_plot,
        rd160_plot,
        rd161_plot,
        rd162_plot,
        rd163_plot,
        rd164_plot,
        rd165_plot,
        rd166_plot,
        rd167_plot,
        rd168_plot,
        rd169_plot,
        rd170_plot,
        rd171_plot,
        rd172_plot,
        rd173_plot,
        rd174_plot,
        rd175_plot,
        rd176_plot,
        rd177_plot,
        rd178_plot,
        rd179_plot,
        rd180_plot,
        rd181_plot,
        rd182_plot,
        rd183_plot,
        rd184_plot,
        rd185_plot,
        rd186_plot,
        rd187_plot,
        rd188_plot,
        rd189_plot,
        rd190_plot,
        rd191_plot,
        rd192_plot,
        rd193_plot,
        rd194_plot,
        rd195_plot,
        rd196_plot,
        rd197_plot,
        rd198_plot,
        rd199_plot,
        rd200_plot, nrows=10)



