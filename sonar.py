import sys
import subprocess
import os

# get all tags
tags = subprocess.check_output(["git", "tag"]).split()



directory = subprocess.check_output(["pwd"]).split()[0]
projectName = directory.split('/')[-1]

subprocess.call(["mkdir", "../"+projectName+"_tags"])

counter = 0
for tag in tags:
    # checkout into each of them
    subprocess.call(["git", "checkout" , tag])
    # create directory to place all the tags
    subprocess.call(["mkdir", "../"+projectName+"_tags/"+tag])
    # create sub directory src, to run sonar analysis
    subprocess.call(["mkdir", "../"+projectName+"_tags/"+tag+"/src"])

    # create sonar-project.properties file 
    f = open("../"+projectName+"_tags/"+tag+"/sonar-project.properties", "wb")
    f.write("# Required metadata\n")
    f.write("sonar.projectKey=" +projectName+ "\n")
    f.write("sonar.projectName=" +projectName+ "\n")
    f.write("sonar.projectVersion=" +tag+ "\n")
    f.write("# Comma-separated paths to directories with sources (required)\n")
    f.write("sonar.sources=src\ \n")
    f.write("# Language\n")

    # project language should be changed accordingly
    f.write("sonar.language=js\n")
    
    f.write("# Encoding of sources files\n")
    f.write("sonar.sourceEncoding=UTF-8\n")
    f.close()
    counter = counter + 1

    print str(counter) + " of: " + str(len(tags))