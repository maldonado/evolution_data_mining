
var jsdom = require("jsdom");
var S = require('string');
var fs = require('fs');
var lineReader = require('line-reader');

    var pathToFile = '3.csv';
//var stream = fs.createReadStream("snapshot_ids.csv");


var baseUrl='http://localhost:9000/';
var projectUrl;

var writeStream = fs.createWriteStream("metrics3.csv");
var jquery = fs.readFileSync("jquery.js", "utf-8");
start();

function start(){


  inspectWeb(baseUrl,function($){
    var header="project name,"+
    "version,"+
    "date,"+
    "lines of code,"+
    "complexity,"+
    "comment lines density%,"+
    "duplicated lines density%,"+
    "issues,"+
    "complexity/file,"+
    "complexity/function,"+
    "comment lines,"+
    "duplicated blocks,"+
    "blocker issues,"+
    "critical issues,"+
    "major issues,"+
    "minor issues,"+
    "directories,"+
    "functions,"+
    "statements,"+
    "SQALE rating,"+
    "technical debt,"+
    "technical debt ratio"+
     "\n";
    writeStream.write(header);
    inspectWithinEachProject();
   // $("#measures-table").find('tbody').find('tr a').each(function(){
    //  inspectWithinEachProject( $(this).attr('title'),$(this).attr('href'));
    //});

  });
  }

function inspectWithinEachProject(){
 // console.log('inspect web');
//  console.log('Project Name:'+ projectName+' | '+ projectUrl);
 // inspectWeb('http://localhost:9000/comparison/index?resource='+projectName,function($){

lineReader.eachLine(pathToFile, function(line, last) {
  
//console.log(line);
extractDataLineByLine(line);
       
     });    
  var extractDataLineByLine=function(line){
       var sids=line;
    var customizedUrl=baseUrl+'comparison/index?sids='+sids+'&metrics=ncloc%2Ccomplexity%2Ccomment_lines_density%2Cduplicated_lines_density%2Cviolations%2Cfile_complexity%2Cfunction_complexity%2Ccomment_lines%2Cduplicated_blocks%2Cblocker_violations%2Ccritical_violations%2Cmajor_violations%2Cminor_violations%2Cdirectories%2Cfunctions%2Cstatements%2Csqale_rating%2Csqale_index%2Csqale_debt_ratio';
    // Actual page for extracting data
    inspectWeb(customizedUrl,function($){
      //console.log(customizedUrl+'\n');
      var table=$(".data");
      var numberOfVersions=table.find('thead').find('tr#resource-info-header').find('th');

      for (var index=1;index<numberOfVersions.size()-1;index++){
        var spans=$(numberOfVersions[index]).find('span>span');
        var projectName=($(numberOfVersions[index]).find('span>a').text());
          var versionNumber=spans.first().text();
          var versionDate=spans.last().text();
          var lineToWrite=projectName+','+versionNumber+','+versionDate;
          console.log('Sids:'+line+ ' Project name:'+projectName+ ' Version number:'+versionNumber+' and Version date:'+ versionDate);
          //extract data from each column
          table.find('tbody').find('tr').each(function(){
            $(this).find('span').each(function(innerIndex){
              if (index==(innerIndex+1))
              {
                var metricValue=$(this).text().replace(',','');
                lineToWrite+=','+metricValue;
              }
            })

          });
          writeStream.write(lineToWrite+"\n");
      }

    });  
};



 // });
}

function inspectWeb(conf_url, callback){
  jsdom.env({
    url:conf_url,
   
    done: function (errors, window) {
      //var $ = window.$;
       var $ = require('jquery')(window);
      callback($);
    }
  });
}
