#######################
#
#	GROUP: 1 
# TA: Ms. Halima Anavoro Audu
# Code Edits: Yousaf Chaudry
#
#######################

# -------------------------------------------------------------------------------
# 						Overall Notes (read before coding)
# -------------------------------------------------------------------------------
# using data.table for your data management purposes is preferred
# make sure to install and load the data.table package
#
# all analysis should be on an encounter-level (remember that each row represents a hospital encounter)
# the only tasks that include patient-level analysis are tasks 2 and 3
# conducting a patient-level analysis for other tasks are not needed
#
# make sure to add comments (like this line of code!) to your final R code to make it more readable
# do not remove the comments already included in this file
#
# add your code under each of the task
# if a comment line indicates a different group number/letter, you can simply skip it
# each task has a number of points; all points will add up to 100
# see the instructions below for additional details
#
# tasks are graded as following:
# task 1 = 5 points;  task 2 = 10 points; task 3 = 15 points; task 4 = 5 points; task 5 = 10 points; 
# task 6 = 10 points; task 7 = 15 points; task 8 = 15 points; task 9 = 15 points
# -------------------------------------------------------------------------------

# install/load the necessary packages such as data.table
library(data.table)  
library(bit64)

# *****************************************************************
# task (1) [5 points]: read the hospital discharge data (RDS file)
# note: loading this data requires around .7 GB of RAM
# note: loading this file will take some time (around 1 min)
# note: the name of the file = capstone_data.rds
# note: command to use --> readRDS(file = " ... location of the file on your hard drive ...")
file_rds = 'C:/Users/Vector Tau/Documents/PHIT-bowie/Capstone-Final-Project/capstone_data.rds'  # RDS file
capstone_data = readRDS(file_rds) # loading the RDS file

# -------------------------------------------------------------------------------
# 			data dictionary of the capstone dataset
# -------------------------------------------------------------------------------
# pat_id            unique id for each patients ** use this for patient level analysis **
# age               age in years; note age = 0 (newborns)
# sex               1 = female (biological sex); 0 = male; NA = missing
# race              1 = white; 2 = black; 3 = hispanic; 4 = asian; 5 = native american; 6 = other; NA = missing
# ethnicity         0 = not hispanic; 1 = hispanic white; 2 = hispanic black; 3 = hispanic other; 4 = hispanic unspecified
# income_cat        median household income based on zip code: 1 = 0-25 percentile; 2 = 25-50; 3 = 50-75; 4 = 75-100 (highest income)
# insurance         1 = Medicare; 2 = Medicaid; 3 = private; 4 = self-pay; 5 = no charge; 6 = other
# address_rural     patient location urban-rural category: 1 = large metro; 2 = small metro; 3 = micro; 4 = neither metro nor micro
# address_fl        patient location state: 1 = Florida; 0 = not Florida
# address_state     patient location state: two letter abbreviation of state name (e.g., FL = Florida)
# address_county    Census county FIPS code (e.g., 12086 is Miami-Dade county)
# address_zip       zip code (5 digit)
# year              year of discharge (all 2020)
# quarter           quarter of discharge: 1 = first quarter of the year; ...; 4 = fourth quarter of the year
# los               lenght of stay in the hospital (in days)
# died              1 = died; 0 = did not die (dishcarged alive)
# dx_birth          birth diagnosis: 0 = no birth; 1 = born in hospital; 2 = born outside hospital; 3 = unspecific location of birth
# dx_delivery       delivery of a newborn: 0 = not delivery; 1 = delivery
# dx1               diagnosis code (ICD10) in position 1
# dx10              diagnosis code (ICD10) in position 10
# dx_count          count of unique diagnosis at the time of discharge
# cost              total cost of hospitalization in dollars

# additional derived variables already added for the analysis 
# sex_cat			F = female (biological sex); M = male; NA = missing
# race_cat          White = white; Black = black; Hispanic = hispanic; Asian = asian; Native = native american; Other = other; NA = missing
# ethnicity_cat     NotHispanic = not hispanic; Hispanic = hispanic white or hispanic black or hispanic other or hispanic unspecified; NA = missing
# insurance_cat     Medicare = Medicare; Medicaid = Medicaid; Private = private; SelfPay = self-pay; NoCharge = no charge; Other = other
# address_rural_cat MetroLarge = large metro; MetroSmall = small metro; Micro = micro; Rural = neither metro nor micro; NA = missing
# died_cat          Y = died; N = did not die (discharged alive)
# los_log           LOG of length of stay in the hospital (in days)
# cost_log          LOG of total cost of hospitalization in dollars
# -------------------------------------------------------------------------------

