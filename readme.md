#Data Mining process

*[Clone Github repositories and analyze them in Sonarqube](https://github.com/maldonado/soen691e#sonar-analysis)
*[Use Github API to extract data](https://github.com/maldonado/soen691e#github-api-data-extraction)
*[Use different scripts to manipulate data and extract results](https://github.com/maldonado/soen691e#data-transformation-and-analysis)

## Sonar analysis

### What it is ?

These scripts were built to extract all the tags from cloned git repositories, and analyze them into Sonarqube. First, it extracts all tags from a project in chronological order (oldest to latest). Second, it removes third part libraries using regular expressions. Third, it creates the sonar properties file used by Sonar Runner. 

The tags will be analyzed in chronological order into Sonarqube. The date of the analysis will be the same date of the tag, so will be possible to observe the nuances of the project over time. However, if there are two or more tags in the same day only the first one will be analyzed in Sonarqube. The process will create separated folders for the tags processed with success and the ones rejected for each project. If you need to stop sonar_runner_automator.py process it will resume from the point that it was interrupted.

### Requirements

* Python (virtual environment recommended, requirements.txt provided)
* Git
* Configured Sonarqube
* Configured Sonar runner

If Python or Virtual Environment is not installed you can find instructions [here](http://docs.python-guide.org/en/latest/starting/install/osx/).

### How to use ?
(The mentioned scripts below are located in sonar_analysis folder)

1. Create a folder with all cloned repositories that you want to analyze.
2. Put a copy of run_git_tags.sh in the created folder .
3. Put a copy of sonar_runner_automator.py in the created folder. 
4. For each repository in this folder put a copy of sonar.py in its root folder.
5. Execute run_git_tags.sh. In the terminal paste the following line (without the `$`).
``` 
$ ./run_git_tags.sh 
```
6. Execute sonar_runner_automator.py. In the terminal paste the following line (without the `$`). 
``` 
$ python sonar_runner_automator.py 
```

## Github API Data Extraction

### What it is ?

These scripts uses the Github API to extract information about commits and issues. First, it requests the issues/commits from github and store the response in a json file. One project can have several files as response of this process because Github API provides this data paginated. Second, it reads the json files in your local machine and stores it in a database for further analysis. 

### Requirements
* Python (virtual environment recommended, requirements.txt provided)
* Git
* Valid GitHub OAuth token, click [here](https://gist.github.com/maldonado/88cd34deef8bff4c9779) for instructions.

If Python or Virtual Environment is not installed you can find instructions [here](http://docs.python-guide.org/en/latest/starting/install/osx/).

### How to use ?
(The mentioned scripts below are located in github_data_extraction folder)

#### Extracting commits

1. Create a folder to place the extracted commits. 
2. Edit the request_commits.py script adding the path to the commits folder and your OAuth token.
3. Execute request_commits.py passing the user name of the owner of the repository fallowed by the name of the repository. For example, to extract all commits from bootstrap :
``` 
$ python request_commits.py twbs bootstrap
```
To insert the extracted data into the database:

1. Edit commit_data_parser.py adding the path to the folder where the json files are. 
2. Execute commit_data_parser.py passing the name of the project as an argument. 
``` 
$ python commit_data_parser.py bootstrap
```

#### Extracting issues

6. Create a folder to place the extracted issues. 
7. Edit the request_issues.py script adding the path to the issues folder and your OAuth token.
8. Execute request_issues.py passing the user name of the owner of the repository fallowed by the name of the repository. For example, to extract all commits from bootstrap :
``` 
$ python request_issues.py twbs bootstrap
```
To insert the extracted data into the database:

1. Edit issue_data_parser.py adding the path to the folder where the json files are. 
2. Execute issue_data_parser.py passing the name of the project as an argument. 
``` 
$ python issue_data_parser.py bootstrap
```

##Data transformation and analysis

Contains several scripts (python and sql) data extract results and manipulates raw data. The scripts are located in data_transformation folder.
