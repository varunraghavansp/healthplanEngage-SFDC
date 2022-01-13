/**
 * Created by varun on 7/31/2019.
 */

({
    setColumns: function(component){
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        var columns = [
            { label: 'Employee #', fieldName: 'Employee_Number__c', type: 'text', editable: 'true'},
            { label: 'First Name', fieldName: 'Name', type: 'text', editable: 'true'},
            { label: 'Last Name', fieldName: 'Last_Name__c', type: 'text', editable: 'true'},
            { label: 'Date Of Birth', fieldName: 'Date_Of_Birth__c', type: 'date', editable: 'true'},
            { label: 'Gender', fieldName: 'Gender__c', type: 'text', editable: 'true'},
            { label: 'Relation', fieldName: 'Relation__c', type: 'text', editable: 'true'},
            { label: 'Tobacco Use', fieldName: 'Tobacco_Use__c', type: 'boolean', editable: 'true'},
            { type: 'action', typeAttributes: { rowActions: actions } }
        ];
        component.set("v.quotecensusdatacols",columns);
    },

    populateContactGird: function(component, event, helper) {
        var quoteCensus = component.get("v.quotecensus");
        var quote = component.get("v.quote");
        var quoteId = quote["Id"];
        var numberofSubscribers = component.get("v.numberofsubscribers");
        var numberofMembers = component.get("v.numberofmembers");
        if (!$A.util.isUndefined(quoteCensus) && !$A.util.isEmpty(quoteCensus)) {
            var rows = [];
            var childrows = [];
            for (var idx in quoteCensus) {
                if (quoteCensus[idx].Relation__c == 'Self') {
                        var row = {
                            "Id" : quoteCensus[idx].Employee_Number__c,
                            "Employee_Number__c": quoteCensus[idx].Employee_Number__c,
                            "Name": quoteCensus[idx].Name,
                            "Last_Name__c": quoteCensus[idx].Last_Name__c,
                            "Date_Of_Birth__c": quoteCensus[idx].Date_Of_Birth__c,
                            "Gender__c": quoteCensus[idx].Gender__c,
                            "Relation__c": quoteCensus[idx].Relation__c,
                            "Tobacco_Use__c": quoteCensus[idx].Tobacco_Use__c,
                            "Quote__c": quoteId
                        };
                        numberofSubscribers++;
                        numberofMembers++;
                        rows.push(row);
                    } else {
                        var row = {
                            "Id" : quoteCensus[idx].Employee_Number__c,
                            "Employee_Number__c": quoteCensus[idx].Employee_Number__c,
                            "Name": quoteCensus[idx].Name,
                            "Last_Name__c": quoteCensus[idx].Last_Name__c,
                            "Date_Of_Birth__c": quoteCensus[idx].Date_Of_Birth__c,
                            "Gender__c": quoteCensus[idx].Gender__c,
                            "Relation__c": quoteCensus[idx].Relation__c,
                            "Tobacco_Use__c": quoteCensus[idx].Tobacco_Use__c,
                            "Quote__c": quoteId
                        };
                        numberofMembers++;
                        childrows.push(row);
                    }
                }
                component.set("v.quotecensussubscriber", rows);
                component.set("v.quotecensusdependent", childrows);
                component.set("v.numberofsubscribers",numberofSubscribers);
                component.set("v.numberofmembers",numberofMembers);
                component.set("v.rowsinitialized",true);
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
                    var quotecensus = [];
                    //Skips Header Row
                    for (var i = 1; i < textRows.length - 1; i++) {
                        var textColumns = textRows[i].split(',');
                        var quotecensusrow = {};
                        quotecensusrow["Quote__c"] = quoteId;
                        quotecensusrow["Employee_Number__c"] = textColumns[0];
                        quotecensusrow["Name"] = textColumns[1];
                        quotecensusrow["Last_Name__c"] = textColumns[2];
                        quotecensusrow["Date_Of_Birth__c"] = textColumns[3];
                        quotecensusrow["Gender__c"] = textColumns[4];
                        quotecensusrow["Relation__c"] = textColumns[5];
                        if (textColumns[6] == "Y" || textColumns[6] == "true")
                            quotecensusrow["Tobacco_Use__c"] = true;
                        else
                            quotecensusrow["Tobacco_Use__c"] = false;
                        quotecensusrow["Status__c"] = "Active";
                        quotecensus.push(quotecensusrow);
                    }
                    component.set("v.quotecensus", quotecensus);
                }
                reader.onerror = function(evt) {
                    console.log("error reading file");
                }

            }

        },
});