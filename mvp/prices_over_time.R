# [NFT Analyzer V1 MVP] Price Trend #4
# https://github.com/charliedao-eth/NFT_Analyzer/issues/4

# import packages
library(dplyr)
library(ggplot2)
library(reshape)

# set path
filePath <- "~/repos/github/NFT_Analyzer/mvp/Ethermorelore/"

# import data
salesHistory <- read.csv(paste0(filePath, "sales_history_2021-10-28.csv"))

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

plotTimeSeries <- function(dataframe, title, logScale=FALSE) {
  df = fillMissingDates(as.data.frame(dataframe))
  timeSeriesPlotDf <- melt(df, id.vars = 'date')
  
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

# prepare base data
priceVizDf <- fillMissingDates(
  salesHistory %>% mutate(date = as.Date(Date))
  ) %>%
  select(date, PRICE) %>%
  group_by(date) %>%
  summarise(
    min_price = round(min(PRICE), 2),
    max_price = round(max(PRICE), 2),
    median_price = round(median(PRICE), 2)
    )

# fill in gaps with previous median price
start <- min(priceVizDf$date)
end   <- max(priceVizDf$date)
date <- start
while (date <= end) {
  if (priceVizDf$min_price[priceVizDf$date == date] == 0) {
    lastValue = priceVizDf$min_price[priceVizDf$date == (date-1)]
    priceVizDf$min_price[priceVizDf$date == date] <- lastValue
  }
  
  if (priceVizDf$max_price[priceVizDf$date == date] == 0) {
    lastValue = priceVizDf$max_price[priceVizDf$date == (date-1)]
    priceVizDf$max_price[priceVizDf$date == date] <- lastValue
  }
  
  if (priceVizDf$median_price[priceVizDf$date == date] == 0) {
    lastValue = priceVizDf$median_price[priceVizDf$date == (date-1)]
    priceVizDf$median_price[priceVizDf$date == date] <- lastValue
  }
  date <- date + 1                    
}

# plot min graph
plotTimeSeries(
  dataframe=priceVizDf %>% select(date, min_price),
  title='Ethermore Min ETH Sales Price Over Time'
)

# plot max graph
plotTimeSeries(
  dataframe=priceVizDf %>%
    select(date, max_price) %>%
    filter(max_price <= 10),
  title='Ethermore Max ETH Sales Price Over Time'
)

# plot median graph
plotTimeSeries(
  dataframe=priceVizDf %>% select(date, median_price),
  title='Ethermore Median ETH Sales Price Over Time'
)

# plot min, max, med graph
plotTimeSeries(
  dataframe=priceVizDf %>%
    select(date, min_price, max_price, median_price) %>%
    filter(max_price <= 10),
  title='Ethermore ETH Sales Price Over Time',
  logScale=FALSE
)

plotTimeSeries(
  dataframe=priceVizDf %>%
    select(date, min_price, max_price, median_price) %>%
    filter(max_price <= 10),
  title='Ethermore ETH Sales Price Over Time (Log Scaled)',
  logScale=TRUE
)

# plot price boxplot over time graph
boxplotDf <- salesHistory %>%
  mutate(year_week = format(as.Date(Date),'%Y-%W')) %>%
  mutate(PRICE = round(PRICE, 2)) %>%
  select(year_week, PRICE) %>%
  filter(PRICE <= 10)

ggplot(boxplotDf) + 
  geom_boxplot(aes(x=year_week, y=PRICE)) +
  theme(axis.text.x = element_text(angle = 45, vjust = 0.5)) +
  ggtitle('Ethermore ETH Price Spread by Year-Week')
