# number of single developers per version
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
query_result <- dbSendQuery(con, "select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap') group by 1,2")
data1 <- fetch(query_result,n=-1)
dim(data1)
dbHasCompleted(query_result)

require(ggplot2)
data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
ylab("Developers") + labs(colour='Projects')

----------------------------------
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
query_result <- dbSendQuery(con, "select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('coffeescript', 'less.js', 'npm', 'underscore', 'node-mysql') group by 1,2")
data1 <- fetch(query_result,n=-1)
dim(data1)
dbHasCompleted(query_result)

require(ggplot2)
data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
ylab("Developers") + labs(colour='Projects')

----------------------------------
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
query_result <- dbSendQuery(con, "select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('q', 'request', 'ember.js', 'mocha',  'bower') group by 1,2")
data1 <- fetch(query_result,n=-1)
dim(data1)
dbHasCompleted(query_result)

require(ggplot2)
data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
ylab("Developers") + labs(colour='Projects')