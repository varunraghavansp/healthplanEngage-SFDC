/**
 * Created by varun on 11/6/2019.
 */

({
    setColumns: function(component){
        var columns = [
            { label: 'Carrier Name', fieldName: 'Carrier_Name__c', type: 'text'},
            { label: 'Plan Name', fieldName: 'Plan_Name__c', type: 'text'},
            { label: 'Plan Type', fieldName: 'Plan_Type__c', type: 'text'},
            { label: 'Product Category', fieldName: 'Product_Category__c', type: 'text'},
            { label: 'Package Id', fieldName: 'Name', type: 'text'}
        ];
        component.set("v.planColumns",columns);
    },

    populateDetailGrid : function(component) {
        var helper = this;
        var competitorPlanInformation = component.get("v.competitorPlanInformation");
        if (!$A.util.isUndefined(competitorPlanInformation) && !$A.util.isEmpty(competitorPlanInformation)) {
            var rows = [];
            for (var idx in competitorPlanInformation) {
                //Set Id Field for dataGrid
                competitorPlanInformation[idx]["Id"] = competitorPlanInformation[idx].Name;
                rows.push(competitorPlanInformation[idx]);
            }
            component.set("v.planRows", rows);
            component.set("v.rowsInitialized",true);
        }
    },

    readCSVFile: function(component, event, helper) {
        var helper = this;
        var file = event.getSource().get("v.files")[0]; // component.find("upload").getElement().files[0];
        var quote = component.get("v.quote");
        var account = component.get("v.account");
        if (file) {
            var reader = new FileReader();
            reader.readAsText(file, "UTF-8");
            reader.onload = function(evt) {
                var textdata = evt.target.result;
                var textRows = textdata.split('\n');
                var competitorPlanInformation = [];
                //Skips Header Row
                for (var i = 1; i < textRows.length - 1; i++) {
                    var textColumns = textRows[i].split(',');
                    var competitorPlanInformationRecord = {};
                    competitorPlanInformationRecord["Quote__c"] = quote["Id"];
                    competitorPlanInformationRecord["Account__c"] = account["Id"];
                    competitorPlanInformationRecord["Carrier_Name__c"] = textColumns[0];
                    competitorPlanInformationRecord["Plan_Name__c"] = textColumns[1];
                    competitorPlanInformationRecord["Plan_Type__c"] = textColumns[2];
                    competitorPlanInformationRecord["Product_Category__c"] = textColumns[3];
                    competitorPlanInformationRecord["Name"] = textColumns[4];
                    competitorPlanInformationRecord["HDHP_Option__c"] = textColumns[5];
                    competitorPlanInformationRecord["Deductible__c"] = textColumns[6];
                    competitorPlanInformationRecord["Inpatient_Copay__c"] = textColumns[7];
                    competitorPlanInformationRecord["DME__c"] = textColumns[8];
                    competitorPlanInformationRecord["Emergency_Room_Copay__c"] = textColumns[9];
                    competitorPlanInformationRecord["Max_Dependent_Age__c"] = textColumns[10];
                    competitorPlanInformationRecord["Medical_Equipment_Rider__c"] = textColumns[11];
                    competitorPlanInformationRecord["Drug_Option__c"] = textColumns[12];
                    competitorPlanInformationRecord["Tier__c"] = textColumns[13];
                    //competitorPlanInformationRecord["Rate_Effective_Date__c"] = textColumns[14];
                    //competitorPlanInformationRecord["Rate_Termination_Date__c"] = textColumns[15];
                    competitorPlanInformationRecord["Subscriber_Only_Medical__c"] = textColumns[16];
                    competitorPlanInformationRecord["Subscriber_Only_Prescription_Drug__c"] = textColumns[17];
                    competitorPlanInformationRecord["Subscriber_Only_Incentives__c"] = textColumns[18];
                    competitorPlanInformationRecord["Subscriber_Only_Medical_Management__c"] = textColumns[19];
                    competitorPlanInformationRecord["Subscriber_Only_Total__c"] = textColumns[20];
                    competitorPlanInformationRecord["Subscriber_Spouse_Medical__c"] = textColumns[21];
                    competitorPlanInformationRecord["Subscriber_Spouse_Prescription_Drug__c"] = textColumns[22];
                    competitorPlanInformationRecord["Subscriber_Spouse_Incentives__c"] = textColumns[23];
                    competitorPlanInformationRecord["Subscriber_Spouse_Medical_Management__c"] = textColumns[24];
                    competitorPlanInformationRecord["Subscriber_Spouse_Total__c"] = textColumns[25];
                    competitorPlanInformationRecord["Subscriber_Children_Medical__c"] = textColumns[26];
                    competitorPlanInformationRecord["Subscriber_Children_Prescription_Drug__c"] = textColumns[27];
                    competitorPlanInformationRecord["Subscriber_Children_Incentives__c"] = textColumns[28];
                    competitorPlanInformationRecord["Subscriber_Children_Medical_Management__c"] = textColumns[29];
                    competitorPlanInformationRecord["Subscriber_Children_Total__c"] = textColumns[30];
                    competitorPlanInformationRecord["Family_Medical__c"] = textColumns[31];
                    competitorPlanInformationRecord["Family_Prescription_Drug__c"] = textColumns[32];
                    competitorPlanInformationRecord["Family_Incentives__c"] = textColumns[33];
                    competitorPlanInformationRecord["Family_Medical_Management__c"] = textColumns[34];
                    competitorPlanInformationRecord["Family_Total__c"] = textColumns[35];

                    competitorPlanInformation.push(competitorPlanInformationRecord);
                }
                component.set("v.competitorPlanInformation", competitorPlanInformation);
            }
            reader.onerror = function(evt) {
                console.log("error reading file");
            }
        }
    },
});