#!/usr/bin/python

import os
import re
import psycopg2
import subprocess
import sys

connection = None
tags_regex = '(\d\d\d\d\-\d\d\-\d\d\s\d\d:\d\d:\d\d)|\(tag:\s([A-Za-z0-9\-\_\.+]*)\)'

try:
    
    # #connect to the database to retrieve the file name linked with the commit
    # connection = psycopg2.connect(host='localhost', port='5432', database='jsevolution', user='evermal', password='')
    # cursor = connection.cursor()

    # get all tags from the git repository in order and with date
    git_log_result = subprocess.check_output(["git", "log", "--tags", "--date-order",  "--reverse",  "--simplify-by-decoration", "--pretty=%ai %d"])

    tag = None
    counter = 0
    
    for line in git_log_result.split('\n'):   
        # for each line has matches
        if re.search(tags_regex, line) is not None:
            m = re.findall(tags_regex, line)
            # has match fot tag and date (merge has date but not tag)
            if len(m) == 2:
                # get result from the first tuple, first item (date)
                tag_date = m[0][0]
                # get result from the second tuple, second item (tag)
                previous_tag = tag
                tag = m[1][1]
                 
                if counter == 0:
                    tag_commits = subprocess.check_output(["git", "log", "--pretty=oneline", tag])
                    counter = counter + 1
                else:
                    tag_commits = subprocess.check_output(["git", "log", "--pretty=oneline", previous_tag, "...",  tag])


                print "************************************************"
                print tag_commits
    
    
    # cursor.execute('select project_name, version, release_date from metrics_data order by 1,3')
    # metrics_data = cursor.fetchall()

    # counter = 0
    # total = len(metrics_data)
    # for row in metrics_data:
    #     counter = counter +1
    #     project_name = row[0]
    #     version = row[1]
    #     release_date = row[2]


    #     cursor.execute("select commit from commits where author_dt <= '"+str(release_date)+"' and project_name = '"+project_name+"' and version is null")
    #     commits_from_this_version = cursor.fetchall();
    #     print len(commits_from_this_version)
    #     for commit_row in commits_from_this_version:
    #         commit = commit_row[0]
    #         cursor.execute("update commits set version='"+version+"' where commit='"+commit+"'")

    #     print str(counter)+"of: "+str(total)    
                   
except Exception, e:
    # print  e
    # connection.rollback()
    pass

finally:
    # connection.commit()
    pass