#!/usr/bin/python

import os
import sys
import psycopg2

try:
    connection = None
    
    # connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='localhost', port='5432', database='jsevolution', user='evermal', password='')
    cursor = connection.cursor()

    # previous data array ['2010-01-01','2010-04-01','2010-07-01','2010-10-01','2011-01-01','2011-04-01','2011-07-01','2011-10-01','2012-01-01','2012-04-01','2012-07-01','2012-10-01','2013-01-01','2013-04-01','2013-07-01','2013-10-01','2014-01-01','2014-04-01','2014-07-01','2014-10-01','2015-01-01','2015-04-01']
    date_array = ['2002-01-01','2002-04-01','2002-07-01','2002-10-01','2003-01-01','2003-04-01','2003-07-01','2003-10-01','2004-01-01','2004-04-01','2004-07-01','2004-10-01','2005-01-01','2005-04-01','2005-07-01','2005-10-01','2006-01-01','2006-04-01','2006-07-01','2006-10-01','2007-01-01','2007-04-01','2007-07-01','2007-10-01','2008-01-01','2008-04-01','2008-07-01','2008-10-01','2009-01-01','2009-04-01','2009-07-01','2009-10-01','2010-01-01','2010-04-01','2010-07-01','2010-10-01','2011-01-01','2011-04-01','2011-07-01','2011-10-01','2012-01-01','2012-04-01','2012-07-01','2012-10-01','2013-01-01','2013-04-01','2013-07-01','2013-10-01','2014-01-01','2014-04-01','2014-07-01','2014-10-01','2015-01-01','2015-04-01','2015-07-01','2015-10-01']
    
    cursor.execute("select distinct(project_name) from metrics_data")
    projects = cursor.fetchall()

    cursor.execute("drop table if exists commit_density")
    cursor.execute("create table commit_density (project_name text, date_group date, number_of_commits numeric)")

    for project_data in projects:
        project_name = project_data[0]
        print 'analyzing: '+ project_name

        for x in xrange(0,55):
            if x != 55 :
                # previous way to calculate = cursor.execute("select count(version) as commit_density from metrics_data where project_name = '"+project_name+"' and release_date >= '"+str(date_array[x])+"' and release_date <= '"+str(date_array[x+1])+"'")
                cursor.execute("select count(distinct(commit_hash)) as commit_density from commits where project_name = '"+project_name+"' and author_date >= '"+str(date_array[x])+"' and author_date <= '"+str(date_array[x+1])+"'")
                
                commit_density = cursor.fetchall()
                value = commit_density[0][0]
                print "insert into commit_density(project_name, date_group, number_of_commits) values ('"+project_name+"', '"+date_array[x]+"', "+str(value)+")"
                cursor.execute("insert into commit_density(project_name, date_group, number_of_commits) values ('"+project_name+"', '"+date_array[x]+"', "+str(value)+")")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()