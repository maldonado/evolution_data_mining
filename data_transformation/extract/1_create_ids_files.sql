-- created to retrieve all snapshots ids grouped by id, necessary to extract data from sonar, through the scraper that navigates sonarqube.

--sonar put the projects in the projects table with the column scope = 'PRJ', then if this id is possible to retrieve all the snapshots. (versions)


-- 01 select all project ids 
select distinct(name), id from projects where scope = 'PRJ'

-- 02 single file with ids from previous query / remember to update the 1,2,3 ...
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id in (1,2,3 ...)) to '~/snapshot_all_ids.csv' (format csv);

--Multiple files 
--copy is used to export files from postgresql

copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_brackets_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_node_mysql_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_source-map_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_request_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_ember_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_grunt_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_less_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_coffescript_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_npm_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_bower_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_underscore_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_mocha_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_q_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_bootstrap_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = ) to '~/snapshot_mongoose_ids.csv' (format csv);




