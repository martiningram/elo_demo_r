# Quick FiveThirtyEight Elo demo in R

Here's a way to calculate Elo reasonably quickly in R. To see how quick things
run, try the `try_elo.R` script, which runs Elo, first on about 1800 matches,
and then on an artificially large dataset of 90000 matches created by
replicating the smaller dataset 50 times.

You should see it take around 0.15 seconds for the first, and about 1.1 minutes
for the second.

Disclaimer: I wrote this very quickly, and there might be errors in the elo
formulation! Please make sure to have a look through `elo.R`.
