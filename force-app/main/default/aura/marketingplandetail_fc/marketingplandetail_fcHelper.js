/**
 * Created by varun on 8/18/2019.
 */

({
    //Set Product Component
    setMarketingPlan: function(component, event, helper){
        var helper = this;
        var productLine = component.get("v.Plan_Family__c");
        var marketingPlan = component.get("v.Marketing_Plan__c");
        var editmarketingplanid = component.get("v.editmarketingplanid");
        var copyfrompplanfamilyid = component.get("v.copyfrompplanfamilyid");
        var createmarketingplan = component.get("v.createmarketingplan");
        var marketingPlanId = "";
        if(createmarketingplan){
            marketingPlanId = component.get("v.copyfrommarketingplanid");
            productLine["Id"] = copyfrompplanfamilyid;
        }else{
            marketingPlanId = editmarketingplanid;
        }
        if($A.util.isUndefined(marketingPlanId) || marketingPlanId == ""){
            marketingPlan = {
                'Id': '',
                'Close_Date__c': '',
                'Discontinued_Date__c': '',
                'Effective_Date__c': '',
                'Exchange_Value__c': '',
                'Plan_Template__c': '',
                'Name': '',
                'Plan_Component_Code__c': '',
                'Plan_Family__c': productLine["Id"],
                'Status__c': 'Workspace',
                'Termination_Date__c': '',
                'Version__c': 1
            };
            component.set("v.Marketing_Plan__c", marketingPlan);
            component.set("v.Plan_Family__c", productLine);
        }else{
            var querymap = {};
            querymap['object'] = 'Marketing_Plan__c';
            querymap['queryFields'] = 'Id, Close_Date__c,Discontinued_Date__c,Effective_Date__c,Exchange_Value__c, Plan_Template__c, Name,Plan_Component_Code__c,Plan_Family__c,Status__c,Termination_Date__c,Version__c';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = marketingPlanId;
            var getMarketingPlanAction = component.get("c.getRecords");
            getMarketingPlanAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getMarketingPlanPromise = helper.executePromisedAction(component, getMarketingPlanAction);
            getMarketingPlanPromise
            .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            marketingPlan = responsedata.Marketing_Plan__c[0];
                            //If Selected for Creation, nullify Id
                            if(createmarketingplan){
                                marketingPlan["Id"] = "";
                                marketingPlan["Plan_Family__c"] = productLine["Id"];
                            }
                            productLine["Id"] = marketingPlan["Plan_Family__c"];

                            component.set("v.Plan_Family__c", productLine);
                            component.set("v.Marketing_Plan__c", marketingPlan);

                        } else {
                            console.log("SetmarketingPlan attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.Marketing_Plan__c", marketingPlan);
                            component.set("v.Plan_Family__c", productLine);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("SetmarketingPlan attribute failed with Error " + error.message);
                        component.set("v.Marketing_Plan__c", marketingPlan);
                        component.set("v.Plan_Family__c", productLine);
                    })
                );
        }
    },

    //Set Product Component
    populatePlanName: function(component, event){
        var helper = this;
        var marketingPlan = component.get("v.Marketing_Plan__c");
        var planTemplateId = marketingPlan["Plan_Template__c"];
        if(!$A.util.isUndefined(planTemplateId) && planTemplateId != ""){
            var querymap = {};
            querymap['object'] = 'Plan_Template__c';
            querymap['queryFields'] = 'Id, Name ,Effective_Date__c,Termination_Date__c';
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
                            var planTemplate = responsedata.Plan_Template__c[0];
                            //If Selected for Creation, nullify Id
                            marketingPlan["Name"] = planTemplate["Name"];
                            marketingPlan["Effective_Date__c"] = planTemplate["Effective_Date__c"];
                            marketingPlan["Termination_Date__c"] = planTemplate["Termination_Date__c"];
                            component.set("v.Marketing_Plan__c", marketingPlan);
                        } else {
                            console.log("SetmarketingPlan attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.Marketing_Plan__c", marketingPlan);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("SetmarketingPlan attribute failed with Error " + error.message);
                        component.set("v.Marketing_Plan__c", marketingPlan);
                    })
                );
        }else{
             marketingPlan["Name"] = "";
             component.set("v.Marketing_Plan__c", marketingPlan);
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