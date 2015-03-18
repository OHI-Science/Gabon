# transfer global scenarios out of ohicore
# TODO: create true regions_gcs.js for Antarctica & High Seas
#       eez2014 reshape input data problem once in pressures, many in resilience: Aggregation function missing: defaulting to length

setwd("C:/Users/Melanie/Github/Gabon")
library(stringr)
summarise = summarize = dplyr::summarise
# merge_scores.R line 34: getting error "Error in match(x, table, nomatch = 0L) : object 'dimension' not found"
#     was summarizing to a single score b/c using plyr::summarize

# check to see if following also works on Mac:
source('../ohiprep/src/R/common.R')

# new paths based on host machine
dirs = list(
  neptune_data  = dir_neptune_data, 
  neptune_local = dir_neptune_local,
  ohiprep       = '../ohiprep',
  ohicore       = '../ohicore')

# load ohicore 
devtools::load_all('../ohicore')

scenarios <- c("eez2012", "eez2013", "eez2014")

for(scenario in scenarios){
  #scenario <- 'eez2014'

    # load conf
    conf   = Conf(sprintf('%s/conf', scenario))
    
    # run checks on layers
    CheckLayers(layers.csv = sprintf('%s/layers.csv', scenario), 
                layers.dir = sprintf('%s/layers', scenario), 
                flds_id    = conf$config$layers_id_fields)
    # system(sprintf('open %s/layers.csv', scenario))
    
    # calculate scores from directory of scenario
    setwd(sprintf('%s', scenario)) # load_all(dirs$ohicore)
    
    # load configuration and layers
    conf   = Conf('conf')
    layers = Layers('layers.csv','layers')
    
    # calculate scores
    #try({    })
    scores = CalculateAll(conf, layers, debug=T)
    write.csv(scores, 'scores.csv', na='', row.names=F)
    
    # restore working directory
    setwd('..') 
    
  }
