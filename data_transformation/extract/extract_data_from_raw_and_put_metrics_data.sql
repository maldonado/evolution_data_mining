drop table rawdata

CREATE TABLE rawdata (
	project_name text,
	version text,
	date text,
	lines_of_codes text,
	complexity text,
	comment_lines_density_percent text, 
duplicated_lines_density text,
	issues text,
	complexity_file text, 
	complexity_function text, 
	comment_lines text, 
	duplicate_block text, 
	blocker_issues text, 
	critical_issues text, 
	major_issues text, 
	minor_issues text, 
	directories text, 
	functions text,
	statements text,
	SQALE text, 
	technical_debt text, 
	technical_debt_ratio text
)

------ Summary table

drop table metrics_data;

CREATE TABLE metrics_data (
	project_name text,
	version text,
	release_date date,
	lines_of_codes numeric,
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


select project_name,
version,
to_date(date,'DD Mon YYYY') as release_date,
cast(lines_of_codes as numeric), 
cast(complexity as numeric),
cast(replace(comment_lines_density_percent,'%','') as numeric),
cast(replace(duplicated_lines_density,'%','') as numeric),
cast(issues as numeric),
cast(complexity_file as numeric),
cast(complexity_function as numeric),
cast(comment_lines as numeric),
cast(duplicate_block as numeric),
cast(blocker_issues as numeric),
cast(critical_issues as numeric),
cast(major_issues as numeric),
cast(minor_issues as numeric),
cast(directories as numeric),
cast(functions as numeric),
cast(statements as numeric),
SQALE,
(coalesce((cast(replace(substring(technical_debt from '(^(([0-9]*)d))'),'d','') as integer )*24),0) +
 coalesce((cast(replace(substring(technical_debt from '\d*h$'),'h','') as integer )),0)) as technical_debt_hours,
cast (replace(technical_debt_ratio,'%','') as numeric)
 from rawdata 
where date NOT LIKE 'date' and 
complexity ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and 
lines_of_codes ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
replace(comment_lines_density_percent,'%','') ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
replace(duplicated_lines_density,'%','') ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
complexity_file ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
complexity_function ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'  and
comment_lines ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
duplicate_block ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'  and
blocker_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
critical_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
major_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'  and
minor_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
directories ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
functions ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
statements ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and 
technical_debt <> 'technical debt' and
replace(technical_debt_ratio,'%','') ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$';




INSERT INTO metrics_data (	project_name,
	version,
	release_date,
	lines_of_codes,
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

select project_name,
version,
to_date(date,'DD Mon YYYY') as release_date,
cast(lines_of_codes as numeric), 
cast(complexity as numeric),
cast(replace(comment_lines_density_percent,'%','') as numeric),
cast(replace(duplicated_lines_density,'%','') as numeric),
cast(issues as numeric),
cast(complexity_file as numeric),
cast(complexity_function as numeric),
cast(comment_lines as numeric),
cast(duplicate_block as numeric),
cast(blocker_issues as numeric),
cast(critical_issues as numeric),
cast(major_issues as numeric),
cast(minor_issues as numeric),
cast(directories as numeric),
cast(functions as numeric),
cast(statements as numeric),
SQALE,
(coalesce((cast(replace(substring(technical_debt from '(^(([0-9]*)d))'),'d','') as integer )*24),0) +
 coalesce((cast(replace(substring(technical_debt from '\d*h$'),'h','') as integer )),0)) as technical_debt_hours,
cast (replace(technical_debt_ratio,'%','') as numeric)
 from rawdata 
where date NOT LIKE 'date' and 
complexity ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and 
lines_of_codes ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
replace(comment_lines_density_percent,'%','') ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
replace(duplicated_lines_density,'%','') ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
complexity_file ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
complexity_function ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'  and
comment_lines ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
duplicate_block ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'  and
blocker_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
critical_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
major_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'  and
minor_issues ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
directories ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
functions ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
statements ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and 
technical_debt <> 'technical debt' and
replace(technical_debt_ratio,'%','') ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$';
