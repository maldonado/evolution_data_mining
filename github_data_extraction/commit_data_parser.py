#!/usr/bin/python

import os
import psycopg2
import sys
import simplejson
from pprint import pprint

connection = None

# get the project name that is also the nane of the json file as a parameters passed to the script
project_name  = sys.argv[1]

try:
    
    #connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='<your_host>', port='<your_host_port>', database='', user='', password='')
    cursor = connection.cursor()
    
    # prepare database
    drop table to store commit data if it does not exists
    cursor.execute("drop table if exists commits") 
    create table
    cursor.execute("create table commits (project_name text, commit text, tree text, author_id numeric, author_login text, author_dt timestamp without time zone, author_name text, author_email text, comment_count numeric, commit_message text)")
    
    # path to the commit files
    # path = "/Users/evermal/Documents/soen691E/course_project/commits/"
    path = "<fully qualified path to your files>"
    
    for root, dirs, files in os.walk(path):
        for f in files:

            # catch all files of this project
            if project_name in f :
                print f    

                # read as a json object
                with open(root+f) as data_file:
                    data = simplejson.load(data_file)
                
                # extract wanted data and insert into the database
                for x in xrange(0,len(data)):
                    
                    if data[x]['author'] is not None: 
                        author_id = data[x]['author']['id']
                        author_login = data[x]['author']['login']

                    commit = data[x]['sha']
                    tree = data[x]['commit']['tree']['sha']
                    author_dt = data[x]['commit']['author']['date']
                    author_name = data[x]['commit']['author']['name'].replace('\'', '"')
                    author_email = data[x]['commit']['author']['email']
                    comment_count = data[x]['commit']['comment_count']
                    commit_message = data[x]['commit']['message'].replace('\'', '"')
                    
                    # print commit_message

                    cursor.execute("insert into commits(project_name, commit, tree, author_id, author_login, author_dt, author_name, author_email, comment_count, commit_message) values ('"+project_name+"','"+commit+"','"+tree+"','"+str(author_id)+"','"+author_login+"',to_timestamp('"+author_dt+"','YYYY-MM-DD HH24:MI:SS'),'"+author_name+"','"+author_email+"','"+str(comment_count)+"','"+commit_message.replace("'","")+"')")
        
except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()