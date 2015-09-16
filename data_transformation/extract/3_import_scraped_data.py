#!/usr/bin/python

import os
import sys
import psycopg2
import csv

try:
    connection = None

    # connect to the database to retrieve the file name linked with the commit
    connection = psycopg2.connect(host='localhost', port='5432', database='', user='', password='')
    cursor = connection.cursor()

    with open('./extract/metrics.csv', 'rb') as csv_file:
        reader = csv.DictReader(csv_file)
        for row in reader:
       
            if  row['project name'] :
                project_name = row['project name']   
            if  row['version'] :
                version = row['version']
            if  row['date'] :
                release_date = row['date']
            if  row['lines of code'] :
                lines_of_code = row['lines of code']
            if  row['complexity'] :
                complexity = row['complexity']
            if  row['comment lines density%'] :
                comment_lines_density_percent = row['comment lines density%'].replace('%', '')
            if  row['duplicated lines density%'] :
                duplicated_lines_density = row['duplicated lines density%'].replace('%', '')
            if  row['issues'] :
                issues = row['issues']
            if  row['complexity/file'] :
                complexity_file = row['complexity/file']
            if  row['complexity/function'] :
                complexity_function = row['complexity/function']
            if  row['comment lines'] :
                comment_lines = row['comment lines']
            if  row['duplicated blocks'] :
                duplicate_block = row['duplicated blocks']
            if  row['blocker issues'] :
                blocker_issues = row['blocker issues']
            if  row['critical issues'] :
                critical_issues = row['critical issues']
            if  row['major issues'] :
                major_issues = row['major issues']
            if  row['minor issues'] :
                minor_issues = row['minor issues']
            if  row['directories'] :
                directories = row['directories']
            if  row['functions'] :
                functions = row['functions']
            if  row['statements'] :
                statements = row['statements']
            if  row['SQALE rating'] :
                SQALE = row['SQALE rating']
            if  row['technical debt'] :
                technical_debt = row['technical debt']
            if  row['technical debt ratio'] :
                technical_debt_ratio = row['technical debt ratio'].replace('%', '')

            print ''+str(project_name)+','+str(version)+','+str(release_date)+','+str(lines_of_code)+','+str(complexity)+','+str(comment_lines_density_percent)+','+str(duplicated_lines_density)+','+str(issues)+','+str(complexity_file)+','+str(complexity_function)+','+str(comment_lines)+','+str(duplicate_block)+','+str(blocker_issues)+','+str(critical_issues)+','+str(major_issues)+','+str(minor_issues)+','+str(directories)+','+str(functions)+','+str(statements)+','+str(SQALE)+','+str(technical_debt)+','+str(technical_debt_ratio)+''
            cursor.execute("insert into rawdata (project_name,version,release_date,lines_of_code,complexity,comment_lines_density_percent,duplicated_lines_density,issues,complexity_file,complexity_function,comment_lines,duplicate_block,blocker_issues,critical_issues,major_issues,minor_issues,directories,functions,statements,SQALE,technical_debt,technical_debt_ratio) values ('"+str(project_name)+"','"+str(version)+"', to_date('"+str(release_date)+"','DD Mon YYYY'),"+str(lines_of_code)+","+str(complexity)+","+str(comment_lines_density_percent)+","+str(duplicated_lines_density)+","+str(issues)+","+str(complexity_file)+","+str(complexity_function)+","+str(comment_lines)+","+str(duplicate_block)+","+str(blocker_issues)+","+str(critical_issues)+","+str(major_issues)+","+str(minor_issues)+","+str(directories)+","+str(functions)+","+str(statements)+",'"+str(SQALE)+"','"+str(technical_debt)+"',"+str(technical_debt_ratio)+")")

except Exception, e:
    print  e
    connection.rollback()

finally:
    connection.commit()
    