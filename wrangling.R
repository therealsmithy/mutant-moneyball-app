# Read in the data
#appearances <- read.csv('G:/My Drive/R Projects/mutant-moneyball-app/data/MutantMoneyballAppearanceData.csv')
#open <- read.csv('G:/My Drive/R Projects/mutant-moneyball-app/data/MutantMoneyballOpenData.csv')

# Check the data out
str(appearances)
str(open)

# Data wrangling
library(dplyr)
library(tidyr)
library(forcats)
library(tools)

charactercounts <- data.frame(row.names = colnames(appearances[, 3:28]))

for(i in 1:nrow(charactercounts)){
  character_name <- rownames(charactercounts)[i]
  charactercounts$numIssues[i] <- sum(appearances[[character_name]])
}

charactercounts <- data.frame(
  character_name = rownames(charactercounts),
  numIssues = charactercounts$numIssues
)

top10appearances <- charactercounts %>% 
                      arrange((numIssues)) %>% 
                      mutate(character_name = fct_inorder(character_name)) %>% 
                      top_n(10) %>% 
                      mutate(color_code = c('#17588e', '#c52e25', '#62d0e8',
                                            '#474272', '#9db547', '#e5cf45',
                                            '#dad7d0', '#6495b7', '#f0f4f4', 
                                            '#edd877'))

open <- open %>% 
          mutate(Alias = c('Angel', 'Beast', 'Cyclops', 
                           'Iceman', 'Phoenix', 'Havok', 
                           'Polaris', 'Storm', 'Nightcrawler', 
                           'Wolverine', 'Colossus', 'Banshee', 
                           'Sunfire', 'Thunderbird', 'Shadowcat', 
                           'Rogue', 'Askani', 'Eric Magnus', 
                           'Dazzler', 'Longshot', 'Forge', 
                           'Gambit', 'Jubilee', 'Red Bishop', 
                           'Captain Britain', 'Professor X')) %>% 
          relocate(Alias, Member = Member)

# Add a space to names
open$Member <- gsub('([a-z])([A-Z])', '\\1 \\2', open$Member)
# And capitalize them
open$Member <- toTitleCase(open$Member)
# Fix names
open$Member <- gsub('Hank Mc Coy', 'Hank McCoy', open$Member)
open$Member <- gsub('Anna Marie Le Beau', 'Anna Marie LeBeau', open$Member)
open$Member <- gsub('Remy Le Beau', 'Remy LeBeau', open$Member)

# Convert columns 23 through 46 to numeric in open after cleaning them
open[, 23:46] <- lapply(open[, 23:46], function(x) as.numeric(gsub('[^0-9]', '', x)))

# Exploratory Vizzes
library(ggplot2)
library(ggdark)
ggplot(open) +
  geom_point(aes(x = TotalIssues, y = TotalValue_heritage)) +
  dark_theme_classic()

ggplot(top10appearances, aes(x = numIssues, y = character_name, fill = color_code)) +
  geom_bar(stat = 'identity') +
  labs(x = 'Number of Issues', y = 'Mutant Name', title = 'Character Issues Count',
       subtitle = 'Which characters appear in the most issues?') +
  scale_fill_identity() +
  dark_theme_classic()

# Save for use in other files
#saveRDS(open, 'G:/My Drive/R Projects/mutant-moneyball-app/data/open.rds')
#saveRDS(charactercounts, 'G:/My Drive/R Projects/mutant-moneyball-app/data/charactercounts.rds')
