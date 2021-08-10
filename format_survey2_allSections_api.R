library(redcapAPI)
library(dplyr)
library("xlsx")


token <- "85E41BE58D4FA420595D18EDDA0ECDDB"
url <- "https://redcap.rti.org/creid/api/"

#### functions ####

format.redcap <- function(df) {
  #light formatting
  x <- df
  # remove empty lines
  x <- x[!is.na(x$`Repeat Instance`),]
  # remove test lines
  x <- x[!x$`Record ID` %in% c(11:14),]
  # remove lines with no research site/partner name
  x <- x[!is.na(x$`CREID Research Site/Partner Name`),]
  # add RC name column
  colnames(center.code.tab)[3] <- "Record ID"
  x <- merge(x,center.code.tab,by="Record ID")
  # make the row name Research Center:Research Site
  rownames(x) <- paste0(x$Center.name,":",x$`CREID Research Site/Partner Name`)
  # remove some columns
  x <- x[,!(names(x) %in% c("Record ID","Repeat Instrument","Repeat Instance"))] #df = mydata[,!(names(mydata) %in% drop)]
  # lst three columns to the left
  #x<-x[,c(1192,1193,1194,1:1191)]
  last_col <- dim(x)[2]
  x<-x[,c(last_col-2,last_col-1,last_col,1:(last_col-3))]
  
  return(x)
}


extract.from.redcap <- function(report_id) {
  formData <- list("token"=token,
                   content='report',
                   format='csv',
                   report_id=report_id, #section 3 Lab Facilities & Assay
                   csvDelimiter=',',
                   rawOrLabel='label',
                   rawOrLabelHeaders='label',
                   exportCheckboxLabel='false',
                   returnFormat='csv'
  )
  response <- httr::POST(url, body = formData, encode = "form")
  result <- httr::content(response)
  print(result)
  df <- as.data.frame(result)
  return(df)
}
#### Section 2 - 


#### Section 3 - Lab Facilities & Assays
df <- extract.from.redcap(11)
res.lab <- format.redcap(df)



#### Section 4 - Biorepository Facilities, Samples and Regulations ####
suppressWarnings(df <- extract.from.redcap(12))
res.bio <- format.redcap(df)



#### Section 5 - Capacity ####
suppressWarnings(df <- extract.from.redcap(13))
res.cap <- format.redcap(df)


#### Section 6 - Outbreak Research Response ####
suppressWarnings(df <- extract.from.redcap(14))
res.orr <- format.redcap(df)




#### write excel output ####
write.xlsx(res.lab, file="processed_results/survey2_AllSec_horizontal.xlsx", sheetName = "LabFacAssay", 
           col.names = TRUE, row.names = FALSE, append = FALSE)
write.xlsx(res.bio, file="processed_results/survey2_AllSec_horizontal.xlsx", sheetName = "BioRepository", 
           col.names = TRUE, row.names = FALSE, append = TRUE)
write.xlsx(res.cap, file="processed_results/survey2_AllSec_horizontal.xlsx", sheetName = "CapacityBuilding", 
           col.names = TRUE, row.names = FALSE, append = TRUE)
write.xlsx(res.orr, file="processed_results/survey2_AllSec_horizontal.xlsx", sheetName = "OutbreakResponse", 
           col.names = TRUE, row.names = FALSE, append = TRUE)


write.xlsx(t(res.lab), file="processed_results/survey2_AllSec_vertical.xlsx", sheetName = "LabFacAssay", 
           col.names = TRUE, row.names = FALSE, append = FALSE)
write.xlsx(t(res.bio), file="processed_results/survey2_AllSec_vertical.xlsx", sheetName = "BioRepository", 
           col.names = TRUE, row.names = FALSE, append = TRUE)
write.xlsx(t(res.cap), file="processed_results/survey2_AllSec_vertical.xlsx", sheetName = "CapacityBuilding", 
           col.names = TRUE, row.names = FALSE, append = TRUE)
write.xlsx(t(res.orr), file="processed_results/survey2_AllSec_vertical.xlsx", sheetName = "OutbreakResponse", 
           col.names = TRUE, row.names = FALSE, append = TRUE)











#################


# setwd("C:/Users/eearley/Documents/Nathan_Vandergrift/CREID/survey2/")
# output.folder <- "C:/Users/eearley/Documents/Nathan_Vandergrift/CREID/survey2/processed_results/"
# output.file <- "Survey2_LabFacilities_15June2021.txt"
# 
# #### functions ####
# source("R scripts/survey2_functions.R")
# 
# 
# #### Input data ####
# 
# source("R scripts/input_data_survey2.R")
# 
# section <- "Lab Facilities & Lab Assays - Section 3"
# 
# 
# 
# x<-t(df)
# names(x)
# 



# scratch





