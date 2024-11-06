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

# Make it so PPI60s_heritage, PPI70s_heritage, PPI80s_heritage, PPI90s_heritage can be graphed as a time series
library(dplyr)
library(tidyr)
ppiheritage <- open %>% 
                 pivot_longer(cols = c(PPI60s_heritage, PPI70s_heritage, PPI80s_heritage, PPI90s_heritage),
                           names_to = 'Decade', values_to = 'TotalValue_Heritage') %>% 
                 mutate(Decade = gsub('PPI', '', Decade)) %>% 
                 mutate(Decade = gsub('s_heritage', '', Decade)) %>% 
                 select(Member, Alias, Decade, TotalValue_Heritage)

# Do that for the other three PPI types
ppiebay <- open %>% 
            pivot_longer(cols = c(PPI60s_ebay, PPI70s_ebay, PPI80s_ebay, PPI90s_ebay),
                      names_to = 'Decade', values_to = 'TotalValue_eBay') %>% 
            mutate(Decade = gsub('PPI', '', Decade)) %>% 
            mutate(Decade = gsub('s_ebay', '', Decade)) %>% 
            select(Member, Alias, Decade, TotalValue_eBay)

ppiwiz <- open %>%
           pivot_longer(cols = c(PPI60s_wiz, PPI70s_wiz, PPI80s_wiz, PPI90s_wiz),
                     names_to = 'Decade', values_to = 'TotalValue_Wiz') %>% 
           mutate(Decade = gsub('PPI', '', Decade)) %>% 
           mutate(Decade = gsub('s_wiz', '', Decade)) %>% 
           select(Member, Alias, Decade, TotalValue_Wiz)

ppiostreet <- open %>% 
               pivot_longer(cols = c(PPI60s_oStreet, PPI70s_oStreet, PPI80s_oStreet, PPI90s_oStreet),
                         names_to = 'Decade', values_to = 'TotalValue_oStreet') %>% 
               mutate(Decade = gsub('PPI', '', Decade)) %>% 
               mutate(Decade = gsub('s_oStreet', '', Decade)) %>% 
               select(Member, Alias, Decade, TotalValue_oStreet)


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
#saveRDS(ppiebay, 'G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiebay.rds')
#saveRDS(ppiheritage, 'G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiheritage.rds')
#saveRDS(ppiwiz, 'G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiwiz.rds')
#saveRDS(ppiostreet, 'G:/My Drive/R Projects/mutant-moneyball-app/mutant-moneyball-app/data/ppiostreet.rds')
