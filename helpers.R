
## function to obtain twitter wordcloud

## tweet <- 'machine learning'

t.wordcloud <- function(tweet, obs, since, until){
  t.tweets <- searchTwitter(tweet, n = obs, lang = "en", 
                            since = since, until = until,
                            cainfo = "cacert.pem")
  
  if (length(t.tweets) < 50){
    
  } else {
    
    t.text <- sapply(t.tweets, function(x) x$getText())
    
    # create a corpus
    t.corpus <- Corpus(VectorSource(t.text))
    
    t.corpus <- tm_map(t.corpus, function(x) iconv(enc2utf8(x), sub = "byte"))
    
    # create document term matrix applying some transformations
    tdm <- TermDocumentMatrix(t.corpus,
                              control = list(removePunctuation = TRUE,
                                             stopwords = c(stopwords("english"), 
                                                           tweet, 
                                                           unlist(strsplit(tweet, " ")),
                                                           gsub(" ","", tweet)),
                                             removeNumbers = TRUE, 
                                             tolower = TRUE))
    
    # define tdm as matrix
    m <- as.matrix(tdm)
    
    # get word counts in decreasing order
    word_freqs <- sort(rowSums(m), decreasing=TRUE) 
    
    # create a data frame with words and their frequencies
    dm <- data.frame(word = names(word_freqs), freq = word_freqs)
    
    # plot wordcloud
    wordcloud(dm$word, dm$freq, min.freq = 3, max.words = 500,
              random.order = FALSE, colors = brewer.pal(6, "Dark2")) 
    
  }
}
