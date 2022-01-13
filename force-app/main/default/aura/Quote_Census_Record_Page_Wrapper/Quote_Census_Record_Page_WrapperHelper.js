/**
 * Created by varun on 2/22/2021.
 */

({
    initQuoteCensus: function(component, event, helper) {
            helper = this;
            var attlistjson = {};
            var querymap = {};
            var sObjectName = 'Quote_Census__c';
            var sObjectId = component.get("v.recordId") == undefined? '' : component.get('v.recordId');
            // Initialize Component Through Chained Promise Execution
            // 1. Fetch Record Type,  2. Init Taskflow List, 3. Create Task list components
            component.set("v.showspinner", true);
            querymap['object'] = sObjectName;
            querymap['queryFields'] = 'Date_Of_Birth__c,Employee_Number__c, Name, Gender__c, Last_Name__c,Quote__c, Relation__c, Status__c, Tobacco_Use__c';
            querymap['searchField'] = 'Quote__c';
            querymap['searchTerm'] = sObjectId;
            var getRecordNameAction = component.get("c.getRecords");
            getRecordNameAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getRecordNamePromise = helper.executePromisedAction(component, getRecordNameAction);
            getRecordNamePromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            var objectLst = responsedata[sObjectName];
                            component.set("v.quotecensus", objectLst);
                            component.set("v.showspinner", false);
                        } else {
                            console.log("Task List Initalization Promise Chain Failed With Error: " + responsemsg.errMsg);
                            component.set("v.showspinner", false);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Quote Census Initalization Promise Chain Failed With Error: " + error.message);
                        component.set("v.showspinner", false);
                    })
                );
        },

        getColumns : function(component, event, helper){
            var columns = [{
                            label: 'Employee Number',
                            fieldName: 'Employee_Number__c',
                            type: 'text',
                            colIdx : 0
                        },
                        {
                            label: 'Relation',
                            fieldName: 'Relation__c',
                            type: 'text',
                            colIdx : 1
                        },
                        {
                            label: 'First Name',
                            fieldName: 'Name',
                            type: 'text',
                            colIdx : 2
                        },
                        {
                            label: 'Last Name',
                            fieldName: 'Last_Name__c',
                            type: 'text',
                            colIdx : 3
                        },
                        {
                            label: 'Date of Birth',
                            fieldName: 'Date_Of_Birth__c',
                            type: 'text',
                            colIdx : 4
                        }
                    ];
                    return columns;
        },

         downloadCSVFile : function(component, event, helper) {
            var gridColumns = helper.getColumns(component, event, helper);
            var gridRows = component.get("v.quotecensus");
            var downloadFileName = "Quote_Census.csv"
            // 6. CSV download.
            var csvHeaders = [];
            gridColumns.forEach(function(gridColumn){
                if(!$A.util.isUndefinedOrNull(gridColumn.label)){
                   csvHeaders.push(gridColumn.label)
                }
            });
            var columnOrderMap = {};
            var idx = 0;
            var emptyRow = [];
            while (idx < gridColumns.length){
               if(!$A.util.isUndefinedOrNull(gridColumns[idx].fieldName)){
                   columnOrderMap[gridColumns[idx].fieldName] =  idx;
                   emptyRow.push('');
               }
               idx++;
            }

            var csv = csvHeaders.join(',');
            csv += "\n";

            gridRows.forEach(function(gridRow){
              var row = emptyRow;
              for(var key in columnOrderMap){
                  console.log(gridRow["" + key + ""]);
                  console.log(key);
                  if(!$A.util.isUndefinedOrNull(gridRow["" + key + ""])){
                    row.splice(columnOrderMap[key] , 1 ,gridRow["" + key + ""].includes(',') === true ? '"' + gridRow["" + key + ""] + '"' : gridRow["" + key + ""] );
                  }
              }
               csv += row.join(",");
               csv += "\n";
            });

            // 6. To download table in CSV format.
            var hiddenElement = document.createElement('a');
            hiddenElement.href = 'data:text/csv;charset=utf-8,' + encodeURI(csv);
            hiddenElement.target = '_blank';
            hiddenElement.download = downloadFileName +'.csv';
            hiddenElement.click();
        },

        //Executes Server side actions through a promise wrapper
        executePromisedAction: function(component, action, callback) {
            return new Promise(function(resolve, reject) {
                action.setCallback(this, function(response) {
                    var state = response.getState();
                    if (state === "SUCCESS") {
                        var retVal = response.getReturnValue();
                        resolve(retVal);
                    } else if (state === "ERROR") {
                        var errors = response.getError();
                        if (errors) {
                            if (errors[0] && errors[0].message) {
                                reject(Error("Error Message: " + errors[0].message));
                            } else {
                                reject(Error("Unknown Server Error"));
                            }
                        } else {
                            reject(Error("Unknown Error"));
                        }
                    }
                });
                $A.enqueueAction(action);
            });
        },
});