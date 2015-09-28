#!/usr/bin/python

import os
import re
import psycopg2
import subprocess
import sys

connection = None
tags_regex = '(\d\d\d\d\-\d\d\-\d\d\s\d\d:\d\d:\d\d)|\(tag:\s([A-Za-z0-9\-\_\.+]*)\)'
commit_regex = '([0-9a-z]{40})\s(.*)'

try:

    # # get directory name and project name to create folders dynamically
    directory = subprocess.check_output(["pwd"]).split()[0]
    project_name = directory.split('/')[-1]

    #connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='localhost', port='5432', database='jsevolution', user='evermal', password='')
    cursor = connection.cursor()

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
                    for commit_line in tag_commits.split('\n'):
                        match = re.search(commit_regex, commit_line)
                        if match:
                            commit_id = match.group(1)
                            cursor.execute("insert into commits (project_name, version, commit_hash) values ('"+project_name+"','"+tag+"','"+commit_id+"')")

                else:
                    tag_commits = subprocess.check_output(["git", "log", "--pretty=oneline", previous_tag + "..." +  tag])
                    for commit_line in tag_commits.split('\n'):
                        match = re.search(commit_regex, commit_line)
                        if match:
                            commit_id = match.group(1)
                            cursor.execute("insert into commits (project_name, version, commit_hash) values ('"+project_name+"','"+tag+"','"+commit_id+"')")
                            

                  
except Exception, e:
    print  e
    connection.rollback()
    

finally:
    connection.commit()
    