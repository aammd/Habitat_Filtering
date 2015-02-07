## look at results.


adonisValueExtract <- function(dat, RESP) dat[["aov.tab"]]["species",RESP]


extractResp <- function(RESP = "R2") {
  function(adonisanswers) {
    lapply(adonisanswers, CommunityAdonis, testclass = "adonis", 
           function(x) adonisValueExtract(x, RESP))
  }
}
