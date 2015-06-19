#!/usr/bin/python

import os
import sys
import psycopg2

try:
    connection = None
    
    # connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='cranberry', port='5432', database='re', user='re', password='re')
    cursor = connection.cursor()
 
    cursor.execute("select distinct(project_name) from metrics_data")
    projects = cursor.fetchall()

    cursor.execute("drop table if exists average_fixing_time")
    cursor.execute("create table average_fixing_time (project_name text, average_days numeric)")

    for project_data in projects:
        project_name = project_data[0]

        cursor.execute("select project_name, cast((EXTRACT(epoch from (closed_at - created_at))/86400) as integer) from issues where closed_at is not null and project_name='"+project_name+"'")
        results = cursor.fetchall()
        number_of_fixes = len(results)

        sum_of_fixes = 0

        for result in results:   
            number_of_days = result[1]

            if number_of_days == 0:    
                number_of_days = 1
            sum_of_fixes = sum_of_fixes + number_of_days    

        average = sum_of_fixes/number_of_fixes
        
        cursor.execute("insert into average_fixing_time (project_name, average_days) values ('"+project_name+"',"+str(average)+")")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()
    
