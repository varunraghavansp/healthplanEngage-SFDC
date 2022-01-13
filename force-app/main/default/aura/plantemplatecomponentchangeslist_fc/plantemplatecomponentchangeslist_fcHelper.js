/**
 * Created by varun on 8/20/2019.
 */

({
    parseComponentChanges : function(component) {
        var helper = this;
        var planTemplate = component.get("v.Plan_Template__c");
        var planTemplateId = planTemplate["Id"];
        var planComponentMap =  new Map();
        //Created duplicate Map variable since lightning is not able to perform get on Map attribute type
        var planComponents = {};
        var querymap = {};
        if (!$A.util.isUndefinedOrNull(planTemplateId)) {
            querymap['object'] = 'Plan_Template_Component__c';
            querymap['queryFields'] = 'Id, Component_Name__c,Component_Type__c,Is_Base_Component__c,Plan_Component__c,Plan_Template__c,Name';
            querymap['filter'] = 'Plan_Template__c = \'' + planTemplateId + '\'';

            var getExistingPlanTemplateComponentAction = component.get("c.getRecords");
            getExistingPlanTemplateComponentAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getExistingPlanTemplateComponentPromise = helper.executePromisedAction(component, getExistingPlanTemplateComponentAction);
            getExistingPlanTemplateComponentPromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0].Plan_Template_Component__c;
                            for(let planTemplateComponent of responsedata){
                                planComponentMap.set([planTemplateComponent.Component_Name__c], planTemplateComponent);
                                planComponents[[planTemplateComponent.Component_Name__c]] = planTemplateComponent;
                            }
                            component.set("v.planComponentMap", planComponentMap);
                            component.set("v.planComponents", planComponents);
                            helper.createOperationalAttributeList(component);
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

    createOperationalAttributeList: function(component){
        var createPlanTemplateComponents = [];
        var updatePlanTemplateComponents = [];
        var deletePlanTemplateComponents = [];
        var noChangePlanTemplateComponents = [];
        var planTemplate = component.get("v.Plan_Template__c");
        var newPlanTemplateComponents = component.get("v.Plan_Template_Component__c");
        var planComponentMap = component.get("v.planComponentMap");
        var planComponents = component.get("v.planComponents");
        var newPlanTemplateComponentMap = {};
        for(let planTemplateComponent of newPlanTemplateComponents){
            //Create a Map of New Attribute Value Pairs to determine deletion list
            newPlanTemplateComponentMap[planTemplateComponent.Component_Name__c] = planTemplateComponent;
            if($A.util.isUndefinedOrNull(planComponentMap)){
                planTemplateComponent["Id"] = "";
                planTemplateComponent["Plan_Template__c"] = planTemplate["Id"];
                createPlanTemplateComponents.push(planTemplateComponent);
            }else{
                var existingPlanTemplateComponent = planComponents[planTemplateComponent["Component_Name__c"]];
                if($A.util.isUndefinedOrNull(existingPlanTemplateComponent)){
                    //Reset Id for Insert
                    planTemplateComponent["Id"] = "";
                    planTemplateComponent["Plan_Template__c"] = planTemplate["Id"];
                    createPlanTemplateComponents.push(planTemplateComponent);
                }else {
                    noChangePlanTemplateComponents.push(planTemplateComponent);
                }
            }
        }
        planComponentMap.forEach(function(value, key, map) {
            var newPlanTemplateComponent = newPlanTemplateComponentMap[key];
            if($A.util.isUndefinedOrNull(newPlanTemplateComponent)){
                deletePlanTemplateComponents.push(value);
            }
        });
        component.set("v.createPlanTemplateComponentsPrivate",createPlanTemplateComponents);
        component.set("v.updatePlanTemplateComponentsPrivate",updatePlanTemplateComponents);
        component.set("v.deletePlanTemplateComponentsPrivate",deletePlanTemplateComponents);
        component.set("v.noChangePlanTemplateComponents",noChangePlanTemplateComponents);
        var attributechangesparsedEvent = component.getEvent("attributechangesparsed");
        attributechangesparsedEvent.fire();
    },

     //returns Column Definition for datatable
    getColumnDefinitions: function () {
        var columns = [
            { label: 'Component Name', fieldName: 'Component_Name__c', sortable: true, type: 'text'},
            { label: 'Component Type', fieldName: 'Component_Type__c', type: 'text', sortable: true},
            { label: 'Is Base Component', fieldName: 'Is_Base_Component__c', type: 'boolean'}
        ];
        return columns;
    },

    //returns row definition for datatable
    getRows: function(planTemplateComponents){
        var row = {};
        var rows = [];
        if (!$A.util.isUndefined(planTemplateComponents) && !$A.util.isEmpty(planTemplateComponents)){
            for(let planTemplateComponent of planTemplateComponents){
                row = {
                    "id": planTemplateComponent.Component_Name__c,
                    "Component_Name__c": planTemplateComponent.Component_Name__c,
                    "Component_Type__c": planTemplateComponent.Component_Type__c,
                    "Is_Base_Component__c": planTemplateComponent.Is_Base_Component__c,
                    "Plan_Component__c": planTemplateComponent.Plan_Component__c,
                    "Plan_Template__c": planTemplateComponent.Plan_Template__c
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