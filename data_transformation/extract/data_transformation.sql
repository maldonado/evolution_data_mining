-- Create tables

drop table rawdata

CREATE TABLE rawdata (
	project_name text,
	version text,
	release_date date,
	lines_of_code numeric,
	complexity numeric,
	comment_lines_density_percent numeric, 
    duplicated_lines_density numeric,
	issues numeric,
	complexity_file numeric, 
	complexity_function numeric, 
	comment_lines numeric, 
	duplicate_block numeric, 
	blocker_issues numeric, 
	critical_issues numeric, 
	major_issues numeric, 
	minor_issues numeric, 
	directories numeric, 
	functions numeric,
	statements numeric,
	SQALE text, 
	technical_debt text, 
	technical_debt_ratio numeric
)


-- metrics_data

drop table metrics_data;

CREATE TABLE metrics_data (
	project_name text,
	version text,
	release_date date,
	lines_of_code numeric,
	complexity numeric,
	comment_lines_density_percent numeric, 
	duplicated_lines_density numeric,
	issues numeric,
	complexity_file numeric, 
	complexity_function numeric, 
	comment_lines numeric, 
	duplicate_block numeric, 
	blocker_issues numeric, 
	critical_issues numeric, 
	major_issues numeric, 
	minor_issues numeric, 
	directories numeric, 
	functions numeric,
	statements numeric,
	SQALE text, 
	technical_debt_hours numeric, 
	technical_debt_ratio numeric
);

-- Populate metrics_data
INSERT INTO metrics_data (	
    project_name,
	version,
	release_date,
	lines_of_code,
	complexity,
	comment_lines_density_percent, 
    duplicated_lines_density,
	issues,
	complexity_file, 
	complexity_function, 
	comment_lines, 
	duplicate_block, 
	blocker_issues, 
	critical_issues, 
	major_issues , 
	minor_issues , 
	directories , 
	functions ,
	statements ,
	SQALE , 
	technical_debt_hours , 
	technical_debt_ratio )
	select 
	project_name,
	version,
	release_date,
	lines_of_code, 
	complexity,
	comment_lines_density_percent,
	duplicated_lines_density,
	issues,
	complexity_file,
	complexity_function,
	comment_lines,
	duplicate_block,
	blocker_issues,
	critical_issues,
	major_issues,
	minor_issues,
	directories,
	functions,
	statements,
	SQALE,
	(coalesce((cast(replace(substring(technical_debt from '(^(([0-9]*)d))'),'d','') as integer )*24),0) +  coalesce((cast(replace(substring(technical_debt from '\d*h$'),'h','') as integer )),0)) as technical_debt_hours,
	technical_debt_ratio
 	from rawdata 

--commit table
drop table commits

CREATE TABLE commits (
	project_name text,
	version text,
	commit_hash text,
	author_name text,
	author_date_unix_timestamp numeric,
	author_email text,
	author_date date,
	commit_message text,
	fix text,
	classification text, 
	linked text, 
	contains_bug text, 
	fixes text, 
	ns numeric,
	nd numeric,
	nf numeric,
	entrophy numeric,
	la numeric,
	ld numeric,
	fileschanged text,
	lt numeric,
	ndev numeric,
	age numeric, 
	nuc numeric,
	exp numeric,
	rexp numeric,
	sexp numeric,
	glm_probability numeric,
	repository_id text
); 

-- number of commits like bug fixes 
-- step1
drop table if exists number_of_corrective_changes;
CREATE TABLE number_of_corrective_changes (
  project_name text NOT NULL,
  version text,
  author_date date,
  number_of_corrections numeric default 0 
);
-- step2
insert into number_of_corrective_changes (project_name, version, author_date, number_of_corrections)
    select project_name, version, author_date, count(*) from commits  where classification like 'Corrective' group by 1,2,3 order by 1,3;

-- result
select * from number_of_corrective_changes where project_name like 'node-mongodb-native' order by 2,3;

-- number of commits like feature
-- step1
drop table if exists number_of_feature_addition_changes;
CREATE TABLE number_of_feature_addition_changes (
  project_name text NOT NULL,
  version text,
  author_date date,
  number_of_feature_addition numeric default 0
);
-- step2
insert into number_of_feature_addition_changes (project_name, version, author_date, number_of_feature_addition)
    select project_name, version, author_date, count(*) from commits  where classification like 'Feature Addition' group by 1,2,3 order by 1,3;

-- results
select * from number_of_feature_addition_changes where project_name like 'node-mongodb-native' order by 2,3;

-- spread  of changes per version 
-- step1
drop table if exists number_of_file_changes_per_version;
CREATE TABLE number_of_file_changes_per_version (
  project_name text NOT NULL,
  version text,
  author_date date,
  classification text, 
  commit_hash text, 
  file_list text,
  number_of_files_changed numeric default 0
);
-- step2
insert into number_of_file_changes_per_version (project_name, version, author_date, classification, commit_hash, file_list)
    select project_name, version, author_date, classification, commit_hash, fileschanged from commits where author_date is not null order by 1,2,3;
-- step3
-- run script 6_calculate_number_of_files_changed.py

-- results
select number_of_files_changed from number_of_file_changes_per_version where project_name like 'Chart.js' order by 2,3;

-- Calculating release density

-- step 1 
drop table if exists release_density
create table release_density (
	project_name text, 
	date_group date, 
	number_of_releases numeric
);

-- step 2
-- run script 7_function_density_time_frame.py


-- Calculating commits density

-- step 1 
drop table if exists commit_density
create table commit_density (
	project_name text, 
	date_group date, 
	number_of_commits numeric
);

-- step 2
-- run script 8_commit_density_time_frame.py

-- churn per bug fix
-- step1

drop table if exists churn_of_corrective_changes;
CREATE TABLE churn_of_corrective_changes (
  project_name text NOT NULL,
  version text,
  author_date date,
  classification text, 
  commit_hash text, 
  number_of_files_changed numeric,
  lines_added numeric,
  lines_deleted numeric,
  churn numeric
);

-- step2
insert into churn_of_corrective_changes (project_name, version, author_date, classification, commit_hash, lines_added, lines_deleted)
    select project_name, version, author_date, classification, commit_hash, la, ld from commits where author_date is not null order by 1,2,3;

-- step3
-- run script 9_calculate_churn_of_corrective_changes.py

-- results
select churn from churn_of_corrective_changes where project_name like 'Chart.js';

