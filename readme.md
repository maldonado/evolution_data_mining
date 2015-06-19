# Sonar analysis

## What it is ?

These scripts were built to extract all the tags from cloned git repositories, and analyze them into Sonarqube. First, it extracts all tags from a project in chronological order (oldest to latest). Second, it removes third part libraries using regular expressions. Third, it creates the sonar properties file used by Sonar Runner.  

## Requirements

1. Python 2.7 (virtual environment recommended)
2. Git
3. Configured Sonarqube
4. Configured Sonar runner

## How to use ?

1. Create a folder with all cloned repositories that you want to analyze.
2. Put a copy of run_git_tags.sh in this folder.
3. Put a copy of sonar_runner_automator.py in this folder. 
4. For each repository in this folder put a copy of sonar.py in its root folder.
5. Execute run_git_tags.sh.
```
    $ ./run_git_tags.sh
```

6. Execute sonar_runner_automator.py. 
```
    $ python sonar_runner_automator.py
```



