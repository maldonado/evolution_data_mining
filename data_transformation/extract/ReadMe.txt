Remember to use nvm (node version management) for using all the things related to JavaScript.

1 - create ids files. (create_ids_files.sql)
2 - create cvs files (sonar_data_file_generator.js) 
3 - create raw_data table (data_transformation.sql) 
4 - insert the data in raw_data (import_scraped_data.py)
5 - create metrics_data table (data_transformation.sql) 
6 - insert data to metrics_data (data_transformation.sql)
7 - drop table commits if it exists (data_transformation.sql)
8 - create commits table (data_transformation.sql)
9 - put script 4_link_version_commit.py in the repository folder
10 - link the commits and versions executing 4_link_version_commit.py
11 - download the csv file from commit guru and paste it in: evolution_data_mining/data_transformation/extract/commit_guru_csv
12 - put the csv file name in the script 5_import_commit_guru_data.py and execute it.


Continuing change: Number of commits (like bug fixes), Interface Changes

Increasing complexity: Evolution of complexity

Continuing Growth: LOC , Release Density, Number of Commits, Feature additions

Declining Quality: Churn to fix a bug, Spread of changes (From commit guru),  Code Smells reported by SonarQube (Or find bugs)

Comparison table  (prior work vs java vs JavaScript)