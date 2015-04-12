@cranberry
pg_dump -Fc -Ure re > ~/Desktop/re_full.dump
@fig
scp evertonmaldonado@cranberry:~/Desktop/re_full.dump ~/Dropbox/re_full.dump

drop table dataset_summary;
create table dataset_summary (
project_name text,
number_of_releases numeric,
first_release date,
last_release date,
days_between_first_and_last_release numeric,
number_of_commits numeric,
number_of_individual_developers numeric
);


INSERT INTO dataset_summary (
	project_name,
number_of_releases,
first_release,
last_release,
days_between_first_and_last_release)
select m.project_name,
count(*) as number_of_releases,
min(m.release_date) as first_release,
max(m.release_date) as last_release, 
max(m.release_date)-min(m.release_date) as days_between_first_and_last_release
from metrics_data as m 
group by m.project_name 
order by first_release;

update dataset_summary set number_of_commits= (select count(*) from commits where dataset_summary.project_name=commits.project_name group by project_name);
	update dataset_summary set number_of_individual_developers= (select count(distinct  author_email) from commits where dataset_summary.project_name=commits.project_name group by project_name);


 project_name | number_of_releases | first_release | last_release | days_between_first_and_last_release | number_of_commits 
--------------+--------------------+---------------+--------------+-------------------------------------+-------------------
 coffeescript |                 31 | 2010-04-12    | 2015-01-29   |                                1753 |              3967
 less.js      |                 38 | 2010-04-22    | 2015-01-28   |                                1742 |              2428
 npm          |                298 | 2010-05-02    | 2015-03-20   |                                1783 |              5509
 mongoose     |                197 | 2010-05-14    | 2015-03-28   |                                1779 |              4789
 underscore   |                 30 | 2010-06-14    | 2015-02-19   |                                1711 |              1985
 node-mysql   |                 38 | 2010-08-22    | 2015-03-24   |                                1675 |               914
 q            |                 48 | 2010-09-16    | 2014-11-22   |                                1528 |              3359
 request      |                 32 | 2011-01-30    | 2015-03-24   |                                1514 |              1644
 ember.js     |                 87 | 2011-06-17    | 2015-03-08   |                                1360 |              9150
 source-map   |                 29 | 2011-09-08    | 2015-03-02   |                                1271 |               396
 bootstrap    |                 27 | 2011-09-16    | 2015-01-19   |                                1221 |             11195
 mocha        |                 80 | 2011-11-08    | 2015-03-06   |                                1214 |              1702
 brackets     |                 60 | 2011-12-21    | 2015-02-11   |                                1148 |             15871
 bower        |                 65 | 2012-09-16    | 2015-03-30   |                                 925 |              1813
 grunt        |                  5 | 2013-02-18    | 2014-03-12   |                                 387 |              1309



select project_name, count(distinct  author_email) from commits group by project_name


-- data extraction total history extracted and total number of releases
select sum(days_between_first_and_last_release)/365 as total_years, sum(number_of_releases) as total_releases from dataset_summary;

     total_years     | total_releases
---------------------+----------------
 57.5643835616438356 |           1065


--summary for table details 
select project_name, first_release , last_release, days_between_first_and_last_release/365 as years,  number_of_releases, number_of_commits , number_of_individual_developers  from dataset_summary;



select project_name, min(release_date) from metrics_data group by 1;
 project_name |    min
--------------+------------
 coffeescript | 2010-04-12   
 less.js      | 2010-04-22   
 npm          | 2010-05-02   
 mongoose     | 2010-05-14   
 underscore   | 2010-06-14   
 node-mysql   | 2010-08-22   
 q            | 2010-09-16   
 request      | 2011-01-30   
 ember.js     | 2011-06-17   
 source-map   | 2011-09-08   
 bootstrap    | 2011-09-16   
 mocha        | 2011-11-08   
 brackets     | 2011-12-21   
 bower        | 2012-09-16   
 grunt        | 2013-02-18   
 

 --------------+--------------------+---------------+--------------+-------------------------------------+-------------------+---------------------------------
 coffeescript |                 31 | 2010-04-12    | 2015-01-29   |                                1753 |              3967 |                             202
 less.js      |                 38 | 2010-04-22    | 2015-01-28   |                                1742 |              2428 |                             218
 npm          |                298 | 2010-05-02    | 2015-03-20   |                                1783 |              5509 |                             278
 mongoose     |                197 | 2010-05-14    | 2015-03-28   |                                1779 |              4789 |                             215
 underscore   |                 30 | 2010-06-14    | 2015-02-19   |                                1711 |              1985 |                             242
 node-mysql   |                 38 | 2010-08-22    | 2015-03-24   |                                1675 |               914 |                              81
 q            |                 48 | 2010-09-16    | 2014-11-22   |                                1528 |              3359 |                             381
 request      |                 32 | 2011-01-30    | 2015-03-24   |                                1514 |              1644 |                             241
 ember.js     |                 87 | 2011-06-17    | 2015-03-08   |                                1360 |              9150 |                             587
 source-map   |                 29 | 2011-09-08    | 2015-03-02   |                                1271 |               396 |                              41
 bootstrap    |                 27 | 2011-09-16    | 2015-01-19   |                                1221 |             11195 |                             724
 mocha        |                 80 | 2011-11-08    | 2015-03-06   |                                1214 |              1702 |                             233
 brackets     |                 60 | 2011-12-21    | 2015-02-11   |                                1148 |             15871 |                             334
 bower        |                 65 | 2012-09-16    | 2015-03-30   |                                 925 |              1813 |                             159
 grunt        |                  5 | 2013-02-18    | 2014-03-12   |                                 387 |              1309 |                              54
 

