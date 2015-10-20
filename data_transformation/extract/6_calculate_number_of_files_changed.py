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

        cursor.execute("select commit_hash, file_list from number_of_file_changes_per_version where project_name='"+project_name+"'")
        results = cursor.fetchall()

        for result in results:
            commit_hash = result[0]
            files_changed =  result[1].split(',CAS_DELIMITER,')
            print commit_hash
            # print "update number_of_file_changes_per_version set number_of_files_changed = "+str(len(files_changed))+"  where commit_hash = '"+commit_hash+"'"

            cursor.execute("update number_of_file_changes_per_version set number_of_files_changed = "+str(len(files_changed))+"  where commit_hash = '"+commit_hash+"'")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()