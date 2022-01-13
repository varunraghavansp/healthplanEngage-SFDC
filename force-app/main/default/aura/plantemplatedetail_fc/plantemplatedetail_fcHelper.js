/**
 * Created by varun on 8/16/2019.
 */

({
    //Set Product Component
    setPlanTemplate: function(component, event, helper){
        var helper = this;
        var planFamily = component.get("v.Plan_Family__c");
        var planTemplate = component.get("v.Plan_Template__c");
        var editplantemplateid = component.get("v.editplantemplateid");
        var createplantemplate = component.get("v.createplantemplate");
        var planTemplateId = "";
        if(createplantemplate){
            planTemplateId = component.get("v.copyfromplantemplateid");
        }else{
            planTemplateId = editplantemplateid;
        }
        if($A.util.isUndefined(planTemplateId) || planTemplateId == ""){
            planTemplate = {
                'Id': '',
                'Description__c': '',
                'Effective_Date__c': '',
                'Name': '',
                'Plan_Type__c': '',
                'Plan_Family__c': planFamily["Id"],
                'Status__c': 'Workspace',
                'Termination_Date__c': '',
                'Version__c': 1
            };
            component.set("v.Plan_Template__c", planTemplate);
        }else{
            var querymap = {};
            querymap['object'] = 'Plan_Template__c';
            querymap['queryFields'] = 'Id, Description__c,Effective_Date__c,Name,Plan_Type__c, Plan_Family__c, Status__c,Termination_Date__c,Version__c';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = planTemplateId;
            var getPlanTemplateAction = component.get("c.getRecords");
            getPlanTemplateAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getPlanTemplatePromise = helper.executePromisedAction(component, getPlanTemplateAction);
            getPlanTemplatePromise
            .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            planTemplate = responsedata.Plan_Template__c[0];
                            //If Selected for Creation, nullify Id
                            if(createplantemplate){
                                planTemplate["Id"] = "";
                                planTemplate["Plan_Family__c"] = planFamily["Id"];
                            }
                            component.set("v.Plan_Template__c", planTemplate);
                        } else {
                            console.log("SetplanTemplate attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.Plan_Template__c", planTemplate);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("SetplanTemplate attribute failed with Error " + error.message);
                        component.set("v.Plan_Template__c", planTemplate);
                    })
                );
        }
    },

    //Helper Method which initializes picklist values for passed in Object and Field
    initPicklistValues: function(component, event, helper) {
        var helper = this;
        var querymap = {};
        var objecttype = 'Plan_Template__c';
        var picklistFields = ['Plan_Type__c'];
        querymap['object'] = objecttype;
        for(var idx in picklistFields){
            querymap['picklistfield'] = picklistFields[idx];
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
                                var fieldName = responsedata[0]['fieldName'];
                                var picklists = component.get("v.picklists");
                                if($A.util.isUndefinedOrNull(picklists)){
                                    picklists = {};
                                }
                                picklists[fieldName + '_' + 'values'] = responsedata;
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