#!/usr/bin/python

import os
# import re
import psycopg2
import sys
import simplejson
from pprint import pprint

connection = None
# get the project name that is also the nane of the json file as a parameters passed to the script


try:
    
    #connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='cranberry', port='5432', database='re', user='re', password='re')
    cursor = connection.cursor()
    
    cursor.execute('select project_name, version, release_date from metrics_data order by 1,3 limit 10')
    metrics_data = cursor.fetchall()

    for row in metrics_data:
        project_name = row[0]
        version = row[1]
        release_date = row[2]

        print project_name
        print version
        print release_date

        cursor.execute("select commit from commits where author_dt <= '"+release_date+"' and project_name = "+project_name+" version is null limit 10")
        commits_from_this_version = cursor.fetchall();
        print len(commits_from_this_version)
        for commit_row in commits_from_this_version:
            commit = commit_row[0]
            # cursor.execute("update commits set version='"+version+"' where commit='"+commit+"'")
            
        
except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()