/**
 * Created by varun on 11/6/2019.
 */

({
    setColumns: function(component){
        var columns = [
            { label: 'Claim From', fieldName: 'Claim_From__c', type: 'date'},
            { label: 'Claim Through', fieldName: 'Claim_Through__c', type: 'date'},
            { label: 'Type', fieldName: 'Type__c', type: 'text'},
            { label: 'Physician NPN', fieldName: 'Physician_NPN__c', type: 'text'},
            { label: 'ICD10 Code', fieldName: 'ICD10__c', type: 'text'},
            { label: 'Claims Paid', fieldName: 'Claim_Reimbursement__c', type: 'currency'}
        ];
        component.set("v.claimscolumns",columns);
    },

    populateDetailGrid : function(component) {
        var helper = this;
        var quoteclaimHistory = component.get("v.quoteClaimHistory");
        var quote = component.get("v.quote");
        var quoteId = quote["Id"];
        if (!$A.util.isUndefined(quoteclaimHistory) && !$A.util.isEmpty(quoteclaimHistory)) {
            var rows = [];
            for (var idx in quoteclaimHistory) {
                var row = {
                    "Id" : quoteclaimHistory[idx].Name,
                    "Claim_From__c": quoteclaimHistory[idx].Claim_From__c,
                    "Claim_Through__c": quoteclaimHistory[idx].Claim_Through__c,
                    "Type__c": quoteclaimHistory[idx].Type__c,
                    "Physician_NPN__c": quoteclaimHistory[idx].Physician_NPN__c,
                    "ICD10__c": quoteclaimHistory[idx].ICD10__c,
                    "Claim_Reimbursement__c": quoteclaimHistory[idx].Claim_Reimbursement__c,
                    "Quote__c": quoteId
                };
                rows.push(row);
            }
            component.set("v.claimsrows", rows);
            component.set("v.rowsinitialized",true);
            helper.createClaimsSummary(component);
        }
    },

    createClaimsSummary : function(component) {
        var quoteClaimHistory = component.get("v.quoteClaimHistory");
        var quote = component.get("v.quote");
        var disabled = component.get("v.disableFields");
        var medicalClaimSummary = {};
        var rxClaimSummary = {};
        if(!disabled){
            medicalClaimSummary = {"Type__c": "Medical", "Claims__c": 0.00, "Capitation__c": 0.00 ,"Average_Enrolled_Subscribers__c": 0, "Average_Enrolled_Members__c": 0, "Experience_Period_From__c": "", "Experience_Period_Through__c": "", "High_Level_Claims__c" : 0.00, "Billed_Premium__c": 0.00, "Quote__c": quote["Id"]};
            rxClaimSummary = {"Type__c": "RX", "Claims__c": 0.00, "Capitation__c": 0.00 ,"Average_Enrolled_Subscribers__c": 0, "Average_Enrolled_Members__c": 0, "Experience_Period_From__c": "", "Experience_Period_Through__c": "", "High_Level_Claims__c" : 0.00, "Billed_Premium__c": 0.00, "Quote__c": quote["Id"]};

        }
        else{
            medicalClaimSummary = component.get("v.medicalClaimSummary");
            rxClaimSummary = component.get("v.rxClaimSummary");
            medicalClaimSummary["Claims__c"] = 0.00;
            rxClaimSummary["Claims__c"] = 0.00;
            medicalClaimSummary["High_Level_Claims__c"] = 0.00;
            rxClaimSummary["High_Level_Claims__c"] = 0.00;
        }
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
            component.set("v.initializeCharts", true);
        }else{
            alert("Please Enter the Billed Premiums to Calculate MLR");
        }





    },



    readCSVFile: function(component, event, helper) {
        var helper = this;
        var file = event.getSource().get("v.files")[0]; // component.find("upload").getElement().files[0];
        var quote = component.get("v.quote");
        var quoteId = quote["Id"];
        if (file) {
            var reader = new FileReader();
            reader.readAsText(file, "UTF-8");
            reader.onload = function(evt) {
                var textdata = evt.target.result;
                var textRows = textdata.split('\n');
                var quoteClaimHistory = [];
                //Skips Header Row
                for (var i = 1; i < textRows.length - 1; i++) {
                    var textColumns = textRows[i].split(',');
                    var quoteClaimHistoryRow = {};
                    quoteClaimHistoryRow["Quote__c"] = quoteId;
                    quoteClaimHistoryRow["Name"] = textColumns[0];
                    quoteClaimHistoryRow["Type__c"] = textColumns[1];
                    quoteClaimHistoryRow["Claim_From__c"] = textColumns[2];
                    quoteClaimHistoryRow["Claim_Through__c"] = textColumns[3];
                    quoteClaimHistoryRow["Physician_NPN__c"] = textColumns[4];
                    quoteClaimHistoryRow["ICD10__c"] = textColumns[5];
                    quoteClaimHistoryRow["Claim_Reimbursement__c"] = textColumns[6];

                    quoteClaimHistory.push(quoteClaimHistoryRow);
                }
                component.set("v.quoteClaimHistory", quoteClaimHistory);
            }
            reader.onerror = function(evt) {
                console.log("error reading file");
            }

        }
    },
});