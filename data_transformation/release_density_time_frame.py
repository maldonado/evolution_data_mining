#!/usr/bin/python

import os
import sys
import psycopg2

try:
    connection = None
    
    # connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='cranberry', port='5432', database='re', user='re', password='re')
    cursor = connection.cursor()

    date_array = ['2010-01-01','2010-04-01','2010-07-01','2010-10-01','2011-01-01','2011-04-01','2011-07-01','2011-10-01','2012-01-01','2012-04-01','2012-07-01','2012-10-01','2013-01-01','2013-04-01','2013-07-01','2013-10-01','2014-01-01','2014-04-01','2014-07-01','2014-10-01','2015-01-01','2015-04-01']
    
    cursor.execute("select distinct(project_name) from metrics_data")
    projects = cursor.fetchall()

    analysis_tuple = None


    cursor.execute("drop table if exists release_density")
    cursor.execute("create table release_density (project_name text, date_group date, number_of_releases numeric)")

    for project_data in projects:
        project_name = project_data[0]
        
        for x in xrange(0,21):
            if x != 21 :
                cursor.execute("select count(version) as release_density from metrics_data where project_name = '"+project_name+"' and release_date >= '"+str(date_array[x])+"' and release_date <= '"+str(date_array[x+1])+"'")
                release_density = cursor.fetchall()
                value = release_density[0][0]
                cursor.execute("insert into release_density(project_name, date_group, number_of_releases) values ('"+project_name+"', '"+date_array[x]+"', "+str(value)+")")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()
    
