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
        counter = counter +1
        project_name = row[0]
        version = row[1]
        release_date = row[2]


        cursor.execute("select commit from commits where author_dt <= '"+str(release_date)+"' and project_name = '"+project_name+"' and version is null")
        commits_from_this_version = cursor.fetchall();
        print len(commits_from_this_version)
        for commit_row in commits_from_this_version:
            commit = commit_row[0]
            cursor.execute("update commits set version='"+version+"' where commit='"+commit+"'")

        print str(counter)+"of: "+str(total)    
                   
except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()