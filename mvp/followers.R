# [NFT Analyzer V1 MVP] Follower Count #11
# https://github.com/charliedao-eth/NFT_Analyzer/issues/11

# import packages
library(dplyr)
library(ggplot2)
library(reshape)

# set path
filePath <- "~/repos/github/NFT_Analyzer/mvp/Ethermorelore/"

# import data
rawFollowers <- read.csv(paste0(filePath, "raw_followers_2021-10-25.csv"))
followerHistory <- read.csv(paste0(filePath, "follower_count_history_2021-10-27.csv"))

# helper function
normalize <- function(colVector) {
  df <- as.data.frame(colVector)
  colnames(df) <- 'col'
  
  minValue <- min(df)
  maxValue <- max(df)
  normalizedDf <- df %>%
    mutate(col = round((col- minValue)/(maxValue-minValue),2))

  return(normalizedDf)
}

fillMissingDates <- function(dataframe) {
  df = as.data.frame(dataframe)
  
  date = seq(min(df$date), max(df$date), by="days")
  dateRangeDf <- as.data.frame(date)
  
  filledDatesDf <- dateRangeDf %>%
    left_join(., df, by='date') %>%
    replace(is.na(.), 0)
  
  return(filledDatesDf)
}

replaceMissingValuesWithLast <- function(dataframe) {
  df = as.data.frame(dataframe)
  start <- min(df$date)
  end   <- max(df$date)
  finalDf <- as.data.frame(df['date'])
  
  for (col in colnames(df)[colnames(df) != "date"]) {
    date <- start
    iterateDf <- df[c('date', col)]
    
    while (date <= end) {
      if (iterateDf[iterateDf['date'] == as.character(date), col] == 0) {
        lastValue = iterateDf[iterateDf['date'] == as.character(date - 1), col]
        iterateDf[iterateDf['date'] == as.character(date), col] <- lastValue
      }
      date <- date + 1 
    }
    finalDf <- left_join(finalDf, iterateDf, by='date')
  }
  return(finalDf)
}

plotTimeSeries <- function(dataframe, title, logScale=FALSE) {
  df <- as.data.frame(dataframe)
  fillDf <- fillMissingDates(df)
  replacceDf <- replaceMissingValuesWithLast(fillDf)
  timeSeriesPlotDf <- melt(replacceDf, id.vars = 'date')
  
  if(logScale == TRUE) {
    timeSeriesPlotDf$value <- log(timeSeriesPlotDf$value + 1)
  }
  
  timeSeriesPlot <- ggplot(
    timeSeriesPlotDf,
    aes(x = date, y = value, color = variable)
  ) +
    geom_line() +
    xlab("") +
    scale_x_date(date_labels = "%m-%Y") +
    ggtitle(title)
  print(timeSeriesPlot)
  }

# plot following over time - date
followersVizDf <- followerHistory %>%
  mutate(date = as.Date(date)) %>%
  select(date, followers, tweets, favorites)

plotTimeSeries(
  dataframe=followersVizDf,
  title='Ethermore Follower, Tweet, and Favorite Counts Over Time'
)
