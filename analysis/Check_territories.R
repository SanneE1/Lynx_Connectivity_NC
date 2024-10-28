library(tidyverse)

pop_df <- read.csv("lynx_donana/population_data.csv", header = F, col.names = c("Sex", "Age", "Status", "Coor_X", "Coor_Y", 
                                                                    c(rbind(paste0("Territory_X", 1:8), paste0("Territory_Y", 1:8)))))
pop_df <- pop_df[-1,] %>% mutate(across(where(is.character) & !starts_with("Sex"), as.integer))


df_long <- lapply(list(pop_df[,1:7], pop_df[,c(1:5,8,9)], pop_df[,c(1:5,10,11)], pop_df[,c(1:5,12,13)], 
                 pop_df[,c(1:5,14,15)], pop_df[,c(1:5,16, 17)], pop_df[,c(1:5,18,19)], pop_df[,c(1:5,20,21)]), 
                 function(x) {
                   colnames(x) <- gsub("_X\\d", replacement = "X", colnames(x))
                   colnames(x) <- gsub("_Y\\d", replacement = "Y", colnames(x))
                   return(x)}) %>% bind_rows() %>% filter(TerritoryX != -1)


overlaps <- df_long %>%
  group_by(TerritoryX, TerritoryY, Sex) %>%
  summarise(n = n()) %>%
  filter(n > 1)




