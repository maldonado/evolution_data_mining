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

