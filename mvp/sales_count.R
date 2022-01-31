# [NFT Analyzer V1 MVP] Sales Count
# https://github.com/charliedao-eth/NFT_Analyzer/issues/6

# import packages
library(dplyr)
library(ggplot2)
library(reshape)

# set path
filePath <- "~/repos/github/NFT_Analyzer/mvp/Ethermorelore/"

# import data
salesHistory <- read.csv(paste0(filePath, "sales_history_2021-10-28.csv"))
tweets <- read.csv(paste0(filePath, "tweets_2021-10-25.csv"))

# helper function
fillMissingDates <- function(dataframe) {
  df = as.data.frame(dataframe)
  
  date = seq(min(df$date), max(df$date), by="days")
  dateRangeDf <- as.data.frame(date)
  
  filledDatesDf <- dateRangeDf %>%
    left_join(., df, by='date') %>%
    replace(is.na(.), 0)
  
  return(filledDatesDf)
}

plotTimeSeries <- function(dataframe, title, logScale=FALSE) {
  df = fillMissingDates(as.data.frame(dataframe))
  timeSeriesPlotDf <- melt(df, id.vars = 'date')
  
  if(logScale == TRUE) {
    timeSeriesPlotDf$value = log(timeSeriesPlotDf$value + 1)
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

# prepare base data
salesHistoryVizDf <- salesHistory %>%
  mutate(date = as.Date(Date)) %>%
  select(date, PRICE_USD)

# sales count viz
salesCountVizDf <- salesHistoryVizDf %>%
  count(date) %>%
  dplyr::rename(sales_count = n)

plotTimeSeries(
  dataframe=salesCountVizDf,
  title='Ethermore Sales Count Over Time'
  )

# sales usd sum viz
salesUsdSumVizDf <- salesHistoryVizDf %>%
  group_by(date) %>%
  summarise(sum = sum(PRICE_USD))

plotTimeSeries(
  dataframe=salesUsdSumVizDf,
  title='Ethermore Sales $USD Over Time'
)

# sales and retweets viz
salesRetweetsVizDf <- fillMissingDates(
  tweets %>% mutate(date = as.Date(created_at))
) %>%
  select(date, retweet_count) %>%
  left_join(., salesCountVizDf, by='date') %>%
  replace(is.na(.), 0)

plotTimeSeries(
  dataframe=salesRetweetsVizDf,
  title='Ethermore Sales Count v.s. Retweet Count Over Time (Log Scaled)',
  logScale=TRUE
)

plotTimeSeries(
  dataframe=salesRetweetsVizDf,
  title='Ethermore Sales Count v.s. Retweet Count Over Time'
)
