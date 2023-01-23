#######################
#
#	GROUP X (replace X with your group number/letter)
#
#######################

# -------------------------------------------------------------------------------
# 						Overall Notes (read before coding)
# -------------------------------------------------------------------------------
# using data.table for your data management purposes is preferred
# make sure to install and load the data.table package
#
# all analysis should be on an ecounter-level (remember that each row represents a hospital encounter)
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
insert your code here
insert your code here

# *****************************************************************
# task (1) [5 points]: read the hospital discharge data (RDS file)
# note: loading this data requires around .7 GB of RAM
# note: loading this file will take some time (around 1 min)
# note: the name of the file = capstone_data.rds
# note: command to use --> readRDS(file = " ... location of the file on your hard drive ...")
insert your code here

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
insert your code here

# note: calcualte how many rows/encounters (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> nameofyourdata[, .N]
insert your code here

# note: calcualte how many unique patients are in the dataset (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> nameofyourdata[, uniqueN(pat_id)]
insert your code here

# *****************************************************************
# task (2) [10 points]: remove all rows that have NA (missing) value for the following variables:
# pat_id, age, sex, race, ethnicity, insurance, address_rural, died, dx_count, los, and cost
# note: make sure to store the data back in the same variable holding the dataset as the cleaned dataset will be used for the rest of the analysis
# note: command to use --> nameofyourdata = nameofyourdata[!is.na(pat_id) & !is.na(...) & !is.na(...) & ...]  (add all conditions; replace ... with appropriate code)
insert your code here

# note: calcualte how many rows/encounters are left in the dataset (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> you have already done this earlier in the code!
insert your code here

# note: calcualte how many unique patients are left in the dataset (this # will be used on slide #10 under Data Cleaning)
# note: command to use --> you have already done this earlier in the code!
insert your code here

# *****************************************************************
# task (3) [15 points]: remove patients not fitting the analysis
# note that each group has a different set of inclusion/exclusion criteria

# remove patients not living in Florida (for all groups)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[address_fl == 1, ]
insert your code here

# note: calcualte how many rows/encounters are left in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
insert your code here

# note: calcualte how many unique patients are in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
insert your code here

# note: only fill the part that is for your group -- you can simply leave the sections for other groups empty
# Group A: exclude newborns (age == 0), deliveries (dx_delivery == 1), and births (dx_births == 1)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[age > 1 & ... == 0, ] (replace ... with appropriate code)
insert your code here (group A)

# Group B: exclude children (age < 18)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[age >= ... == 0, ] (replace ... with appropriate code)
insert your code here (group B)

# Group C: exclude older adults (age >= 65)
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[age < ... == 0, ] (replace ... with appropriate code)
insert your code here (group C)

# Group D: exclude specific insurance types (insurance_cat %in% c('SelfPay', 'NoCharge', 'Other'))
# note: command to use limit the data table by rows --> nameofyourdata = nameofyourdata[!insurance_cat %in% c('SelfPay', ...), ] (replace ... with appropriate code)
insert your code here (group D)

# note: calcualte how many rows/encounters are left in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
insert your code here

# note: calcualte how many unique patients are in the dataset (this # will be used on slide #10 under Population Selection Exclusion Criteria)
# note: command to use --> you have already done this earlier in the code!
insert your code here

# note: this cleaned dataset includes the population denominator (i.e., total population) used in this study/analysis

# *****************************************************************
# task (4) [5 points]: save your cleaned data as a new RDS file so that you don't need to clean the data every time
# note: you can load this dataset next time you open up this file and continue working on your capstone
# note: recommended name for your file = capstone_data_X.rds (replace X with your group letter/number)
# note: command to use --> saveRDS(nameofyourdata, file = ' ... location of file on your hard drive ...')
insert your code here

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
insert your code here

# Group A: find patients with Gonorrhea -- numerator #2 population (ICD code = A54)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group A should find 395 encounters/rows with Gonorrhea (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Gonorrhea (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'A54' | substr(dx2, 1, 3) == 'A54' | ..., dx_reportable := 1] (replace ... with appropriate code)
insert your code here (group A)

# Group B: find patients with Chlamydia infection -- numerator #2 population (ICD code = A56)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group B should find 386 encounters/rows with Chlamydia (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Chlamydia (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'A56' | substr(dx2, 1, 3) == 'A56' | ..., dx_reportable := 1] (replace ... with appropriate code)
insert your code here (group B)

# Group C: find patients with Syphilis infection -- numerator #2 population (ICD code = A52)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group C should find 362 encounters/rows with Syphilis (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Syphilis (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'A52' | substr(dx2, 1, 3) == 'A52' | ..., dx_reportable := 1] (replace ... with appropriate code)
insert your code here (group C)

# Group D: find patients with Chickenpox infection -- numerator #2 population (ICD code = B01)
# add a new column named 'dx_reportable' in the dataset 
# make dx_reportable = 1 for every encounter/row when any of the Dx codes in that encounter/row has the ICD code
# make dx_reportable = 0 for every encounter/row when none of the Dx codes in that encounter/row has the ICD code
# note: Group C should find 235 encounters/rows with Chickenpox (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# calculate how many unique patients have Chickenpox (this # will be used on slide #10 under Population Selection Inclusion Criteria)
# note: command to use --> as this ICD code has many subcodes, use this technique in your data.table command: nameofyourdata[substr(dx1, 1, 3) == 'B01' | substr(dx2, 1, 3) == 'B01' | ..., dx_reportable := 1] (replace ... with appropriate code)
insert your code here (group D)

