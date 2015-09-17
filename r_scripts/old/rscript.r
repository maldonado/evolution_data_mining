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


# release_density
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select * from release_density where number_of_releases != 0 and project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap')")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$date_group, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$number_of_releases, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
ylab("Releases") + labs(colour='Projects')

# number of single developers per version
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap') group by 1,2")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
ylab("Developers") + labs(colour='Projects')

----------------------------------
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('coffeescript', 'less.js', 'npm', 'underscore', 'node-mysql') group by 1,2")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
ylab("Developers") + labs(colour='Projects')

----------------------------------
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('q', 'request', 'ember.js', 'mocha',  'bower') group by 1,2")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
ylab("Developers") + labs(colour='Projects')

#number of reported issues per release
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select a.project_name, a.release_date, count(*) from metrics_data a, issues b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap') group by 1,2
")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
ylab("Issues") + labs(colour='Projects') 

----------------------------------------
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select a.project_name, a.release_date, count(*) from metrics_data a, issues b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('coffeescript', 'less.js', 'npm', 'underscore', 'node-mysql') group by 1,2
")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
  geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
  ylab("Issues") + labs(colour='Projects') 

----------------------------------------

library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select a.project_name, a.release_date, count(*) from metrics_data a, issues b where a.project_name = b.project_name and a.version = b.version and a.project_name in ('q', 'request', 'ember.js', 'mocha',  'bower') group by 1,2
")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
geom_line(aes(group = data1$project_name)) + geom_point() +  xlab("Date") + 
ylab("Issues") + labs(colour='Projects') 

summary(data1$date_part)


#interval between created date and closed date
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select * from average_fixing_time")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

hist(data1$average_days, 
     col="grey",
     xlab="Days",
     ylab="Projects",
     main="Average days to fix a bug")

barplot(data1)

library(ggplot2)
library(reshape2)
test.m <- melt(data1)

ggplot(test.m, aes(x = data1$project_name, y = data1$date_part)) +
  geom_boxplot() +
  scale_fill_manual(values = c("yellow", "orange"))


quantile(data1$int4 , .90)

tc = data1$int4[data1$int4 < 10]
boxplot(tc )


# comparing issues first and last version
library(vcd)
library(RPostgreSQL)

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select blocker_issues, critical_issues, major_issues, minor_issues, (issues - blocker_issues - critical_issues - major_issues - minor_issues) as info_issues from metrics_data where release_date = '2010-04-12' and project_name='coffeescript'")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

pdf(paste("coffeescript_first", "pdf", sep = "."))
barplot(as.matrix(data1),        
        xlab="First version", ylab="Problems",
        col=c("gray", "gray", "gray", "gray", "gray"),
        legend=rownames(data1$blocker_issues))
dev.off()

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select blocker_issues, critical_issues, major_issues, minor_issues, (issues - blocker_issues - critical_issues - major_issues - minor_issues) as info_issues from metrics_data where release_date = '2015-01-29' and project_name='coffeescript'")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

pdf(paste("coffeescript_last", "pdf", sep = "."))
barplot(as.matrix(data1),        
        xlab="First version", ylab="Problems",
        col=c("gray", "gray", "gray", "gray", "gray"),
        legend=rownames(data1$blocker_issues))
dev.off()

# number of LOC per release
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='localhost', port='5432', dbname='jsevolution', user='evermal', password='')
mongoose <- dbSendQuery(con, "select project_name, release_date, issues as count from metrics_data where project_name in ('node-mongodb-native', 'mongo-java-driver', 'node-mysql', 'mysql-connector-j') order by 2")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)


require(ggplot2)
data1$Date <- as.Date( data1$release_date, '%Y/%m/%d')
ggplot(data = data1, aes(x = Date, y = data1$count, colour = data1$project_name)) +       
  geom_line(aes(group = data1$project_name)) + geom_point()  +  xlab("Date") + 
  ylab("Issues") + labs(colour='Projects')
