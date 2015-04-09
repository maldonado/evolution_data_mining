-- created to retrieve all snapshots ids grouped by id, necessary to extract data from sonar, through the scraper that navigates sonarqube.

--sonar put the projects in the projects table with the column scope = 'PRJ', then if this id is possible to retrieve all the snapshots. (versions)
-- select all project ids 
select distinct(name), id from projects where scope = 'PRJ'

     name     |  id
--------------+-------
* brackets     | 13250
* mongoose     | 12628
* node-mysql   | 17792
* source-map   | 13200
 backbone     | 16665 not used
* request      | 17082
* ember.js     | 14317
* grunt        | 16693
 prototype    | 17661 not used
 node_redis   | 16678 not used
* less.js      | 12893
* coffeescript | 16756
* npm          | 17255
* bower        | 16897
* underscore   | 13184
* mocha        | 16489
* q            | 17181
* bootstrap    | 16396

--Multiple files 
--copy is used to export files from postgresql

copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 13250) to '/var/lib/postgresql/snapshot_brackets_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 17792) to '/var/lib/postgresql/snapshot_node_mysql_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 13200) to '/var/lib/postgresql/snapshot_source-map_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 17082) to '/var/lib/postgresql/snapshot_request_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 14317) to '/var/lib/postgresql/snapshot_ember_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 16693) to '/var/lib/postgresql/snapshot_grunt_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 12893) to '/var/lib/postgresql/snapshot_less_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 16756) to '/var/lib/postgresql/snapshot_coffescript_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 17255) to '/var/lib/postgresql/snapshot_npm_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 16897) to '/var/lib/postgresql/snapshot_bower_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 13184) to '/var/lib/postgresql/snapshot_underscore_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 16489) to '/var/lib/postgresql/snapshot_mocha_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 17181) to '/var/lib/postgresql/snapshot_q_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 16396) to '/var/lib/postgresql/snapshot_bootstrap_ids.csv' (format csv);
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id = 12628) to '/var/lib/postgresql/snapshot_mongoose_ids.csv' (format csv);


-- multiple files number of versions copied to each one
COPY 60
COPY 38
COPY 29
COPY 32
COPY 87
COPY 5
COPY 38
COPY 31
COPY 298
COPY 65
COPY 30
COPY 80
COPY 48
COPY 29
COPY 197

-- single file
--copy is used to export files from postgresql
copy (select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id in (13250, 17792,13200,13200,17082,14317,16693,12893,16756,17255,16897,13184,16489,17181,16396,12628)) to '/var/lib/postgresql/snapshot_all_ids.csv' (format csv);


select b.id from projects a , snapshots b where a.id = b.project_id and b.project_id in (13250, 17792,13200,13200,17082,14317,16693,12893,16756,17255,16897,13184,16489,17181,16396,12628) and b.version = '%,%'
