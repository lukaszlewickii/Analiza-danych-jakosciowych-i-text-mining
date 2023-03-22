#### Zadanie 2.

sent1 <- "ala ma kota i bardzo rzadko spaceruje kot szaleje wieczorem"
sent2 <- "ala ma psa i bardzo często spaceruje wieczorem"

term1 <- unlist(stringr::str_split(sent1, " "))
term2 <- unlist(stringr::str_split(sent2, " "))

term1
term2

#termy <- c(term1, term2)
#unique(termy)

union(term1, term2)
