/**
 * Created by varun on 8/16/2019.
 */
({
    //Set Productline
    setProductLine: function(component, event, helper) {
        var helper = this;
        var planFamily = component.get("v.Plan_Family__c");
        var createplanfamily = component.get("v.createplanfamily");
        var selectedplanfamilyid = component.get("v.selectedplanfamily");
        if ($A.util.isUndefined(selectedplanfamilyid) || selectedplanfamilyid == "") {
            planFamily = {
                "Id": "",
                "Age_Off_Criteria__c": "",
                "Brand__c": "",
                "Business_Type__c": "",
                "Closed_Date__c": "",
                "Covered_Members__c": "",
                "Description__c": "",
                "Discontinued_Date__c": "",
                "Effective_Date__c": "",
                "Financial_Category_Description__c": "",
                "Line_Of_Business__c": "",
                "Name": "",
                "Plan_Cycle__c": "",
                "Financial_Category__c": "",
                "Status__c": "Workspace",
                "Termination_Date__c": "",
                "Version__c": 1,
                "Parent_Plan_Family__c": ""
            };
            component.set("v.Plan_Family__c", planFamily);
        } else {
            var querymap = {};
            querymap["object"] = "Plan_Family__c";
            querymap["queryFields"] = "Id, Age_Off_Criteria__c,Brand__c,Business_Type__c,Closed_Date__c, Covered_Members__c, Description__c,Discontinued_Date__c,Effective_Date__c,Financial_Category_Description__c,Discontinued_Date__c,Effective_Date__c,Financial_Category_Description__c,Line_Of_Business__c,Name,Plan_Cycle__c,Financial_Category__c,Status__c,Termination_Date__c,Version__c,Parent_Plan_Family__c";
            querymap["searchField"] = "Id";
            querymap["searchTerm"] = selectedplanfamilyid;
            var getProductLineAction = component.get("c.getRecords");
            getProductLineAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getProductLinePromise = helper.executePromisedAction(component, getProductLineAction);
            getProductLinePromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            planFamily = responsedata.Plan_Family__c[0];
                            //If product family is not in a Workspace Status then revise version, status and parent plan family
                            if (planFamily["Status__c"] != "Workspace") {
                                planFamily["Version__c"] = planFamily["Version__c"] + 1;
                                planFamily["Status__c"] = "Workspace";
                                planFamily["Parent_Plan_Family__c"] = planFamily["Parent_Plan_Family__c"] == "" || $A.util.isUndefinedOrNull(planFamily["Parent_Plan_Family__c"]) ? planFamily["Id"] : planFamily["Parent_Plan_Family__c"];
                                planFamily["Id"] = "";
                            }
                            component.set("v.Plan_Family__c", planFamily);
                        } else {
                            console.log("setProductLine attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.Plan_Family__c", planFamily);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("setProductLine attribute failed with Error " + error.message);
                        component.set("v.Plan_Family__c", planFamily);
                    })
                );
        }
    },
    //Helper Method which initializes picklist values for passed in Object and Field
    initPicklistValues: function(component, event, helper) {
        var helper = this;
        var querymap = {};
        var object = "Plan_Family__c";
        var picklistFields = ["Line_Of_Business__c", "Covered_Members__c", "Age_Off_Criteria__c", "Business_Type__c", "Plan_Cycle__c", "Financial_Category__c"];
        querymap["object"] = object;
        for (var idx in picklistFields) {
            querymap["picklistfield"] = picklistFields[idx];
            var picklistFieldsAction = component.get("c.getPicklistValues");
            picklistFieldsAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getPicklistFieldsPromise = helper.executePromisedAction(component, picklistFieldsAction);
            getPicklistFieldsPromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data;
                            var fieldName = responsedata[0]["fieldName"];
                            var picklists = component.get("v.picklists");
                            if ($A.util.isUndefinedOrNull(picklists)) {
                                picklists = {};
                            }
                            picklists[fieldName + "_" + "values"] = responsedata;
                            component.set("v.picklists", picklists);
                            component.set("v.picklistinitalized", true);
                        } else {
                            console.log("Init Picklist Values Promise Chain Failed with Error " + responsemsg.errMsg);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Init Picklist Values Promise Chain Failed with Error " + error.message);
                    })
                );
        }
    },
    //Helper Method for Executing Asynch Actions Through a Promise Wrapper
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