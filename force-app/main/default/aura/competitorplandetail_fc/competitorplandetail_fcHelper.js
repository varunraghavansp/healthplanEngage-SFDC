/**
 * Created by varun on 11/6/2019.
 */

({
    bindDropdownItems: function (component,  helper) {
        var bindingItems_picklistField = [
            'Plan_Type__c',
            'Product_Category__c',
            'HDHP_Option__c',
            'Tier__c'
        ];
        var bindingItems_optionattribute = [
            'options_Plan_Type__c',
            'options_Product_Category__c',
            'options_HDHP_Option__c',
            'options_Tier__c'
        ];

        bindingItems_picklistField.forEach(function (picklistfield, index) {
            helper.initPicklistVals(component, event, helper, 'Competitor_Plan_Information__c', picklistfield, bindingItems_optionattribute[index]);
        });
    },
    initPicklistVals : function (component, event, helper, objectType, picklistField, bindingPpt) {
        var helper = this;
        var querymap = {};
        //console.group("Property bind started");
        //console.log("Object :", objectType);
        //console.log("Property :", picklistField);
        component.set('v.loaded', false);
        querymap['object'] = objectType;
        querymap['picklistfield'] = picklistField;
        var getPicklistValuesAction = component.get("c.getPicklistValues");
        getPicklistValuesAction.setParams({
            "jsonString": JSON.stringify(querymap)
        });
        var getPicklistValuesPromise = helper.executePromisedAction(component, getPicklistValuesAction);
        getPicklistValuesPromise
            .then(
                $A.getCallback(function (result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;

                    if (isSuccess == true) {
                        var responsedata = responsemsg.results.data;
                        //console.log(responsedata);
                        component.set("v." + bindingPpt, responsedata);
                    } else {
                        console.log("Init Picklist Values Promise Chain Failed with Error " + responsemsg.errMsg);
                    }
                    component.set('v.loaded', true);
                     //console.groupEnd();
                })
            )
            .catch(
                $A.getCallback(function (error) {
                    //console.log("Error :", error);
                    //console.groupEnd();
                    component.set('v.loaded', true);
                    console.log("Init Picklist Values Promise Chain Failed with Error " + error.message);
                })
            );
    },

    updateRates : function(component, helper){
        var cmpPlanInfo = component.get("v.currentCompetitorPlanInfo");

        component.set("v.currentCompetitorPlanInfo",cmpPlanInfo );
    },

    getTypeSafeInt : function(input, output){
        if($A.util.isUndefinedOrNull(input)){
            output = 0;
        }else{
            output = parseInt(input);
        }
        return output;
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