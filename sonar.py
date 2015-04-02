import os
import re
import sys
import subprocess
import shutil

# get all tags from the git repository
tags = subprocess.check_output(["git", "tag"]).split()

# get directory name and project name to create folders dynamically
directory = subprocess.check_output(["pwd"]).split()[0]
projectName = directory.split('/')[-1]

# create folder to keep all the tags
subprocess.call(["mkdir", "../"+projectName+"_tags"])

#regex to eliminate folders that is not relevant for the analysis, like third party libraries and invisible files
file_regex = '\..*' 
directory_regex = '\..*|vendor|thirdparty|(:?ex|s)amples|doc(:?s|uments)|bin|node' 

counter = 0

for tag in tags:
    # checkout into each of them
    subprocess.call(["git", "checkout" , tag])
    
    # create directory to place all the tags
    folder_path = "../"+projectName+"_tags/"+tag
    subprocess.call(["mkdir", folder_path])

    # create sub directory src, to run sonar analysis
    subprocess.call(["mkdir", folder_path+"/src"])

    # copy checkout tag to its specific directory
    subprocess.call(["cp", "-r",  "./" , folder_path+"/src"])

    # walk the folder to remove unwanted files and folders (invisible files and third party) 
    for root, dirs, files in os.walk(folder_path):
        for f in files:
            # removes invisible files
            if re.match(file_regex, f) is not None:
                os.unlink(os.path.join(root, f))
        for d in dirs:
            # regex to eliminate unwanted folders, like third party libraries and invisible files   
            if re.match(directory_regex, d) is not None:
                shutil.rmtree(os.path.join(root, d))
                
    # create sonar-project.properties file 
    f = open(folder_path + "/sonar-project.properties", "wb")
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