/**
 * Created by varun on 8/18/2019.
 */

({
    //Set Product Component
    setPredefinedPlan: function(component, event, helper){
        var helper = this;
        var productLine = component.get("v.ProductLine__c");
        var predefinedPlan = component.get("v.PredefinedPackages__c");
        var editpredefinedpackageid = component.get("v.editpredefinedpackageid");
        var copyfrompplanfamilyid = component.get("v.copyfrompplanfamilyid");
        var createpredefinedplan = component.get("v.createpredefinedplan");
        var predefinedPlanId = "";
        if(createpredefinedplan){
            predefinedPlanId = component.get("v.copyfrompredefinedpackageid");
            productLine["Id"] = copyfrompplanfamilyid;
        }else{
            predefinedPlanId = editpredefinedpackageid;
        }
        if($A.util.isUndefined(predefinedPlanId) || predefinedPlanId == ""){
            predefinedPlan = {
                'Id': '',
                'Close_Date__c': '',
                'Discontinued_Date__c': '',
                'Effective_Date__c': '',
                'Exchange_Value__c': '',
                'Package_Framework__c': '',
                'Name': '',
                'Product_Component_Code__c': '',
                'Product_Line__c': productLine["Id"],
                'Status__c': 'Workspace',
                'Termination_Date__c': '',
                'Version__c': 1
            };
            component.set("v.PredefinedPackages__c", predefinedPlan);
            component.set("v.ProductLine__c", productLine);
        }else{
            var querymap = {};
            querymap['object'] = 'PredefinedPackages__c';
            querymap['queryFields'] = 'Id, Close_Date__c,Discontinued_Date__c,Effective_Date__c,Exchange_Value__c, Package_Framework__c, Name,Product_Component_Code__c,Product_Line__c,Status__c,Termination_Date__c,Version__c';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = predefinedPlanId;
            var getPredefinedPlanAction = component.get("c.getRecords");
            getPredefinedPlanAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getPredefinedPlanPromise = helper.executePromisedAction(component, getPredefinedPlanAction);
            getPredefinedPlanPromise
            .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            predefinedPlan = responsedata.PredefinedPackages__c[0];
                            //If Selected for Creation, nullify Id
                            if(createpredefinedplan){
                                predefinedPlan["Id"] = "";
                                predefinedPlan["Product_Line__c"] = productLine["Id"];
                            }
                            productLine["Id"] = predefinedPlan["Product_Line__c"];

                            component.set("v.ProductLine__c", productLine);
                            component.set("v.PredefinedPackages__c", predefinedPlan);

                        } else {
                            console.log("SetpredefinedPlan attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.PredefinedPackages__c", predefinedPlan);
                            component.set("v.ProductLine__c", productLine);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("SetpredefinedPlan attribute failed with Error " + error.message);
                        component.set("v.PredefinedPackages__c", predefinedPlan);
                        component.set("v.ProductLine__c", productLine);
                    })
                );
        }
    },

    //Set Product Component
    populatePlanName: function(component, event){
        var helper = this;
        var predefinedPlan = component.get("v.PredefinedPackages__c");
        var planTemplateId = predefinedPlan["Package_Framework__c"];
        if(!$A.util.isUndefined(planTemplateId) && planTemplateId != ""){
            var querymap = {};
            querymap['object'] = 'PackageFramework__c';
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
                            var planTemplate = responsedata.PackageFramework__c[0];
                            //If Selected for Creation, nullify Id
                            predefinedPlan["Name"] = planTemplate["Name"];
                            predefinedPlan["Effective_Date__c"] = planTemplate["Effective_Date__c"];
                            predefinedPlan["Termination_Date__c"] = planTemplate["Termination_Date__c"];
                            component.set("v.PredefinedPackages__c", predefinedPlan);
                        } else {
                            console.log("SetpredefinedPlan attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.PredefinedPackages__c", predefinedPlan);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("SetpredefinedPlan attribute failed with Error " + error.message);
                        component.set("v.PredefinedPackages__c", predefinedPlan);
                    })
                );
        }else{
             predefinedPlan["Name"] = "";
             component.set("v.PredefinedPackages__c", predefinedPlan);
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