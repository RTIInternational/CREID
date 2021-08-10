library(redcapAPI)
#!/usr/bin/env Rscript
token <- "206E103F0DBDCECB4C975CCE8D001FFC"
url <- "https://redcapedc.rti.org/creid/api/"
formData <- list("token"=token,
                 content='report',
                 format='csv',
                 report_id='5',
                  #1 = participant #2 = Definitions #3 = Research Site
                  #4 = Partners #5 = 
                 csvDelimiter='',
                 rawOrLabel='label',
                 rawOrLabelHeaders='label',
                 exportCheckboxLabel='false',
                 returnFormat='json'
)
response <- httr::POST(url, body = formData, encode = "form")
rm(participant_api)
participant_api <- httr::content(response)
view(participant_api)


participant_colnames <- tibble(x = 1:16, y = c(
  "record_id", "redcap_repeat_instrument", "redcap_repeat_instance", "creid_today", "name_first", 
  "name_last", "user_email", "user_title", "user_title_oth", "center_title",
  "creid1_siteadd", "creid1_sitecity" , "state_region", "creid1_sitecntry", "creid1_sitezip",
  "creid_10_20_complete"))

research_site_colnames <- tibble(x = 1:22, y = c(
  "record_id", "redcap_repeat_instrument", "redcap_repeat_instance", "site_name", "creid326_siteadd",                                
  "creid326_sitecity", "creid326_sitergn",  "creid326_sitecntry",  "creid326_sitezip",  "site_pi",                       
  "site_capabilities", "site_capabilities_oth",  "site_focus", "site_role",                     
  "site_staff", "site_creidpartner", "site_biosample", "handle_probs_desc" , "site_sample_storage",                        
  "site_partner" ,  "rs_sample_storage", "creid_32_research_site_information_complete"))                       

partner_colnames <- tibble(x = 1:15, y = c(                             
  "record_id","redcap_repeat_instrument" ,"redcap_repeat_instance" ,"partner_name", "creid329_siteadd",                          
  "creid329_sitecity", "creid329_sitergn", "creid329_sitecntry", "creid329_sitezip",  "partner_poc",
  "partner_capabilities" ,  "partner_capabilities_oth", "partner_focus",  "partner_role","creid_32_partner_information_complete"))                                               


collaborators_colnames <- tibble(x = 1:41, y = c( 
  "record_id", "redcap_repeat_instrument", "redcap_repeat_instance", "collab_name" ,  "creid325_sitename",                                   
  "creid325_siteadd",   "creid325_sitecity" , "creid325_sitecntry",   "creid325_sitergn" , "creid325_sitezip" ,                            
  "collab_poc", "collab_capabilities",    "collab_capabilities_oth", "collab_focus", "collab_role" ,                           
  "collab_agreemnt",  "collab_new", "collab_name_1" , "collab_nature_1", "collab_name_2" ,                               
  "collab_nature_2","collab_name_3" , "collab_nature_3", "collab_name_4" , "collab_nature_4",
  "collab_name_5" , "collab_nature_5", "collab_name_6" ,   "collab_nature_6",  "collab_name_7",                              
  "collab_nature_7" , "collab_name_8",   "collab_nature_8", "collab_nature_9",  "collab_name_9",                                   
  "collab_name_10" ,   "collab_nature_10", "collab_new_center",  "collab_new_center_list" , "collab_new_center_desc",
  "creid_32_other_collaborator_information_complete"))