-- generate table with metrics results
-- first version
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-04-12' and project_name='coffeescript';
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-04-22' and project_name='less.js'     ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-05-02' and project_name='npm'         ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-05-14' and project_name='mongoose'    ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-06-14' and project_name='underscore'  ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-08-22' and project_name='node-mysql'  ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2010-09-16' and project_name='q'           ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2011-01-30' and project_name='request'     ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2011-06-17' and project_name='ember.js'    ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2011-09-08' and project_name='source-map'  ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2011-09-16' and project_name='bootstrap'   ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2011-11-08' and project_name='mocha'       ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2011-12-21' and project_name='brackets'    ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2012-09-16' and project_name='bower'       ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2013-02-18' and project_name='grunt'       ; 
-- last version
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-01-29' and project_name='coffeescript';
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-01-28' and project_name='less.js'     ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-20' and project_name='npm'         ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-28' and project_name='mongoose'    ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-02-19' and project_name='underscore'  ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-24' and project_name='node-mysql'  ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2014-11-22' and project_name='q'           ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-24' and project_name='request'     ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-08' and project_name='ember.js'    ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-02' and project_name='source-map'  ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-01-19' and project_name='bootstrap'   ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-06' and project_name='mocha'       ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-02-11' and project_name='brackets'    ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2015-03-30' and project_name='bower'       ; 
select project_name, version, lines_of_codes, comment_lines, directories, functions, statements, complexity from metrics_data where release_date = '2014-03-12' and project_name='grunt'       ; 

-- number of single developers per version
-- first alter table to link commits to releases trough the release date
alter table commits add column version text
--then run python script link_version_commit.py

select a.project_name, a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version group by 1,2;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'coffeescript'  group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'less.js'       group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'npm'           group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'mongoose'      group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'underscore'    group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'node-mysql'    group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'q'             group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'request'       group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'ember.js'      group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'source-map'    group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'bootstrap'     group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'mocha'         group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'brackets'      group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'bower'         group by 1;
-- select a.release_date, count(distinct(b.author_login)) from metrics_data a, commits b where a.project_name = b.project_name and a.version = b.version and a.project_name = 'grunt'         group by 1;


-- function_density
-- after running function density time frame in python
select * from function_density where density != 0 and project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap')
-- select project_name,  max(functions/lines_of_codes*100) as function_density from metrics_data  group by 1 order by 2;
--  project_name |    function_density
-- --------------+-------------------------
--  *source-map   | 10.21416803953871499200
--  -- node-mysql   | 10.74404761904761904800
--  -- request      | 12.22094654930475826000
--  -- grunt        | 13.03511303511303511300
--  -- npm          | 14.24213984045049272600
--  -- ember.js     | 15.84088157949659807200
--  -- mongoose     | 18.05054151624548736500
--  -- bower        | 18.45082680591818973000
--  -- coffeescript | 19.59446285825697017000
--  -- brackets     | 20.81007813745814064700
--  -- less.js      | 22.75217319993439396400
--  -- q            | 29.15360501567398119100
--  -- underscore   | 33.42082239720034995600
--  -- mocha        | 37.74425779910867329400
--  *bootstrap    | 40.69210292812777284800

-- density of releases by month -- 
--run python script release_density_time_frame
select * from release_density where number_of_releases != 0 and project_name in ('source-map', 'grunt', 'mongoose', 'brackets','bootstrap')
 -- select count(version), extract(month from release_date) as month , extract(year from release_date) as year from metrics_data where project_name='brackets' group by 2,3 order by 3,2;
 -- select count(version), extract(month from release_date) as month , extract(year from release_date) as year from metrics_data where project_name='npm' group by 2,3 order by 3,2;

-------------+-------+-------+------
 brackets     |     1 |    12 | 2011
 brackets     |     1 |     1 | 2012
 brackets     |     1 |     2 | 2012
 brackets     |     3 |     3 | 2012
 brackets     |     3 |     4 | 2012
 brackets     |     1 |     5 | 2012
 brackets     |     2 |     6 | 2012
 brackets     |     1 |     7 | 2012
 brackets     |     2 |     8 | 2012
 brackets     |     1 |     9 | 2012
 brackets     |     1 |    10 | 2012
 brackets     |     2 |    11 | 2012
 brackets     |     1 |    12 | 2012
 brackets     |     1 |     1 | 2013
 brackets     |     1 |     2 | 2013
 brackets     |     2 |     3 | 2013
 brackets     |     2 |     4 | 2013
 brackets     |     1 |     5 | 2013
 brackets     |     2 |     6 | 2013
 brackets     |     1 |     7 | 2013
 brackets     |     4 |     8 | 2013
 brackets     |     2 |     9 | 2013
 brackets     |     2 |    10 | 2013
 brackets     |     2 |    11 | 2013
 brackets     |     4 |    12 | 2013
 brackets     |     1 |     2 | 2014
 brackets     |     1 |     3 | 2014
 brackets     |     1 |     4 | 2014
 brackets     |     1 |     6 | 2014
 brackets     |     1 |     7 | 2014
 brackets     |     1 |     8 | 2014
 brackets     |     3 |     9 | 2014
 brackets     |     4 |    10 | 2014
 brackets     |     1 |    12 | 2014
 brackets     |     1 |     1 | 2015
 brackets     |     1 |     2 | 2015

-- number of reported issues per releasereleases
alter table issues add column version text
--then run python script for linking issues
select a.project_name, a.release_date, count(*) from metrics_data a, issues b where a.project_name = b.project_name and a.version = b.version group by 1,2