# note: make sure to explore the dataset and study the column names
# note: command to use --> colnames()
colnames(capstone_data)

# note: calculate how many rows/encounters (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> nameofyourdata[, .N]
capstone_data[, .N] #2673442

# note: calculate how many unique patients are in the dataset (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> nameofyourdata[, uniqueN(pat_id)]
capstone_data[, uniqueN(pat_id)] #1444771

# *****************************************************************
# task (2) [10 points]: remove all rows that have NA (missing) value for the following variables:
# pat_id, age, sex, race, ethnicity, insurance, address_rural, died, dx_count, los, and cost
# note: make sure to store the data back in the same variable holding the dataset as the cleaned dataset will be used for the rest of the analysis
# note: command to use --> nameofyourdata = nameofyourdata[!is.na(pat_id) & !is.na(...) & !is.na(...) & ...]  (add all conditions; replace ... with appropriate code)
#insert your code here
capstone_data <- capstone_data[!is.na(pat_id) & !is.na(age) & !is.na(sex) 
                     & !is.na(race) & !is.na(ethnicity) & !is.na(insurance) & !is.na(address_rural) & !is.na(died) 
                     & !is.na(dx_count) & !is.na(los) & !is.na(cost)]


# note: calculate how many rows/encounters are left in the dataset (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> you have already done this earlier in the code!
capstone_data[, .N] #2147095

# note: calculate how many unique patients are left in the dataset (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> you have already done this earlier in the code!
capstone_data[, uniqueN(pat_id)] #1412595

# *****************************************************************
# task (3) [15 points]: remove patients not fitting the analysis
# note that each group has a different set of inclusion/exclusion criteria

# remove patients not living in Florida (for all groups)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[address_fl == 1, ]
capstone_data = capstone_data[address_fl == 1, ] 

# note: calculate how many rows/encounters are left in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
capstone_data[, .N] #2083861

# note: calculate how many unique patients are in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
capstone_data[, uniqueN(pat_id)] #1365508

# note: only fill the part that is for your group -- you can simply leave the sections for other groups empty

# Group A: exclude newborns (age == 0), deliveries (dx_delivery == 1), and births (dx_births == 1)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[age > 1 & ... == 0, ] (replace ... with appropriate code)
capstone_data = capstone_data[age > 0 & dx_birth == 0 & dx_delivery == 0, ]

# Group B: exclude children (age < 18)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[age >= ... == 0, ] (replace ... with appropriate code)
#insert your code here (group B)

# Group C: exclude older adults (age >= 65)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[age < ... == 0, ] (replace ... with appropriate code)
#insert your code here (group C)

# Group D: exclude specific insurance types (insurance_cat %in% c('SelfPay', 'NoCharge', 'Other'))
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[!insurance_cat %in% c('SelfPay', ...), ] (replace ... with appropriate code)
#insert your code here (group D)

# note: calculate how many rows/encounters are left in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
capstone_data[, .N] #1916082

# note: calculate how many unique patients are in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
capstone_data[, uniqueN(pat_id)] #1210785

# note: this cleaned dataset includes the population denominator (i.e., total population) used in this study/analysis

# *****************************************************************
# task (4) [5 points]: save your cleaned data as a new RDS file so that you don't need to clean the data every time
# note: you can load this dataset next time you open up this file and continue working on your capstone
# note: recommended name for your file = capstone_data_X.rds (replace X with your group letter/number)
# note: command to use --> saveRDS(nameofyourdata, file = ' ... location of file on your hard drive ...')
file = 'C:/Users/Vector Tau/Documents/PHIT-bowie/Capstone-Final-Project/capstone_data_1.rds'
saveRDS(capstone_data, file) 

