library(tidyverse)
library(forcats)
library(scales)
data <- read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2018-10-16/recent-grads.csv')

# lets look at majors and major categories by amount earned

data %>%
  mutate(Major_category=fct_reorder(Major_category, Median)) %>%
  ggplot(aes(x=Major_category, y=Median)) +
  geom_boxplot() +
  scale_y_continuous(labels = dollar_format()) + 
  coord_flip()
  
# lets look at the top n majors (salary wise)

data %>%
  arrange(desc(Median)) %>%
  head(20) %>%
  mutate(Major=fct_reorder(Major, Median)) %>%
  ggplot(aes(x=Major, y=Median, color=Major_category)) +
  geom_point() +
  geom_errorbar(aes(ymin=P25th, ymax=P75th)) +
  scale_y_continuous(labels = dollar_format()) + 
  coord_flip() +
  theme_bw()

# lets look at which majors have high or low perc women
data %>%
  na.omit(ShareWomen) %>%
  mutate(Major_category=fct_reorder(Major_category, ShareWomen)) %>% 
  ggplot(aes(x=Major_category, y=ShareWomen)) +
  geom_boxplot() +
  coord_flip()

# perc women by salary

data %>%
  ggplot(aes(ShareWomen, Median)) +
  geom_point() +
  geom_smooth() +
  scale_y_continuous(labels=dollar_format())
