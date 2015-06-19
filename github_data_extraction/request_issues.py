#!/usr/bin/python

import requests
import sys 
import codecs
from pprint import pprint

# get the username and the git repo to retrieve the commits
github_user  = sys.argv[1]
github_repo  = sys.argv[2]

counter = 1

#  call get api
r = requests.get('https://api.github.com/repos/'+github_user+'/'+github_repo+'/'+'issues?state=all', auth=('token', '<your OAuth token>'))
# "/Users/evermal/Documents/soen691E/course_project/issues/"
f = codecs.open("<fuly qualified path to your folder>"+github_repo+"_"+str(counter)+".json", "w", "utf-8")
f.write(r.text)
f.close()

counter = counter + 1

# # get next page 
next_page = r.headers['link'].split(';')[0].replace('<', '').replace('>','')

# # print next_page
# # while has pagination
while "next" in r.headers['link']:
    #  call git api
    print next_page
    r = requests.get(next_page, auth=('token', '<your OAuth token>'))
    # print next_page

    # write json file to be parsed
    f = codecs.open("<fuly qualified path to your folder>"+github_repo+"_"+str(counter)+".json", "w", "utf-8")
    f.write(r.text)
    f.close()
    
    counter = counter + 1
    next_page = r.headers['link'].split(';')[0].replace('<', '').replace('>','') 