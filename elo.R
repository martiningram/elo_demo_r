k_func <- function(n_matches, numerator = 250, shape = 0.4, addition = 5) {
  return(numerator / ((n_matches + addition)^(shape)))
}

win_prob <- function(elo_a, elo_b) {
  # TODO: double check!
  return(1 / (1 + 10^((elo_b - elo_a) / 400)))

}

lookup_with_default <- function(name, lookup_list, default) {

  if (name %in% names(lookup_list)) {
    lookup_list[[name]]
  } else {
    default
  }

}

elo <- function(winners, losers) {

  elo_ratings <- list()
  times_seen <- list()

  elo_lookup <- function(name) lookup_with_default(name, elo_ratings, 1500.)
  times_played_lookup <- function(name) 
    lookup_with_default(name, times_seen, 0)

  total_matches <- length(winners)

  results <- data.frame(winner_elo = numeric(total_matches), 
                        loser_elo = numeric(total_matches))

  for (i in seq_along(winners)) {

    cur_winner <- winners[i]
    cur_loser <- losers[i]

    winner_elo <- elo_lookup(cur_winner)
    loser_elo <- elo_lookup(cur_loser)

    winner_prob <- win_prob(winner_elo, loser_elo)

    winner_seen <- times_played_lookup(cur_winner)
    loser_seen <- times_played_lookup(cur_loser)

    k_winner <- k_func(winner_seen)
    k_loser <- k_func(loser_seen)

    winner_update <- k_winner * (1 - winner_prob)
    loser_update <- k_loser * (0 - (1 - winner_prob))

    elo_ratings[[cur_winner]] = winner_elo + winner_update
    elo_ratings[[cur_loser]] = loser_elo + loser_update
    times_seen[[cur_winner]] = winner_seen + 1
    times_seen[[cur_loser]] = loser_seen + 1

    results$winner_elo[i] <- winner_elo
    results$loser_elo[i] <- loser_elo

  }

  results <- cbind(results, winner=winners, loser=losers)

  return(results)

}
