### Integrating new LSP data into analysis
### This is a request from Johanna and Erich
### Casey extracted the data.

library(dplyr)

### Data prep for new analysis:
#  I changed the status years for the LSP goal in eez20__/conf/goals.csv
# The final year is 2015

# This can be seen here:
read.csv('eez2014/conf/goals.csv') %>%
  filter(goal == "LSP") %>%
  select(preindex_function)

read.csv('eez2013/conf/goals.csv') %>%
  filter(goal == "LSP") %>%
  select(preindex_function)

read.csv('eez2012/conf/goals.csv') %>%
  filter(goal == "LSP") %>%
  select(preindex_function)

## Also updated the layers data to call the new Gabon layers that are created below


# new offshore data:
new_offshore <- read.csv("GabonData/data/lsp_prot_area_offshore3nm_Gabon.csv")
new_inland <- read.csv("GabonData/data/lsp_prot_area_inland1km_Gabon.csv")

### Replacing Gabon data in eez20__/layers files with new Gabon data (rgn_id = 198)
scenarios <- c("eez2012", "eez2013", "eez2014")

for(scenario in scenarios){
offshore <- read.csv(file.path(scenario, "layers/lsp_prot_area_offshore3nm.csv")) %>%
  filter(rgn_id != '198') %>%
  rbind(new_offshore)
write.csv(offshore, file.path(scenario, "layers/lsp_prot_area_offshore3nm_withGabon.csv"), row.names=FALSE)

inland <- read.csv(file.path(scenario, "layers/lsp_prot_area_inland1km.csv")) %>%
  filter(rgn_id != '198') %>%
  rbind(new_inland)
write.csv(inland, file.path(scenario, "layers/lsp_prot_area_inland1km_withGabon.csv"), row.names=FALSE)
}