#!/usr/bin/python

import os
# import re
import psycopg2
import sys

connection = None
# get the project name that is also the nane of the json file as a parameters passed to the script


try:
    
    #connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='cranberry', port='5432', database='re', user='re', password='re')
    cursor = connection.cursor()
    
    cursor.execute('select project_name, version, release_date from metrics_data order by 1,3')
    metrics_data = cursor.fetchall()

    counter = 0
    total = len(metrics_data)
    for row in metrics_data:
        
        project_name = row[0]
        version = row[1]
        release_date = row[2]


        cursor.execute("select project_name, bug_id, bug_number from issues where created_at <= '"+str(release_date)+"' and project_name = '"+project_name+"' and version is null")
        issues_from_this_version = cursor.fetchall();
        print len(issues_from_this_version)
        for issue_row in issues_from_this_version:
            issue_project_name = issue_row[0]
            bug_id = issue_row[1]
            bug_number = issue_row[2]

            cursor.execute("update issues set version='"+version+"' where bug_id='"+str(bug_id)+"' and bug_number = '"+str(bug_number)+"' and project_name = '"+project_name+"'")

        counter = counter + 1    
        print str(counter)+"of: "+str(total)    
                   
except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()