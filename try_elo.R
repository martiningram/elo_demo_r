source('elo.R')


small_df <- read.csv('./all_2017.csv', stringsAsFactors = FALSE)

n <- 50

# Artificially make it larger to test
huge_df <- do.call("rbind", replicate(n, small_df, simplify = FALSE))

for (cur_df in list(small_df, huge_df)) {

  winners <- cur_df[, 'winner']
  losers <- cur_df[, 'loser']

  print(paste('Number of matches is:', nrow(cur_df)))
  print('Calculating elo ratings...')

  start_time <- Sys.time()
  ratings <- elo(winners, losers)
  end_time <- Sys.time()

  print('Done. Time taken:')
  print(end_time - start_time)

}
