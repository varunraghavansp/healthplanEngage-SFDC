/**
 * Created by varun on 8/26/2019.
 */

({
    populatePlanName: function(component){
        var helper = this;
        var marketingPlan = component.get("v.Marketing_Plan__c");
        var planTemplateId = marketingPlan["Plan_Template__c"];
        var newPlanBenefits = component.get("v.Marketing_Plan_Benefit__c");
        var appendToPlanNameLst = [];
        for(let planBenefit of newPlanBenefits){
            if(planBenefit.Is_Key_Benefit__c == true){
                appendToPlanNameLst.push(planBenefit.Attribute_Code__c + planBenefit.Attribute_Value_Amount__c);
            }
        }
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
                            marketingPlan["Plan_Name__c"] = planTemplate["Name"] + ' ' + appendToPlanNameLst.join(' ');
                            marketingPlan["Plan_Component_Code__c"] = appendToPlanNameLst.join(' ');
                            component.set("v.Marketing_Plan__c", marketingPlan);
                        } else {
                            console.log("Set marketingPlan attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.Marketing_Plan__c", marketingPlan);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Set marketingPlan attribute failed with Error " + error.message);
                        component.set("v.Marketing_Plan__c", marketingPlan);
                    })
                );
        }
    },

    parsePlanBenefitChanges : function(component) {
        var helper = this;
        var marketingPlan = component.get("v.Marketing_Plan__c");
        var marketingPlanId = marketingPlan["Id"];
        var planBenefitNameMap =  new Map();
        //Created duplicate Map variable since lightning is not able to perform get on Map attribute type
        var planBenefitNames = {};
        var querymap = {};
        if (!$A.util.isUndefinedOrNull(marketingPlanId)) {
            querymap['object'] = 'Marketing_Plan_Benefit__c';
            querymap['queryFields'] = 'Id, Name,Attribute_Value__c,Marketing_Plan__c,Plan_Template_Component__c,Component_Attribute__c,Attribute_Value_Amount__c,Component_Type__c,Component_Name__c, Plan_Family__c,Attribute_Display_Name__c,Out_Of_Network_Display_Value__c,Attribute_Category__c,Attribute_Code__c,In_Network_Display_Name__c,Attribute_Long_Code__c,Attribute_Id__c,Is_Key_Benefit__c,Is_Base_Component_Benefit__c';
            querymap['filter'] = 'Marketing_Plan__c = \'' + marketingPlanId + '\'';

            var getExistingPlanBenefitValuesAction = component.get("c.getRecords");
            getExistingPlanBenefitValuesAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getExistingPlanBenefitValuesPromise = helper.executePromisedAction(component, getExistingPlanBenefitValuesAction);
            getExistingPlanBenefitValuesPromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0].Marketing_Plan_Benefit__c;
                            for(let planBenefit of responsedata){
                                planBenefitNameMap.set([planBenefit.Component_Type__c + planBenefit.Attribute_Code__c], planBenefit);
                                planBenefitNames[[planBenefit.Component_Type__c + planBenefit.Attribute_Code__c]] = planBenefit;
                            }
                            component.set("v.planBenefitNameMap", planBenefitNameMap);
                            component.set("v.planBenefitNames", planBenefitNames);
                            helper.createOperationPlanBenefitList(component);
                        } else {
                            console.log("Error Fetching Attribute Value Names " + responsemsg.errMsg);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Error Fetching Attribute Value Names " + error.message);
                    })
                );
        }
    },

    createOperationPlanBenefitList: function(component){
        var createPlanBenefits = [];
        var updatePlanBenefits = [];
        var deletePlanBenefits = [];
        var nochangePlanBenefits = [];
        var newPlanBenefits = component.get("v.Marketing_Plan_Benefit__c");
        var planBenefitNameMap = component.get("v.planBenefitNameMap");
        var planBenefitNames = component.get("v.planBenefitNames");
        var newPlanBenefitNameMap = {};
        for(let planBenefit of newPlanBenefits){
            //Create a Map of New Plan Benefit Pairs to determine deletion list
            newPlanBenefitNameMap[planBenefit.Component_Type__c + planBenefit.Attribute_Code__c] = planBenefit;
            if($A.util.isUndefinedOrNull(planBenefitNameMap)){
                planBenefit["Id"] = "";
                createPlanBenefits.push(planBenefit);
            }else{
                var existingPlanBenefit = planBenefitNames[planBenefit["Component_Type__c"] + planBenefit["Attribute_Code__c"]];
                if($A.util.isUndefinedOrNull(existingPlanBenefit)){
                    //Reset Id for Insert
                    planBenefit["Id"] = "";
                    createPlanBenefits.push(planBenefit);
                }else {
                    if(planBenefit["Attribute_Value__c"] != existingPlanBenefit["Attribute_Value__c"]){
                        planBenefit["Id"] = existingPlanBenefit["Id"];
                        updatePlanBenefits.push(planBenefit);
                    }else{
                        nochangePlanBenefits.push(planBenefit);
                    }
                }
            }
        }
        planBenefitNameMap.forEach(function(value, key, map) {
            var newPlanBenefit = newPlanBenefitNameMap[key];
            if($A.util.isUndefinedOrNull(newPlanBenefit)){
                deletePlanBenefits.push(value);
            }
        });
        component.set("v.createPlanBenefits",createPlanBenefits);
        component.set("v.updatePlanBenefits",updatePlanBenefits);
        component.set("v.deletePlanBenefits",deletePlanBenefits);
        component.set("v.nochangePlanBenefits",nochangePlanBenefits);
        var planbenefitchangesparsedEvent = component.getEvent("planbenefitchangesparsed");
        planbenefitchangesparsedEvent.fire();
    },

     //returns Column Definition for datatable
    getColumnDefinitions: function () {
        var columns = [
             { label: 'Component Type', fieldName: 'Component_Type__c', type: 'text', sortable: true},
               { label: 'Is Base Component Benefit', fieldName: 'Is_Base_Component_Benefit__c', type: 'boolean', sortable: true},
               { label: 'Is Key Benefit', fieldName: 'Is_Key_Benefit__c', type: 'boolean', sortable: true},
               { label: 'Attribute Category', fieldName: 'Attribute_Category__c', type: 'text', sortable: true},
               { label: 'Attribute Code', fieldName: 'Attribute_Code__c', type: 'text', sortable: true},
               { label: 'Attribute Display Name', fieldName: 'Attribute_Display_Name__c', type: 'text', sortable: true},
               { label: 'Attribute Value', fieldName: 'Attribute_Value_Amount__c', type: 'text', sortable: true},
               { label: 'In Network Display Value', fieldName: 'In_Network_Display_Name__c', type: 'text'},
               { label: 'Out of Network Display Value', fieldName: 'Out_Of_Network_Display_Value__c', type: 'text'}
        ];
        return columns;
    },

    //returns row definition for datatable
    getRows: function(planBenefits){
        var row = {};
        var rows = [];
        if (!$A.util.isUndefined(planBenefits) && !$A.util.isEmpty(planBenefits)){
            for(let planBenefit of planBenefits){
                row = {
                    "id": planBenefit.Component_Type__c + planBenefit.Attribute_Code__c,
                    "Component_Type__c": planBenefit.Component_Type__c,
                    "Is_Base_Component_Benefit__c": planBenefit.Is_Base_Component_Benefit__c,
                    "Is_Key_Benefit__c": planBenefit.Is_Key_Benefit__c,
                    "Attribute_Category__c": planBenefit.Attribute_Category__c,
                    "Attribute_Code__c": planBenefit.Attribute_Code__c,
                    "Attribute_Display_Name__c": planBenefit.Attribute_Display_Name__c,
                    "Attribute_Value__c": planBenefit.Attribute_Value_Amount__c,
                    "In_Network_Display_Name__c": planBenefit.In_Network_Display_Name__c,
                    "Out_Of_Network_Display_Value__c": planBenefit.Out_Of_Network_Display_Value__c
                };
                rows.push(row);
            }
        }
        return rows;
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