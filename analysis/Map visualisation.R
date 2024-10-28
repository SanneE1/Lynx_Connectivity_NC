library(tidyverse)
library(reshape)

setwd("/Users/Z1512834Z/Documents/01_EBD/01_Lynx_explicit_model/lynx_donana/")

df_map <- as.matrix(read.csv("map3.txt", sep = " ", skip = 1, header = FALSE)) %>%
  melt(.) %>%
  mutate(X2 = as.integer(gsub("V", "", X2)))

Females <- as.matrix(read.csv("FemalesMap.csv",header = FALSE)) %>%
  melt(.) %>%
  mutate(X2 = as.integer(gsub("V", "", X2)))

Males <- as.matrix(read.csv("MalesMap.csv",header = FALSE)) %>%
  melt(.) %>%
  mutate(X2 = as.integer(gsub("V", "", X2)))

pop_df <- read.csv("population_data.csv", header = F, col.names = c("Sex", "Age", "Status", "Coor_X", "Coor_Y", 
                                                                    c(rbind(paste0("Territory_X", 1:8), paste0("Territory_Y", 1:8)))))
pop_df <- pop_df[-1,] %>% mutate(across(where(is.character) & !starts_with("Sex"), as.integer))


df_park <- rbind(expand.grid(X2 = c(122:135),
                            X1 = c(85:115)),
                expand.grid(X2 = c(140:147),
                            X1 = c(140:146)),
                expand.grid(X2 = c(135:141),
                            X1 = c(75:82))
) %>%
  mutate(value = "National Park")

df_BH <- rbind(expand.grid(X2 = c(122:135),
                           X1 = c(85:115)),
               expand.grid(X2 = c(140:147),
                           X1 = c(140:146)),
               expand.grid(X2 = c(135:141),
                           X1 = c(75:82)),
                 expand.grid(X2 = c(106:114),
                             X1 = c(89:96)),
                 expand.grid(X2 = c(68:72),
                             X1 = c(53:62))
                 ) %>%
                   mutate(value = "Breeding Habitat")


ggplot() +
  geom_tile(data = df_map, aes(x = X2, y = X1, fill = as.factor(value))) + 
  geom_tile(data = df_BH, aes(x = X2, y = X1, fill = as.factor(value)), fill = "grey", alpha = 0.8) +
  coord_fixed() +
  scale_y_reverse()

ggplot() +
  geom_tile(data = Females, aes(x = X2, y = X1, fill = as.factor(value))) + 
  geom_point(data = pop_df, aes(x = Coor_X, y = Coor_Y), alpha = 0.5) +
  coord_fixed() +
  scale_y_reverse()






