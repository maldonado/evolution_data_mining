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

    cursor.execute("drop table if exists release_average")
    cursor.execute("create table release_average (project_name text, age_in_months numeric, number_of_releases numeric, average numeric)")

    for project_data in projects:
        project_name = project_data[0]

        cursor.execute("select extract( year from age((select last_release from dataset_summary where project_name = '"+project_name+"'), (select first_release from dataset_summary where project_name = '"+project_name+"')))")
        results = cursor.fetchone()
        years = int(results[0])

        cursor.execute("select extract( month from age((select last_release from dataset_summary where project_name = '"+project_name+"'), (select first_release from dataset_summary where project_name = '"+project_name+"')))")
        results = cursor.fetchone()
        age = (int(results[0])+(years*12))

        cursor.execute("select number_of_releases from dataset_summary where project_name ='"+project_name+"'")
        results = cursor.fetchone()
        releases = results[0]        

        print project_name
        print age
        print releases

        average = releases/age
        
        cursor.execute("insert into release_average (project_name, age_in_months, number_of_releases, average) values ('"+project_name+"','"+str(age)+"','"+str(releases)+"','"+str(average)+"')")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()
    