# *****************************************************************
# task (5) [10 points]: find the following reportable diseases in the cleaned dataset
# find COVID patients (all groups) -- numerator #1 population (ICD code = U071)
# add a new column named 'covid' in the dataset 
# make covid = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make covid = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group A should find 108,434 encounters/rows with COVID (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: Group B should find 109,871 encounters/rows with COVID (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: Group C should find 49,195 encounters/rows with COVID (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: Group D should find 98,633 encounters/rows with COVID (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have COVID (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code is unique, use this technique in your data.table command to assign the patients: nameofyourdata[dx1 == 'U071' | dx2 == 'U071' | ..., covid := 1] (replace ... with appropriate code)
capstone_data[dx1 == 'U071' | dx2 == 'U071' | dx3 == 'U071' | dx4 == 'U071' | dx5 == 'U071' | dx6 == 'U071' | dx7 == 'U071' | dx8 == 'U071' | dx9 == 'U071' | dx10 == 'U071', covid := 1]
#below command counts results, sorted by covid present or absent
capstone_data[, .N , by = covid] #108434 counted as covid == 1, confirmed by result shown in directions above
capstone_covid_unique = capstone_data[covid == 1, uniqueN(pat_id)] #this command used to isolate population where covid present, and unique patients within that group, found to be 95078
#Prevalence found by dividing the number of (unique) patients found for COVID by the total population: 95078 / 1210785 
# = 0.0785 prevalence for COVID in unique patients


# Group A: find patients with Gonorrhea -- numerator #2 population (ICD code = A54)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group A should find 395 encounters/rows with Gonorrhea (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Gonorrhea (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'A54' | substr(dx2, 1, 3) == 'A54' | ..., dx_reportable := 1] (replace ... with appropriate code)
capstone_data[substr(dx1, 1, 3) == 'A54' | substr(dx2, 1, 3) == 'A54' | substr(dx3, 1, 3) == 'A54' | substr(dx4, 1, 3) == 'A54' | substr(dx5, 1, 3) == 'A54' | substr(dx6, 1, 3) == 'A54' | substr(dx7, 1, 3) == 'A54' | substr(dx8, 1, 3) == 'A54' | substr(dx9, 1, 3) == 'A54' | substr(dx10, 1, 3) == 'A54', dx_reportable := 1]
#as with covid count previously, below command will find number of encounters/rows where ICD code for Gonorrhea was found
capstone_data[, .N , by = dx_reportable] #395 results of ICD code A54
capstone_gonorrhea_unique = capstone_data[dx_reportable == 1, uniqueN(pat_id)] #similar as with covid and line 180 above, used this to find unique patients within gonorrhea population, which was 386
#Prevalence for our reportable disease: 386 / 1210785
# = 3.188e-4 for gonorrhea

# Group B: find patients with Chlamydia infection -- numerator #2 population (ICD code = A56)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group B should find 386 encounters/rows with Chlamydia (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Chlamydia (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'A56' | substr(dx2, 1, 3) == 'A56' | ..., dx_reportable := 1] (replace ... with appropriate code)
#insert your code here (group B)

# Group C: find patients with Syphilis infection -- numerator #2 population (ICD code = A52)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group C should find 362 encounters/rows with Syphilis (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Syphilis (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'A52' | substr(dx2, 1, 3) == 'A52' | ..., dx_reportable := 1] (replace ... with appropriate code)
#insert your code here (group C)

# Group D: find patients with Chickenpox infection -- numerator #2 population (ICD code = B01)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group C should find 235 encounters/rows with Chickenpox (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Chickenpox (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'B01' | substr(dx2, 1, 3) == 'B01' | ..., dx_reportable := 1] (replace ... with appropriate code)
#insert your code here (group D)

# *****************************************************************
# task (6) [10 points]: exploring the large population denominator (not the numerators of covid or the reportable diseases)
# calculate the min, max, mean and median of age across the population
# note: command to use --> summary(nameofyourdata$age)
# recalculate the min, max, mean, median of age but for each race category separately
# note: command to use --> summary(nameofyourdata[race_cat == 'White']$age)
# Group A: mean age of total population should be 62.41
# Group B: mean age of total population should be 60.51
# Group C: mean age of total population should be 43.75
# Group D: mean age of total population should be 61.09
# (these #s are NOT reported on the slides)
summary(capstone_data$age) #mean confirmed as 62.41
# taken from data dictionary for race >> 1 = white; 2 = black; 3 = hispanic; 4 = asian; 5 = native american; 6 = other; NA = missing

summary(capstone_data[race_cat == 'White']$age)
summary(capstone_data[race_cat == 'Black']$age)
summary(capstone_data[race_cat == 'Hispanic']$age) #this command does not display any results, see line 242 below for explanation
summary(capstone_data[race == 3]$age) #alternate method of exploring Hispanic group
summary(capstone_data[race_cat == 'Asian']$age)
summary(capstone_data[race_cat == 'Native American']$age) #this command does not display any results, see line 242 below for explanation
summary(capstone_data[race == 5]$age) #alternate method of exploring Native American group
summary(capstone_data[race_cat == 'Other']$age)

