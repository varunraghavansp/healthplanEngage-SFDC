/**
 * Created by varun on 8/16/2019.
 */
({
    //returns Column Definition for datatable
    getColumnDefinitions: function() {
        var actions = [{
                label: 'Edit',
                name: 'edit'
            },
            {
                label: 'Delete',
                name: 'delete'
            }
        ];
        var columns = [{
                label: 'Attribute',
                fieldName: 'Attribute_Code__c',
                sortable: true,
                type: 'text',
                colIdx : 0
            },
            {
                label: 'Attribute Category',
                fieldName: 'Attribute_Category__c',
                type: 'text',
                sortable: true,
                colIdx : 1
            },
            {
                label: 'Attribute Value',
                fieldName: 'Attribute_Value__c',
                type: 'text',
                sortable: true,
                colIdx : 2
            },
            {
                label: 'In Network Value',
                fieldName: 'In_Network_Value__c',
                type: 'text',
                sortable: true,
                colIdx : 3
            },
            {
                label: 'Out Of Network Value',
                fieldName: 'Out_Of_Network_Value__c',
                type: 'text',
                sortable: true,
                colIdx : 4
            },
            {
                label: 'Variant Code',
                fieldName: 'Name',
                type: 'text',
                colIdx : 5
            },
            {
                label: 'In Network Display Value',
                fieldName: 'In_Network_Display_Value__c',
                type: 'text',
                colIdx : 6
            },
            {
                label: 'Out Of Network Display Value',
                fieldName: 'Out_Of_Network_Display_Value__c',
                type: 'text',
                colIdx : 7
            },
            {
                label: 'Limits And Exceptions',
                fieldName: 'Limits_And_Exceptions__c',
                type: 'text',
                colIdx : 8
            },
            {
                type: 'action',
                typeAttributes: {
                    rowActions: actions
                }
            }
        ];
        return columns;
    },
    //creates a Name Map of the Attributes for Use in Upload Function
    getAttributeNameMap: function(component) {
        var attributes = component.get("v.Attribute__c");
        var attributeNameToIdMap = {}
        for (let attribute of attributes) {
            attributeNameToIdMap[attribute['Name']] = attribute;
        }
        return attributeNameToIdMap;
    },
    //creates a Map of the Attributes Ids
    getAttributeIdMap: function(component) {
        var attributes = component.get("v.Attribute__c");
        var attributeIdMap = {}
        for (let attribute of attributes) {
            attributeIdMap[attribute['Id']] = attribute;
        }
        return attributeIdMap;
    },
    //creates a Map of the Attribute Value Names
    getAttributeValueNameMap: function(component) {
        var attributeValues = component.get("v.Attribute_Value__c");
        var attributeValueNameMap = {};
        var attributeValueRecord = {};
        if (!$A.util.isUndefined(attributeValues) && !$A.util.isEmpty(attributeValues)) {
            for (let attributeValue of attributeValues) {
                attributeValueNameMap[attributeValue.Name] = attributeValue;
            }
        }
        return attributeValueNameMap;
    },
    //Converts Row Data to Attribute Value List
    populateAttributeValues: function(component, rows){
        var planFamily = component.get("v.Plan_Family__c");
        var attributeValues = [];
        for(let row of rows){
            var attributeValue =  this.newAttributeValue(planFamily);
            var attributeRecord = component.get("v.attributeNameToIdMap")[row["Attribute_Code__c"]];
            if(!$A.util.isUndefinedOrNull(attributeRecord)){
                attributeValue["Attribute__c"] = attributeRecord.Id;
                attributeValue["Attribute_Category__c"] = row["Attribute_Category__c"];
                attributeValue["Attribute_Code__c"] = row["Attribute_Code__c"];
                attributeValue["Attribute_Name__c"] = attributeRecord.Attribute_Name__c;
                attributeValue["Attribute_Value__c"] = row["Attribute_Value__c"];
                attributeValue["In_Network_Value__c"] = row["In_Network_Value__c"];
                attributeValue["Out_Of_Network_Value__c"] = row["Out_Of_Network_Value__c"];
                attributeValue["In_Network_Display_Value__c"] = row["In_Network_Display_Value__c"];
                attributeValue["Limits_And_Exceptions__c"] = row["Limits_And_Exceptions__c"];
                attributeValue["Name"] = row["Name"];
                attributeValue["Out_Of_Network_Display_Value__c"] = row["Out_Of_Network_Display_Value__c"];
                attributeValue["Plan_Family__c"] = planFamily["Id"];
                attributeValues.push(attributeValue);
            }
        }
        return attributeValues;
    },
    //returns row definition for datatable
    getRows: function(component) {
        var attributeValues = component.get("v.Attribute_Value__c");
        var row = {};
        var rows = [];
        var idx = 0;
        if (!$A.util.isUndefined(attributeValues) && !$A.util.isEmpty(attributeValues)) {
            for (let attributeValue of attributeValues) {
                row = {
                    "id": idx,
                    "Attribute_Category__c": attributeValue.Attribute_Category__c,
                    "Attribute_Code__c": attributeValue.Attribute_Code__c,
                    "Attribute_Value__c": attributeValue.Attribute_Value__c,
                    "Name": attributeValue.Name,
                    "In_Network_Display_Value__c": attributeValue.In_Network_Display_Value__c,
                     "In_Network_Value__c": attributeValue.In_Network_Value__c,
                    "Out_Of_Network_Display_Value__c": attributeValue.Out_Of_Network_Display_Value__c,
                     "Out_Of_Network_Value__c": attributeValue.Out_Of_Network_Value__c,
                    "Limits_And_Exceptions__c": attributeValue.Limits_And_Exceptions__c,
                    "Attribute__c": attributeValue.Attribute__c,
                    "Plan_Family__c": attributeValue.Plan_Family__c
                };
                rows.push(row);
                idx++;
            }
        }
        return rows;
    },
    //returns new instance of attributevalue
    newAttributeValue: function(planFamily) {
        var attributevalue = {
            'Id': '',
            'Attribute__c': '',
            'Attribute_Category__c': '',
            'Attribute_Code__c': '',
            'Attribute_Name__c': '',
            'Attribute_Value__c': '',
            'In_Network_Display_Value__c': '',
            'In_Network_Value__c': '',
            'Limits_And_Exceptions__c': '',
            'Name': '',
            'Out_Of_Network_Display_Value__c': '',
            'Out_Of_Network_Value__c': '',
            'Plan_Family__c': planFamily["Id"]
        };
        return attributevalue;
    },
    //returns existing instance of attributevalue
    editAttributeValue: function(component, row) {
        var rowIdx = row["id"];
        var variantCode = row["Name"]
        var attributeValueMap = component.get("v.attributeValueNameMap");
        var attributevalue = attributeValueMap[variantCode];
        return attributevalue;
    },
    //returns existing instance of attributevalue
    deleteAttributeValue: function(component, row) {
        var rowIdx = row["id"];
        var variantCode = row["Name"]
        var attributeValues = component.get("v.Attribute_Value__c");
        var spliceIdx = -1;
        for (var idx in attributeValues) {
            if (attributeValues[idx]["Name"] == variantCode) {
                spliceIdx = idx
                break;
            }
        }
        if (spliceIdx >= 0) {
            attributeValues.splice(spliceIdx, 1);
        }
        component.set("v.Attribute_Value__c", attributeValues);
    },
    //save attribute value
    saveAttributeValue: function(component) {
        var errorMessage = "";
        var savedAttributeValueRecord = component.get("v.selectedattributevalue");
        var attributeValues = component.get("v.Attribute_Value__c");
        var spliceIdx = -1;
        for (var idx in attributeValues) {
            if (attributeValues[idx]["Name"] == savedAttributeValueRecord["Name"]) {
                spliceIdx = idx;
                break;
            }
        }
        if (spliceIdx >= 0) {
            attributeValues.splice(spliceIdx, 1);
        }
        attributeValues.push(savedAttributeValueRecord);
        component.set("v.Attribute_Value__c", attributeValues);
    },

    //Toggles Modal Popup State
    togglemodelpopup: function(component, event, helper) {
        var showmodalpopup = component.get("v.showaddpopupmodal");
        if (showmodalpopup)
            component.set("v.showaddpopupmodal", false);
        else
            component.set("v.showaddpopupmodal", true);
    },
});