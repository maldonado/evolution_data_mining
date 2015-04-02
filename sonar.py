import os
import sys
import subprocess
import shutil

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
            if f[0] == '.' :
                os.unlink(os.path.join(root, f))
            # if f == 'LICENSE' :
            #     os.unlink(os.path.join(root, f))
            # if f == 'run.sh':
            #     os.unlink(os.path.join(root, f))
        for d in dirs:
            # remove invisible directories
            if d[0] == '.': 
                shutil.rmtree(os.path.join(root, d))
            # if d == 'test' :
            #     shutil.rmtree(os.path.join(root, d))
                
            
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