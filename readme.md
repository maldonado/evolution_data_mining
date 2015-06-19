# Sonar analysis

## What it is ?

These scripts were built to extract all the tags from cloned git repositories, and analyze them into Sonarqube. First, it extracts all tags from a project in chronological order (oldest to latest). Second, it removes third part libraries using regular expressions. Third, it creates the sonar properties file used by Sonar Runner. 

The tags will be analyzed in chronological order into Sonarqube. The date of the analysis will be the same date of the tag, so will be possible to observe the nuances of the project over time. However, if there are two or more tags in the same day only the first one will be analyzed in Sonarqube. The process will create separated folders for the tags processed with success and the ones rejected for each project. If you need to stop sonar_runner_automator.py process it will resume from the point that it was interrupted.

## Requirements

1. Python (virtual environment recommended, requirements.txt provided)
2. Git
3. Configured Sonarqube
4. Configured Sonar runner

## How to use ?

1. Create a folder with all cloned repositories that you want to analyze.
2. Put a copy of run_git_tags.sh in this folder.
3. Put a copy of sonar_runner_automator.py in this folder. 
4. For each repository in this folder put a copy of sonar.py in its root folder.
5. Execute run_git_tags.sh. In the terminal paste the following line (without the `$`)

    $ ./run_git_tags.sh

6. Execute sonar_runner_automator.py. In the terminal paste the following line (without the `$`). 
    
    $ python sonar_runner_automator.py
