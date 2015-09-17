# function_density
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
query_result <- dbSendQuery(con, "select * from function_density where density != 0 and project_name in ('source-map', 'grunt', 'query_result', 'brackets','bootstrap')")
data1 <- fetch(query_result,n=-1)
dim(data1)
dbHasCompleted(query_result)

require(ggplot2)
data1$Date <- as.Date( data1$date_group, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$density, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
ylab("Density") + labs(colour='Projects')

# function_density
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
query_result <- dbSendQuery(con, "select * from function_density where density != 0 and project_name in ('coffeescript', 'less.js', 'npm', 'underscore', 'node-mysql')")
data1 <- fetch(query_result,n=-1)
dim(data1)
dbHasCompleted(query_result)

require(ggplot2)
data1$Date <- as.Date( data1$date_group, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$density, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
ylab("Density") + labs(colour='Projects')

# function_density
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
query_result <- dbSendQuery(con, "select * from function_density where density != 0 and project_name in ('q', 'request', 'ember.js', 'mocha',  'bower')")
data1 <- fetch(query_result,n=-1)
dim(data1)
dbHasCompleted(query_result)

require(ggplot2)
data1$Date <- as.Date( data1$date_group, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$density, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
ylab("Density") + labs(colour='Projects')