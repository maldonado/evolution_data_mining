#!/usr/bin/python

import os
import sys
import psycopg2

try:
    connection = None
    connection = psycopg2.connect(host='localhost', port='5432', database='jsevolution', user='evermal', password='')
    cursor = connection.cursor()
 
    cursor.execute("select distinct(project_name) from commits")
    projects = cursor.fetchall()

    for project_data in projects:
        project_name = project_data[0]
        print project_name

        cursor.execute("select distinct(a.commit_hash), b.fileschanged, a.lines_added, a.lines_deleted from churn_of_corrective_changes a , commits b  where a.commit_hash = b.commit_hash and a.project_name='"+project_name+"'")
        results = cursor.fetchall()

        for result in results:
            commit_hash = result[0]
            files_changed =  result[1].split(',CAS_DELIMITER,')
            churn = result[2] + result[3]
            
            print "update churn_of_corrective_changes set number_of_files_changed = "+str(len(files_changed))+", churn = "+str(churn)+"  where commit_hash = '"+commit_hash+"'"
            cursor.execute("update churn_of_corrective_changes set number_of_files_changed = "+str(len(files_changed))+", churn = "+str(churn)+"  where commit_hash = '"+commit_hash+"'")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()