# *****************************************************************
# task (6) [10 points]: exploring the large population denominator (not the numerators of covid or the reportable diseases)
# calcualte the min, max, mean and median of age across the population
# note: command to use --> summary(nameofyourdata$age)
# recalcualte the min, max, mean, median of age but for each race category separately
# note: command to use --> summary(nameofyourdata[race_cat == 'White']$age)
# Group A: mean age of total population should be 62.41
# Group B: mean age of total population should be 60.51
# Group C: mean age of total population should be 43.75
# Group D: mean age of total population should be 61.09
# (these #s are NOT reported on the slides)

insert your code here

# [optional] you may explore the same summary statistics for other numerical variables such as dx_count, los, and cost [optional]

# create a boxplot to show/compare the distribution of age across all racial groups
# note: command to use --> boxplot(age ~ race_cat, data = nameofyourdata)
# (this graph/diagram will be used on slide #11)
insert your code here

# create a boxplot to show/compare the distribution of dx_count across all racial groups
# note: command to use --> boxplot(dx_count ~ race_cat, data = nameofyourdata)
insert your code here

# create a boxplot to show/compare the distribution of log of los across all racial groups
# note: command to use --> boxplot(los_log ~ race_cat, data = nameofyourdata)
insert your code here

# create a boxplot to show/compare the distribution of log of cost across all racial groups
# note: command to use --> boxplot(cost_log ~ race_cat, data = nameofyourdata)
insert your code here

# create a histogram to show the distribution of age across all populations
# note: command to use --> hist(nameofyourdata$age)
# (this graph/diagram will NOT be used on slides)
insert your code here

# create a histogram to show the distribution of cost across all populations
# note: command to use --> hist(nameofyourdata$cost)
# (this graph/diagram will be used on slide #12 left)
insert your code here

# create a histogram to show the distribution of log of cost across all populations
# note: command to use --> hist(nameofyourdata$cost_log)
# (this graph/diagram will be used on slide #12 right)
insert your code here

# explain what happens when cost is converted to log of cost? (discuss skewness during your presentation)

# *****************************************************************
# task (7) [15 points]: exploring the numerator populations (covid and the reportable disease population)
# create a boxplot to show/compare the distribution of hospital length of stay (log converted) across covid and non-covid patients
# note: command to use --> boxplot(los_log ~ covid, data = nameofyourdata)
# note: you may get an error -- you can simply ignore it
# (this graph/diagram will be used on slide #13)
insert your code here

# recreate the boxplots to show/compare the distribution of cost (log converted) across covid and non-covid patients
# note: command to use --> boxplot(cost_log ~ covid, data = nameofyourdata)
# (this graph/diagram will NOT be used on slides)
insert your code here

# create a boxplot to show/compare the distribution of hospital length of stay (log converted) across your specific reportable disease and patients without the reportable disease
# note: command to use --> boxplot(los_log ~ dx_reportable, data = nameofyourdata)
# note: you may get an error -- you can simply ignore it
# (this graph/diagram will be used on slide #14)
insert your code here


# *****************************************************************
# task (8) [15 points]: assess if a significant difference exists between the los of patients in the numerator population and non-numerator populations
# conduct a t-test on the los of covid vs. non-covid patients
# note: command to use --> t.test(nameofyourdata[covid == 1]$los, nameofyourdata[covid == 0]$los)
# (find the p-value and mean of each group from these results, and use them on slide #15)
insert your code here

# conduct a t-test on the los of patients with the reportable disease vs. patients without the reportable disease
# note: command to use --> t.test(nameofyourdata[dx_reportable == 1]$los, nameofyourdata[dx_reportable == 0]$los)
# (find the p-value and mean of each group from these results, and use them on slide #15)
insert your code here

# conduct a t-test on the los of patients with covid vs. patients with the reportable disease
# note: command to use --> t.test(nameofyourdata[covid == 1]$los, nameofyourdata[dx_reportable == 1]$los)
# (find the p-value and mean of each group from these results, and use them on slide #15)
insert your code here

# explain what these results mean during your discussion

# *****************************************************************
# task (9) [15 points]: assess the effect of race categories on hospital length of stay 
# conduct a linear regression on the los of all population denominator
# use the following variables in the regression: race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat
# note: command to use --> summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = nameofyourdata)
# note: this regression will take time to finish!
# (copy and paste the results on slide #16)
# note: pay attention to the "race_catBlack" row in the results as well as the overall p-value of the model
insert your code here

# conduct a linear regression on the los of all covid patients (numerator #1 population)
# use the following variables in the regression: race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat
# note: command to use --> summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = nameofyourdata[covid == 1])
# (copy and paste the results on slide #17)
# note: pay attention to the "race_catBlack" row in the results as well as the overall p-value of the model
insert your code here

# conduct a linear regression on the los of all patients with the reportable disease (numerator #2 population)
# use the following variables in the regression: race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat
# note: command to use --> summary(lm(los ~ race_cat + sex_cat + age + dx_count + insurance_cat + address_rural_cat, data = nameofyourdata[dx_reportable == 1])
# note: Group D -- do not include address_rural_cat in this regression
# (copy and paste the results on slide #18)
# note: pay attention to the "race_catBlack" row in the results as well as the overall p-value of the model
insert your code here

# thanks for your hard work on completing this analysis!
# you should have completed at least 35 lines of code
# feel free to explore the data and conduct additional analysis
