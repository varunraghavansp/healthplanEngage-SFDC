/**
 * Created by varun on 2/22/2021.
 */

({
    initQuoteClaims: function(component, event, helper) {
        helper = this;
        var attlistjson = {};
        var querymap = {};
        var sObjectName = 'Quote_Request_Claim_Summary__c';
        var medicalClaimSummary = component.get("v.medicalClaimSummary");
        var rxClaimSummary = component.get("v.rxClaimSummary");
        var sObjectId = component.get("v.recordId") == undefined? '' : component.get('v.recordId');
        // Initialize Component Through Chained Promise Execution
        // 1. Fetch Record Type,  2. Init Taskflow List, 3. Create Task list components
        component.set("v.showspinner", true);
        querymap['object'] = sObjectName;
        querymap['queryFields'] = 'Average_Enrolled_Members__c,Average_Enrolled_Subscribers__c, Billed_Premium__c, Capitation__c, Claims__c,Experience_Period_From__c, Experience_Period_Through__c, High_Level_Claims__c, Medical_Loss_Ratio__c, Quote__c, Name, Type__c';
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
                        objectLst.forEach(function(claimHistoryRow){
                            if(claimHistoryRow["Type__c"] === "Medical"){
                                medicalClaimSummary = claimHistoryRow;
                            }else{
                                rxClaimSummary = claimHistoryRow;
                            }
                        })
                        component.set("v.medicalClaimSummary", medicalClaimSummary);
                        component.set("v.rxClaimSummary", rxClaimSummary);


                        querymap['object'] = 'Quote_Request_Claim_History__c';
                        querymap['queryFields'] = 'Claim_From__c,Claim_Reimbursement__c, Claim_Through__c, ICD10__c, Physician_NPN__c,Quote__c, Type__c, Name';
                        querymap['searchField'] = 'Quote__c';
                        querymap['searchTerm'] = sObjectId;
                        var getQuoteClaimsAction = component.get("c.getRecords");
                        getQuoteClaimsAction.setParams({
                            "jsonString": JSON.stringify(querymap)
                        });
                        var getQuoteClaimsPromise = helper.executePromisedAction(component, getQuoteClaimsAction);
                        return getQuoteClaimsPromise;


                    } else {
                        console.log("Initalization Promise Chain Failed With Error: " + responsemsg.errMsg);
                        component.set("v.showspinner", false);
                    }
                })
            )
            .then(
                $A.getCallback(function(result) {
                var responsemsg = JSON.parse(result);
                var isSuccess = responsemsg.isSuccess;
                if (isSuccess == true) {
                    var responsedata = responsemsg.results.data[0];
                    var quoteClaimHistory = responsedata['Quote_Request_Claim_History__c'];
                    component.set("v.quoteClaimHistory", quoteClaimHistory);
                    var claimDates = [];
                    quoteClaimHistory.forEach(function(claimHistoryRow){
                        claimDates.push(new Date(claimHistoryRow.Claim_From__c));
                        claimDates.push(new Date(claimHistoryRow.Claim_Through__c));
                    });
                    var maxDate=new Date(Math.max.apply(null,claimDates));
                    var minDate=new Date(Math.min.apply(null,claimDates));
                    component.set("v.Experience_Period_From__c" , $A.localizationService.formatDate(minDate.getFullYear() + "-" + minDate.getMonth() + "-" + "1" ));
                    component.set("v.Experience_Period_To__c" ,$A.localizationService.formatDate(maxDate.getFullYear() + "-" + maxDate.getMonth() + "-" + "1" ));
                    //Set Chart Data
                    var medicalclaimsChartData = [];
                    var rxClaimsChartData = [];
                    for (var d = minDate; d <= maxDate; d.setMonth(d.getMonth() + 1)) {
                        medicalclaimsChartData.push({"x": new Date(d), "y": 0.00});
                        rxClaimsChartData.push({"x": new Date(d), "y": 0.00});
                    }

                    //Add Medical
                    quoteClaimHistory.forEach(function(claimHistoryRow){
                        var claimHistoryRowMonth = new Date(claimHistoryRow.Claim_From__c).getMonth();
                        var claimType = claimHistoryRow.Type__c;
                        medicalclaimsChartData.forEach(function(claimMonthChartRow){
                           var claimMonth = claimMonthChartRow["x"].getMonth();
                           if(claimMonth === claimHistoryRowMonth && claimType === 'Medical'){
                               claimMonthChartRow["y"] +=  parseInt(claimHistoryRow["Claim_Reimbursement__c"]);
                           }
                        });
                    });
                    //Add RX
                    quoteClaimHistory.forEach(function(claimHistoryRow){
                        var claimHistoryRowMonth = new Date(claimHistoryRow.Claim_From__c).getMonth();
                        var claimType = claimHistoryRow.Type__c;
                        rxClaimsChartData.forEach(function(claimMonthChartRow){
                           var claimMonth = claimMonthChartRow["x"].getMonth();
                           if(claimMonth === claimHistoryRowMonth && claimType === 'RX'){
                               claimMonthChartRow["y"] +=  parseInt(claimHistoryRow["Claim_Reimbursement__c"]);
                           }
                        });
                    });
                    medicalclaimsChartData.forEach(function(claimMonthChartRow){
                        claimMonthChartRow["x"] = claimMonthChartRow["x"].getFullYear() + '-' + (claimMonthChartRow["x"].getMonth() + 1 < 10 ? "0" + (claimMonthChartRow["x"].getMonth() + 1) : claimMonthChartRow["x"].getMonth() + 1);
                    });
                    rxClaimsChartData.forEach(function(claimMonthChartRow){
                     claimMonthChartRow["x"] = claimMonthChartRow["x"].getFullYear() + '-' + (claimMonthChartRow["x"].getMonth() + 1 < 10 ? "0" + (claimMonthChartRow["x"].getMonth() + 1) : claimMonthChartRow["x"].getMonth() + 1);
                    });
                    component.set("v.medicalclaimsChartData",medicalclaimsChartData );
                    console.log(JSON.stringify(medicalclaimsChartData));
                    console.log(JSON.stringify(rxClaimsChartData));
                    component.set("v.rxClaimsChartData",rxClaimsChartData );
                    helper.initializeCharts(component);
                    component.set("v.showspinner", false);
                }
                else {
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
            )
    },


    createClaimsSummary : function(component) {
            var quoteClaimHistory = component.get("v.quoteClaimHistory");
            var quote = component.get("v.quote");
            var disabled = component.get("v.disableFields");
            var medicalClaimSummary = {};
            var rxClaimSummary = {};

            var claimDates = [];
            var totalClaims = 0.00;
            var totalMedicalClaims = 0.00;
            var totalRxClaims = 0.00;
            quoteClaimHistory.forEach(function(claimHistoryRow){
                claimDates.push(new Date(claimHistoryRow.Claim_From__c));
                claimDates.push(new Date(claimHistoryRow.Claim_Through__c));
                if(claimHistoryRow.Type__c === 'Medical'){
                    medicalClaimSummary["Claims__c"] += parseInt(claimHistoryRow.Claim_Reimbursement__c);
                    if(parseInt(claimHistoryRow.Claim_Reimbursement__c) >= 10000){
                        medicalClaimSummary["High_Level_Claims__c"] += parseInt(claimHistoryRow.Claim_Reimbursement__c);
                    }
                } else if(claimHistoryRow.Type__c === 'RX'){
                    rxClaimSummary["Claims__c"] += parseInt(claimHistoryRow.Claim_Reimbursement__c);
                    if(parseInt(claimHistoryRow.Claim_Reimbursement__c) >= 10000){
                        rxClaimSummary["High_Level_Claims__c"] += parseInt(claimHistoryRow.High_Level_Claims__c);
                    }
                }
                totalClaims += parseInt(claimHistoryRow.Claim_Reimbursement__c);
            });

            var maxDate=new Date(Math.max.apply(null,claimDates));
            var minDate=new Date(Math.min.apply(null,claimDates));

            component.set("v.Experience_Period_From__c" , $A.localizationService.formatDate(minDate.getFullYear() + "-" + minDate.getMonth() + "-" + "1" ));
            component.set("v.Experience_Period_To__c" ,$A.localizationService.formatDate(maxDate.getFullYear() + "-" + maxDate.getMonth() + "-" + "1" ));
            /*rxClaimSummary["Experience_Period_From__c"] =  minDate.getFullYear() + "-" + minDate.getMonth() + "-" + "01";
            rxClaimSummary["Experience_Period_Through__c"] = maxDate.getFullYear() + "-" + maxDate.getMonth() + "-" + "01";*/

            //Set Chart Data
            var medicalclaimsChartData = [];
            var rxClaimsChartData = [];
            for (var d = minDate; d <= maxDate; d.setMonth(d.getMonth() + 1)) {
                medicalclaimsChartData.push({"x": new Date(d), "y": 0.00});
                rxClaimsChartData.push({"x": new Date(d), "y": 0.00});
            }
            //Add Medical
            quoteClaimHistory.forEach(function(claimHistoryRow){
                var claimHistoryRowMonth = new Date(claimHistoryRow.Claim_From__c).getMonth();
                var claimType = claimHistoryRow.Type__c;
                medicalclaimsChartData.forEach(function(claimMonthChartRow){
                    var claimMonth = claimMonthChartRow["x"].getMonth();
                    if(claimMonth === claimHistoryRowMonth && claimType === 'Medical'){
                        claimMonthChartRow["y"] +=  parseInt(claimHistoryRow["Claim_Reimbursement__c"]);
                    }
                });
            });
            //Add RX
            quoteClaimHistory.forEach(function(claimHistoryRow){
                var claimHistoryRowMonth = new Date(claimHistoryRow.Claim_From__c).getMonth();
                var claimType = claimHistoryRow.Type__c;
                rxClaimsChartData.forEach(function(claimMonthChartRow){
                    var claimMonth = claimMonthChartRow["x"].getMonth();
                    if(claimMonth === claimHistoryRowMonth && claimType === 'RX'){
                        claimMonthChartRow["y"] +=  parseInt(claimHistoryRow["Claim_Reimbursement__c"]);
                    }
                });
            });
            medicalclaimsChartData.forEach(function(claimMonthChartRow){
                claimMonthChartRow["x"] = claimMonthChartRow["x"].getFullYear() + '-' + (claimMonthChartRow["x"].getMonth() + 1 < 10 ? "0" + (claimMonthChartRow["x"].getMonth() + 1) : claimMonthChartRow["x"].getMonth() + 1);
            });
            rxClaimsChartData.forEach(function(claimMonthChartRow){
                claimMonthChartRow["x"] = claimMonthChartRow["x"].getFullYear() + '-' + (claimMonthChartRow["x"].getMonth() + 1 < 10 ? "0" + (claimMonthChartRow["x"].getMonth() + 1) : claimMonthChartRow["x"].getMonth() + 1);
            });
            component.set("v.medicalclaimsChartData",medicalclaimsChartData );
            console.log(JSON.stringify(medicalclaimsChartData));
            console.log(JSON.stringify(rxClaimsChartData));
            component.set("v.rxClaimsChartData",rxClaimsChartData );
            component.set("v.medicalClaimSummary", medicalClaimSummary);
            component.set("v.rxClaimSummary", rxClaimSummary);
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

    initializeCharts : function(component){
        var medicalClaimSummary = component.get("v.medicalClaimSummary");
        var rxClaimSummary = component.get("v.rxClaimSummary");

        var medicalBilledPremium = parseInt(medicalClaimSummary.Billed_Premium__c);
        var rxBilledPremium = parseInt(rxClaimSummary.Billed_Premium__c);
        if(medicalBilledPremium > 0 && rxBilledPremium > 0){
            var totalBilledPremium = medicalBilledPremium + rxBilledPremium;
            var medicalClaims = parseInt(medicalClaimSummary.Claims__c) + parseInt(medicalClaimSummary.Capitation__c);
            var rxClaims = parseInt(rxClaimSummary.Claims__c) + parseInt(rxClaimSummary.Capitation__c);
            var totalClaims = medicalClaims + rxClaims;
            var medicalLossRatio = 100 - (((medicalBilledPremium - medicalClaims ) / medicalBilledPremium) * 100);
            var rxLossRatio = 100 - (((rxBilledPremium - rxClaims  ) / rxBilledPremium) * 100);

            var totalLossRatio = 100 - ((( totalBilledPremium - totalClaims  ) / totalBilledPremium) * 100);
            var averageMedicalMonthlyPremium = medicalBilledPremium/12;
            var averageRXMonthlyPremium = rxBilledPremium/12;
            medicalClaimSummary["Medical_Loss_Ratio__c"] = medicalLossRatio;
            rxClaimSummary["Medical_Loss_Ratio__c"] = rxLossRatio;
            component.set("v.medicalClaimSummary", medicalClaimSummary);
            component.set("v.rxClaimSummary", rxClaimSummary);
            component.set("v.averageMedicalMonthlyPremium", averageMedicalMonthlyPremium );
            component.set("v.averageRXMonthlyPremium", averageRXMonthlyPremium );

            var medicalClaimsDonutData = [
              {"segment": "Medical Claims", "value": medicalClaims},
              {"segment": "Rem. After Claims", "value": medicalBilledPremium - medicalClaims }
            ];
            var rxClaimsDonutData = [
              {"segment": "RX Claims", "value": rxClaims},
              {"segment": "Rem. After Claims", "value": rxBilledPremium - rxClaims }
            ];

            component.set("v.medicalClaimsDonutData", medicalClaimsDonutData);
            component.set("v.rxClaimsDonutData", rxClaimsDonutData);
        }else{
            alert("Please Enter the Billed Premiums to Calculate MLR");
        }
    },

    getColumns : function(component, event, helper){

                var columns = [{
                                label: 'Claim From',
                                fieldName: 'Claim_From__c',
                                type: 'text',
                                colIdx : 0
                            },
                            {
                                label: 'Claim Through',
                                fieldName: 'Claim_Through__c',
                                type: 'text',
                                colIdx : 1
                            },
                            {
                                label: 'Claim Reimbursement',
                                fieldName: 'Claim_Reimbursement__c',
                                type: 'text',
                                colIdx : 2
                            },
                            {
                                label: 'ICD 10',
                                fieldName: 'ICD10__c',
                                type: 'text',
                                colIdx : 3
                            },
                            {
                                label: 'Physician NPN',
                                fieldName: 'Physician_NPN__c',
                                type: 'text',
                                colIdx : 4
                            },
                            {
                                label: 'Type',
                                fieldName: 'Type__c',
                                type: 'text',
                                colIdx : 5
                            }
                        ];
                        return columns;
            },

             downloadCSVFile : function(component, event, helper) {
                var gridColumns = helper.getColumns(component, event, helper);
                var gridRows = component.get("v.quoteClaimHistory");
                var downloadFileName = "Quote_Claim_History.csv"
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
                        row.splice(columnOrderMap[key] , 1 ,String(gridRow["" + key + ""]).includes(',') === true ? '"' + gridRow["" + key + ""] + '"' : gridRow["" + key + ""] );
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
});