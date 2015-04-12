require(ggplot2)

# function_density
library(RPostgreSQL)
drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, host='cranberry', port='5432', dbname='re', user='re', password='re')
mongoose <- dbSendQuery(con, "select * from function_density where density != 0 and project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap')")
data1 <- fetch(mongoose,n=-1)
dim(data1)
dbHasCompleted(mongoose)

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

