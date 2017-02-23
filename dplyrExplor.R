setwd("C:\\Users\\ankit.talele\\Desktop\\Git_Demo")
dat <- read.csv("Smart_Recrut.csv",stringsAsFactors = T)
View(dat)
library(dplyr)
head(dat)
str(dat)
filter(dat, Applicant_City_PIN == 844120, Manager_Current_Designation == "Level 2")
na.omit(dat[(data$Applicant_City_PIN == 844120 & data$Manager_Current_Designation == "Level 2"),])
filter(dat, Applicant_City_PIN == 844120 & Manager_Current_Designation == "Level 2")
slice(dat, 1:10)
View(arrange(dat,Applicant_Qualification,Applicant_Occupation))
select(dat,Manager_Business:Business_Sourced)
### Select all column starts with "XYZ"
select(dat,starts_with("Applicant"))
select(dat,ends_with("der"))
select(dat,contains("_"))
head(select(dat,matches("(Date|City)")))
colo <- c("Application_Receipt_Date","Applicant_City_PIN")
select(dat, one_of(colo))

colnames(dat) <- sprintf("column%d", 1:23)
head(select(dat, num_range("column",1:10)))

colnames(dat) <- sprintf("column%02d",1:23)
head(select(dat, num_range("column", 1:11, width=2)))
select_(dat,"Applicant_City_PIN")
as <- distinct(dat, Manager_Status)
as$Manager_Status
str(dat)
dat$Applicant_BirthDate <- as.Date(dat$Applicant_BirthDate,"%m/%d/%Y")
dat$dobday <- format(dat$Applicant_BirthDate,"%d")
dat$dobmonth <- format(dat$Applicant_BirthDate,"%m")
dat$dobyear <- format(dat$Applicant_BirthDate,"%Y")

mutate(dat,
       Applicant_Age_days = (Sys.Date()-Applicant_BirthDate),
       Applicant_Age_Years = Applicant_Age_days/365
       )

transmute(dat,
          Applicant_Age_days = (Sys.Date()-Applicant_BirthDate),
          Applicant_Age_Years = Applicant_Age_days/365
)

summarise(dat,
          product_count= mean(Manager_Num_Products2, na.rm = T))

sample_n(dat,20)
sample_frac(dat,0.001)

grp <-group_by(dat, Applicant_Qualification)
View(grp)
aas <- summarise(grp,
                count= n(),
                avg_Business = mean(Manager_Business, na.rm = T))

filter(dat, Applicant_Qualification=="Certified Associateship of Indian Institute of Bankers")
daywise <- group_by(dat,dobyear,dobmonth,dobday )
daybasedbirths <- summarise(daywise, dat =n()) 
monthbasedbirths <- summarise(daybasedbirths, dat = sum(dat))
yearbasedbirths <- summarise(monthbasedbirths, dat = sum(dat))

