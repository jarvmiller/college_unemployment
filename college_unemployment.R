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
