/**
 * Created by varun on 8/20/2019.
 */

({
    parseAttributeChanges : function(component) {
        var helper = this;
        var planComponent = component.get("v.Plan_Component__c");
        var planComponentId = planComponent["Id"];
        var attributeNameMap =  new Map();
        //Created duplicate Map variable since lightning is not able to perform get on Map attribute type
        var attributeNames = {};
        var querymap = {};
        if (!$A.util.isUndefinedOrNull(planComponentId)) {
            querymap['object'] = 'Component_Attribute__c';
            querymap['queryFields'] = 'Id, Attribute__c,Attribute_Category__c,Attribute_Code__c,Attribute_Display_Name__c,Attribute_Long_Code__c,Attribute_Name__c,Is_Key_Benefit__c,Plan_Component__c, Plan_Family__c';
            querymap['filter'] = 'Plan_Component__c = \'' + planComponentId + '\'';

            var getExistingComponentAttribAction = component.get("c.getRecords");
            getExistingComponentAttribAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getExistingComponentAttribPromise = helper.executePromisedAction(component, getExistingComponentAttribAction);
            getExistingComponentAttribPromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0].Component_Attribute__c;
                            for(let componentAttribute of responsedata){
                                attributeNameMap.set([componentAttribute.Attribute_Code__c], componentAttribute);
                                attributeNames[[componentAttribute.Attribute_Code__c]] = componentAttribute;
                            }
                            component.set("v.attributeNameMap", attributeNameMap);
                            component.set("v.attributeNames", attributeNames);
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
        var createComponentAttributes = [];
        var updateComponentAttributes = [];
        var deleteComponentAttributes = [];
        var nochangeComponentAttributes = [];
        var planComponent = component.get("v.Plan_Component__c");
        var newComponentAttributes = component.get("v.Component_Attribute__c");
        var attributeNameMap = component.get("v.attributeNameMap");
        var attributeNames = component.get("v.attributeNames");
        var newComponentAttributeNameMap = {};
        for(let componentAttribute of newComponentAttributes){
            //Create a Map of New Attribute Value Pairs to determine deletion list
            newComponentAttributeNameMap[componentAttribute.Attribute_Code__c] = componentAttribute;
            if($A.util.isUndefinedOrNull(attributeNameMap)){
                componentAttribute["Id"] = "";
                componentAttribute["Plan_Component__c"] = planComponent["Id"];
                createComponentAttributes.push(componentAttribute);
            }else{
                var existingAttribute = attributeNames[componentAttribute["Attribute_Code__c"]];
                if($A.util.isUndefinedOrNull(existingAttribute)){
                    //Reset Id for Insert
                    componentAttribute["Id"] = "";
                    componentAttribute["Plan_Component__c"] = planComponent["Id"];
                    createComponentAttributes.push(componentAttribute);
                }else {
                    if(componentAttribute["Is_Key_Benefit__c"] != existingAttribute["Is_Key_Benefit__c"]){
                        componentAttribute["Id"] = existingAttribute["Id"];
                        componentAttribute["Plan_Component__c"] = planComponent["Id"];
                        updateComponentAttributes.push(componentAttribute);
                    }else{
                        nochangeComponentAttributes.push(componentAttribute);
                    }
                }
            }
        }
        attributeNameMap.forEach(function(value, key, map) {
            var newAttribute = newComponentAttributeNameMap[key];
            if($A.util.isUndefinedOrNull(newAttribute)){
                deleteComponentAttributes.push(value);
            }
        });
        component.set("v.createComponentAttributesPrivate",createComponentAttributes);
        component.set("v.updateComponentAttributesPrivate",updateComponentAttributes);
        component.set("v.deleteComponentAttributesPrivate",deleteComponentAttributes);
        component.set("v.nochangeComponentAttributes",nochangeComponentAttributes);
        var attributechangesparsedEvent = component.getEvent("attributechangesparsed");
        attributechangesparsedEvent.fire();
    },

     //returns Column Definition for datatable
    getColumnDefinitions: function () {
        var columns = [
            { label: 'Attribute', fieldName: 'Attribute_Code__c', sortable: true, type: 'text'},
            { label: 'Attribute Category', fieldName: 'Attribute_Category__c', type: 'text', sortable: true},
            { label: 'Attribute Display Name', fieldName: 'Attribute_Display_Name__c', type: 'text', sortable: true},
            { label: 'Attribute Name', fieldName: 'Attribute_Name__c', type: 'text'},
            { label: 'Is Key Benefit', fieldName: 'Is_Key_Benefit__c', type: 'boolean'}
        ];
        return columns;
    },

    //returns row definition for datatable
    getRows: function(componentAttributes){
        var row = {};
        var rows = [];
        if (!$A.util.isUndefined(componentAttributes) && !$A.util.isEmpty(componentAttributes)){
            for(let componentAttribute of componentAttributes){
                row = {
                    "id": componentAttribute.Attribute_Code__c,
                    "Attribute_Code__c": componentAttribute.Attribute_Code__c,
                    "Attribute_Category__c": componentAttribute.Attribute_Category__c,
                    "Attribute_Display_Name__c": componentAttribute.Attribute_Display_Name__c,
                    "Attribute_Name__c": componentAttribute.Attribute_Name__c,
                    "Is_Key_Benefit__c": componentAttribute.Is_Key_Benefit__c,
                    "Attribute__c": componentAttribute.Attribute__c
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