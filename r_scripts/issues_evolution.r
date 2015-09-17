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