# As confirmed with Star on 07/25/22, discovered that native american and hispanic race_cat already absorbed into 'Other' category 
# simplified to 4 categories instead of 6 labeled, checked using commands below below
capstone_data[, unique(race_cat)] #result of White/Black/Asian/Other
capstone_data[, unique(race)] #race shows all 6 original designations
unique(capstone_data[race_cat == 'Other']$race) #within 'Other' category, consisting of Native American + Hispanic + Other (identified by race as defined in data dict)

# I also ran test comparison by using race instead of race_cat, results were similar
summary(capstone_data[race == '1']$age) #mean of 65.33 years
summary(capstone_data[race_cat == 'White']$age) #mean of 65.33

# below commands to find counts by race 
capstone_data[, .N , by = race]
capstone_data

# [optional] you may explore the same summary statistics for other numerical variables such as dx_count, los, and cost [optional]
summary(capstone_data$dx_count) #summary statistic for dx_count: mean of 15.48 diagnoses
summary(capstone_data$los) #summary statistic for los: mean of 5.45 days
summary(capstone_data$cost) #summary statistic for cost: mean of $87,311, probably skewed by handful of high values

# create a boxplot to show/compare the distribution of age across all racial groups
# note: command to use --> boxplot(age ~ race_cat, data = nameofyourdata)
# (this graph/diagram will be used on slide #11)
boxplot(age ~ race_cat, data = capstone_data)

# create a boxplot to show/compare the distribution of dx_count across all racial groups
# note: command to use --> boxplot(dx_count ~ race_cat, data = nameofyourdata)
boxplot(dx_count ~ race_cat, data = capstone_data)

# create a boxplot to show/compare the distribution of log of los across all racial groups
# note: command to use --> boxplot(los_log ~ race_cat, data = nameofyourdata)
boxplot(los_log ~ race_cat, data = capstone_data)

#boxplot(los ~ race_cat, data = capstone_data) -- for comparison of los vs los_log

# below commands replaces the close to 0 values with actual 0, so that los_log does not create error,
# as advised by Star, this fixed the error that running original boxplot on los_log produced
summary(capstone_data$los_log) #just checking los_log statistics
capstone_data[los_log < .01, los_log := 0] #adjusting the values to = actual 0 --- this command executed before boxplot commands that use los_log

# create a boxplot to show/compare the distribution of log of cost across all racial groups
# note: command to use --> boxplot(cost_log ~ race_cat, data = nameofyourdata)
boxplot(cost_log ~ race_cat, data = capstone_data)

# boxplot(cost ~ race_cat, data = capstone_data) -- also for comparison

# create a histogram to show the distribution of age across all populations
# note: command to use --> hist(nameofyourdata$age)
# (this graph/diagram will NOT be used on slides)
hist(capstone_data$age)

# create a histogram to show the distribution of cost across all populations
# note: command to use --> hist(nameofyourdata$cost)
# (this graph/diagram will be used on slide #12 left)
hist(capstone_data$cost)

# create a histogram to show the distribution of log of cost across all populations
# note: command to use --> hist(nameofyourdata$cost_log)
# (this graph/diagram will be used on slide #12 right)
hist(capstone_data$cost_log)

# explain what happens when cost is converted to log of cost? (discuss skewness during your presentation)
# Answer: The curve becomes much closer to normal distribution, seems to reduce skewness caused by a few really high cost numbers.

# *****************************************************************
# task (7) [15 points]: exploring the numerator populations (covid and the reportable disease population)
# create a boxplot to show/compare the distribution of hospital length of stay (log converted) across covid and non-covid patients
# note: command to use --> boxplot(los_log ~ covid, data = nameofyourdata)
# note: you may get an error -- you can simply ignore it
# (this graph/diagram will be used on slide #13)
boxplot(los_log ~ covid, data = capstone_data)

# recreate the boxplots to show/compare the distribution of cost (log converted) across covid and non-covid patients
# note: command to use --> boxplot(cost_log ~ covid, data = nameofyourdata)
# (this graph/diagram will NOT be used on slides)
boxplot(cost_log ~ covid, data = capstone_data)

