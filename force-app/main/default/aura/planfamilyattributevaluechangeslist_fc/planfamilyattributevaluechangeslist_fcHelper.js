/**
 * Created by varun on 8/20/2019.
 */

({

     //returns Column Definition for datatable
    getColumnDefinitions: function () {
        var columns = [
            { label: 'Attribute', fieldName: 'Attribute_Code__c', sortable: true, type: 'text'},
            { label: 'Attribute Category', fieldName: 'Attribute_Category__c', type: 'text', sortable: true},
            { label: 'Attribute Value', fieldName: 'Attribute_Value__c', type: 'text', sortable: true},
            { label: 'Variant Code', fieldName: 'Name', type: 'text'},
            { label: 'In Network Display Value', fieldName: 'In_Network_Display_Value__c', type: 'text'},
            { label: 'Out Of Network Display Value', fieldName: 'Out_Of_Network_Display_Value__c', type: 'text'},
            { label: 'Limits And Exceptions', fieldName: 'Limits_And_Exceptions__c', type: 'text'}
        ];
        return columns;
    },

    initChanges: function(component){
        var helper = this;
        var planFamily = component.get("v.Plan_Family__c");
        var planFamilyId = planFamily["Id"];
        component.set("v.createAttributeValues",[]);
        component.set("v.updateAttributeValues",[]);
        component.set("v.deleteAttributeValues",[]);
        component.set("v.nochangeAttributeValues",[]);
        var querymap = {};
        if (!$A.util.isUndefinedOrNull(planFamilyId)) {
            querymap['object'] = 'Attribute_Value__c';
            querymap['queryFields'] = 'Id, Name,Attribute__c,Attribute_Category__c,Attribute_Code__c,Attribute_Name__c,Attribute_Value__c,In_Network_Display_Value__c,Limits_And_Exceptions__c, Out_Of_Network_Display_Value__c';
            querymap['filter'] = 'Plan_Family__c = \'' + planFamilyId + '\'';

            var getExistingAttributeValuesAction = component.get("c.getRecords");
            getExistingAttributeValuesAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getExistingAttributeValuesPromise = helper.executePromisedAction(component, getExistingAttributeValuesAction);
            getExistingAttributeValuesPromise
                .then(
                    $A.getCallback(function(result) {
                        var attributeValueNameMap =  new Map();
                        //Created duplicate Map variable since lightning is not able to perform get on Map attribute type
                        var attributeValueNames = {};
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0].Attribute_Value__c;
                            for(let attributeValue of responsedata){
                                attributeValueNameMap.set([attributeValue.Name], attributeValue);
                                attributeValueNames[[attributeValue.Name]] = attributeValue;
                            }
                            component.set("v.attributeValueNameMap", attributeValueNameMap);
                            component.set("v.attributeValueNames", attributeValueNames);
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
        //Start Create Operational List
        var createAttributeValues = [];
        var updateAttributeValues = [];
        var deleteAttributeValues = [];
        var nochangeAttributeValues = [];
        var newAttributeValues = component.get("v.Attribute_Value__c");
        var attributeValueNameMap = component.get("v.attributeValueNameMap");
        var attributeValueNames = component.get("v.attributeValueNames");
        var newAttributeValueNameMap = {};
        for(let attributeValue of newAttributeValues){
            //Create a Map of New Attribute Value Pairs to determine deletion list
            newAttributeValueNameMap[attributeValue.Name] = attributeValue;
            if($A.util.isUndefinedOrNull(attributeValueNameMap)){
                attributeValue["Id"] = "";
                createAttributeValues.push(attributeValue);
            }else{
                var existingAttribute = attributeValueNames[attributeValue["Name"]];
                if($A.util.isUndefinedOrNull(existingAttribute)){
                    //Reset Id for Insert
                    attributeValue["Id"] = "";
                    createAttributeValues.push(attributeValue);
                }else {
                    if(attributeValue["In_Network_Display_Value__c"] != existingAttribute["In_Network_Display_Value__c"] || attributeValue["Out_Of_Network_Display_Value__c"] != existingAttribute["Out_Of_Network_Display_Value__c"] || attributeValue["Limits_And_Exceptions__c"] != existingAttribute["Limits_And_Exceptions__c"] ){
                        attributeValue["Id"] = existingAttribute["Id"];
                        updateAttributeValues.push(attributeValue);
                    }else{
                        nochangeAttributeValues.push(attributeValue);
                    }
                }
            }
        }
        attributeValueNameMap.forEach(function(value, key, map) {
            var newAttribute = newAttributeValueNameMap[key];
            if($A.util.isUndefinedOrNull(newAttribute)){
                deleteAttributeValues.push(value);
            }
        });
        component.set("v.createAttributeValuesPrivate",createAttributeValues);
        component.set("v.updateAttributeValuesPrivate",updateAttributeValues);
        component.set("v.deleteAttributeValuesPrivate",deleteAttributeValues);
        component.set("v.nochangeAttributeValues",nochangeAttributeValues);
        var attributechangesparsedEvent = component.getEvent("attributechangesparsed");
        attributechangesparsedEvent.fire();
    },

    //returns row definition for datatable
    getRows: function(attributeValues){
        var row = {};
        var rows = [];
        if (!$A.util.isUndefined(attributeValues) && !$A.util.isEmpty(attributeValues)){
            for(let attributeValue of attributeValues){
                row = {
                    "id": attributeValue.Name,
                    "Attribute_Category__c": attributeValue.Attribute_Category__c,
                    "Attribute_Code__c": attributeValue.Attribute_Code__c,
                    "Attribute_Value__c": attributeValue.Attribute_Value__c,
                    "Name": attributeValue.Name,
                    "In_Network_Display_Value__c": attributeValue.In_Network_Display_Value__c,
                    "Out_Of_Network_Display_Value__c": attributeValue.Out_Of_Network_Display_Value__c,
                    "Limits_And_Exceptions__c": attributeValue.Limits_And_Exceptions__c,
                    "Attribute__c": attributeValue.Attribute__c
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
                    resolve(retVal, component);
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