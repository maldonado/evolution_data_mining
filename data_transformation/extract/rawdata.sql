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



select technical_debt, (coalesce((cast(replace(substring(technical_debt from '(^(([0-9]*)d)$)'),'d','') as integer )*24),0) +
 coalesce((cast(replace(substring(technical_debt from '\d*h$'),'h','') as integer )),0)) as calculated_technical_debt from rawdata;


// for date 

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
SQALE
 from rawdata 
where date NOT LIKE 'date' and 
complexity ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and 
lines_of_code ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' and
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
statements ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$' 




select to_date(date,'DD Mon YYYY') from rawdata where date NOT LIKE 'date'
select complexity from rawdata where complexity ~ '^([0-9]+\.?[0-9]*|\.[0-9]+)$'