# create a boxplot to show/compare the distribution of hospital length of stay (log converted) across your specific reportable disease and patients without the reportable disease
# note: command to use --> boxplot(los_log ~ dx_reportable, data = nameofyourdata)
# note: you may get an error -- you can simply ignore it
# (this graph/diagram will be used on slide #14)
capstone_data[is.na(dx_reportable), dx_reportable := 0] #had to add this for same reason as line 333, dx_reportable NA's need to be expressed as 0's for sake of graphing/boxplot
boxplot(los_log ~ dx_reportable, data = capstone_data)


# *****************************************************************
# task (8) [15 points]: assess if a significant difference exists between the los of patients in the numerator population and non-numerator populations
# conduct a t-test on the los of covid vs. non-covid patients
# note: command to use --> t.test(nameofyourdata[covid == 1]$los, nameofyourdata[covid == 0]$los)
# (find the p-value and mean of each group from these results, and use them on slide #15)
# Initially this test had an error, "not enough 'y' observations", able to resolve because presence of covid was
# defined as "1", so now if covid absent, then need to set explicitly those NA values for covid to 0
# applying similar logic as solution previously found with Star on line 276
capstone_data[is.na(covid), covid := 0]
t.test(capstone_data[covid == 1]$los, capstone_data[covid == 0]$los) 

# below two commands used to check counts of covid, confirmed after update on line 328 that numbers correct
capstone_data[covid == 0, .N] 
capstone_data[covid == 1, .N] 


# conduct a t-test on the los of patients with the reportable disease vs. patients without the reportable disease
# note: command to use --> t.test(nameofyourdata[dx_reportable == 1]$los, nameofyourdata[dx_reportable == 0]$los)
# (find the p-value and mean of each group from these results, and use them on slide #15) --- used on Aim #2
# --- Had to apply update to values, same logic as from line 328 
capstone_data[is.na(dx_reportable), dx_reportable := 0]
t.test(capstone_data[dx_reportable == 1]$los, capstone_data[dx_reportable == 0]$los)

# below commands for checking numbers of dx_reportable, confirming update from line 341
capstone_data[dx_reportable == 0, .N] 
capstone_data[dx_reportable == 1, .N] 


# conduct a t-test on the los of patients with covid vs. patients with the reportable disease
# note: command to use --> t.test(nameofyourdata[covid == 1]$los, nameofyourdata[dx_reportable == 1]$los)
# (find the p-value and mean of each group from these results, and use them on slide #15) -- used on Aim #3
t.test(capstone_data[covid == 1]$los, capstone_data[dx_reportable == 1]$los)

#adding few more  t.test to include for slide 19 reflection for Aim #1
t.test(capstone_data[covid == 1]$dx_count, capstone_data[dx_reportable == 1]$dx_count)
t.test(capstone_data[covid == 1]$los, capstone_data[covid == 0]$los)
t.test(capstone_data[covid == 1]$age, capstone_data[dx_reportable == 1]$age)

# explain what these results mean during your discussion
# ---- ADD EXPLANATION ----- <<<<<<<<<<<<<<<<<<<<<<<<<<<<<< -------------------

# *****************************************************************
# task (9) [15 points]: assess the effect of race categories on hospital length of stay 
# conduct a linear regression on the los of all population denominator
# use the following variables in the regression: race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat
# note: command to use --> summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = nameofyourdata)
# note: this regression will take time to finish!
# (copy and paste the results on slide #16)
# note: pay attention to the "race_catBlack" row in the results as well as the overall p-value of the model
summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = capstone_data))

# conduct a linear regression on the los of all covid patients (numerator #1 population)
# use the following variables in the regression: race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat
# note: command to use --> summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = nameofyourdata[covid == 1])
# (copy and paste the results on slide #17)
# note: pay attention to the "race_catBlack" row in the results as well as the overall p-value of the model
summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = capstone_data[covid == 1]))

# conduct a linear regression on the los of all patients with the reportable disease (numerator #2 population)
# use the following variables in the regression: race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat
# note: command to use --> summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = nameofyourdata[dx_reportable == 1])
# note: Group D -- do not include address_rural_cat in this regression
# (copy and paste the results on slide #18)
# note: pay attention to the "race_catBlack" row in the results as well as the overall p-value of the model
summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = capstone_data[dx_reportable == 1]))

# thanks for your hard work on completing this analysis!
# you should have completed at least 35 lines of code
# feel free to explore the data and conduct additional analysis
