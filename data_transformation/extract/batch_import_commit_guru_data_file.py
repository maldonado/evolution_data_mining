#!/usr/bin/python

import os
import sys
import psycopg2
import csv

try:
    print "executing"   

    connection = None

    # connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='localhost', port='5432', database='jsevolution', user='evermal', password='')
    cursor = connection.cursor()

    root_folder = "./commit_guru_csv/"

    for root, dirs, files in os.walk(root_folder):
        for f in files:
            project_name = f.replace("csv","")
            file_directory = os.path.join(root, f)  
             
        with open( file_directory, 'rb') as csv_file:
            reader = csv.DictReader(csv_file)
            for row in reader:
                if row['commit_hash']:
                    commit_hash = row['commit_hash']
                if row['author_name']:
                    author_name = row['author_name'].replace('\'', '')
                if row['author_date_unix_timestamp']:
                    author_date_unix_timestamp = row['author_date_unix_timestamp']
                if row['author_email']:
                    author_email = row['author_email']
                if row['author_date']:
                    author_date = row['author_date']
                if row['commit_message']:
                    commit_message = row['commit_message'].replace('\'', '')
                if row['fix']:
                    fix = row['fix']
                if row['classification']:
                    classification = row['classification']
                if row['linked']:
                    linked = row['linked']
                if row['contains_bug']:
                    contains_bug = row['contains_bug']
                if row['fixes']:
                    fixes = row['fixes']
                else:
                    fixes = "-"    
                if row['ns']:
                    ns = row['ns']
                if row['nd']:
                    nd = row['nd']
                if row['nf']:
                    nf = row['nf']
                if row['entrophy']:
                    entrophy = row['entrophy']
                if row['la']:
                    la = row['la']
                if row['ld']:
                    ld = row['ld']
                if row['fileschanged']:
                    fileschanged = row['fileschanged']
                if row['lt']:
                    lt = row['lt']
                if row['ndev']:
                    ndev = row['ndev']
                if row['age']:
                    age = row['age']
                if row['nuc']:
                    nuc = row['nuc']
                if row['exp']:
                    exp = row['exp']
                if row['rexp']:
                    rexp = row['rexp']
                if row['sexp']:
                    sexp = row['sexp']
                if row['glm_probability']:
                    glm_probability = row['glm_probability']
                if row['repository_id']:
                    repository_id = row['repository_id']
                
                cursor.execute("insert into commits (project_name, commit_hash, author_name, author_date_unix_timestamp, author_email,  author_date, commit_message, fix , classification ,  linked , contains_bug , fixes ,  ns, nd , nf, entrophy , la , ld , fileschanged , lt , ndev , age , nuc,  exp , rexp , sexp , glm_probability , repository_id)  values('"+project_name+"','"+commit_hash+"','"+str(author_name)+"', "+str(author_date_unix_timestamp)+", '"+str(author_email)+"','"+str(author_date)+"', '"+str(commit_message).replace('\'', '')+"', '"+str(fix)+"', '"+str(classification)+"','"+str(linked)+"', '"+str(contains_bug)+"', '"+str(fixes)+"', "+str(ns)+", "+str(nd)+", "+str(nf)+", "+str(entrophy)+", "+str(la)+",  "+str(ld)+", '"+str(fileschanged)+"', "+str(lt)+",  "+str(ndev)+",  "+str(age)+",  "+str(nuc)+","+str(exp)+",  "+str(rexp)+",  "+str(sexp)+", "+str(glm_probability)+", '"+str(repository_id)+"')

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()
    print 'done'





