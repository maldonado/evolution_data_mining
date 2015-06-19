import os
import re
import sys
import subprocess
import time

def sorted_ls(path):
    mtime = lambda f: os.stat(os.path.join(path, f)).st_mtime
    return list(sorted(os.listdir(path), key=mtime))

try:
    
    analyzed_folder = "../analized_projects"
    if not os.path.exists(analyzed_folder):
        subprocess.call(["mkdir", analyzed_folder])    

    # # get directory name 
    directory = subprocess.check_output(["pwd"]).split()[0]

    # # interating through the folders of tags
    for root_tag_dir in os.listdir(directory):
        # prevents to get a non directory per mistake
        if(os.path.isdir(root_tag_dir)) and "_tags" in root_tag_dir:
            # create a folder to store the analyzed tags if it not exists
            if not os.path.exists(analyzed_folder+"/"+root_tag_dir):
                subprocess.call(["mkdir", analyzed_folder+"/"+root_tag_dir])
            if not os.path.exists(analyzed_folder+"/"+root_tag_dir+"_rejected"):
                subprocess.call(["mkdir", analyzed_folder+"/"+root_tag_dir+"_rejected"])    
            # get all tags 
            all_tags = sorted_ls(root_tag_dir)
            for tag_dir in all_tags:   
                # prevent taking a file that is not a directory, and is not a invisible directory like .sonar
                if(os.path.isdir(root_tag_dir+"/"+tag_dir)) and tag_dir[0] != '.':
                    print root_tag_dir +" - "+ tag_dir
                    # remove any old propertie file that may exist
                    subprocess.call(["rm", "sonar-project.properties"])
                    # copies the properties file to the current folder so we do not have to change directories
                    subprocess.call(["cp", "-r" , root_tag_dir+"/"+tag_dir+"/"+"sonar-project.properties",  "./"] )
                    # run sonar runner checking if the exit code is success, otherwise will throw exception
                    subprocess.check_output(["sonar-runner"])
                    # create a folder to store the analyzed tags if it not exists
                    if not os.path.exists(analyzed_folder+"/"+root_tag_dir+"/"+tag_dir):
                        subprocess.call(["mkdir", analyzed_folder+"/"+root_tag_dir+"/"+tag_dir])
                    os.rename(root_tag_dir+"/"+tag_dir, analyzed_folder+"/"+root_tag_dir+"/"+tag_dir)
                    print "success" 
except Exception, e:
    time.sleep(10)
    print e
    # create a folder to store the analyzed tags if it not exists
    if not os.path.exists(analyzed_folder+"/"+root_tag_dir+"_rejected"+"/"+tag_dir):
        subprocess.call(["mkdir", analyzed_folder+"/"+root_tag_dir+"_rejected"+"/"+tag_dir])
    os.rename(root_tag_dir+"/"+tag_dir, analyzed_folder+"/"+root_tag_dir+"_rejected"+"/"+tag_dir)
    # start the process again , as sonar could have been failed for no reason. not optmal I think
    subprocess.call(["python", "sonar_runner_automator.py"])
