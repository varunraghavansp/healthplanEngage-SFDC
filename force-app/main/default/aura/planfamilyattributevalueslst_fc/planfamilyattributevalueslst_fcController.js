/**
 * Created by varun on 8/16/2019.
 */
({
    doInit: function(component, event, helper) {
        component.set("v.attributeNameToIdMap", helper.getAttributeNameMap(component));
        component.set("v.attributeIdMap", helper.getAttributeIdMap(component));
        component.set("v.attributeValueNameMap", helper.getAttributeValueNameMap(component));
        component.set("v.columns", helper.getColumnDefinitions());
        component.set("v.data", helper.getRows(component));
        component.set("v.columnsinitalized", true);
    },

    updateColumnSorting: function(component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    },

    dataTableUpdated: function(component, event, helper){
        var data = event.getParam('data');
        var selectedrow;
        var rows;
        switch(data.action){
            case 'new':
                rows = data.rows;
                component.set("v.Attribute_Value__c", helper.populateAttributeValues(component, rows));
                component.set("v.data", helper.getRows(component));
                break;
            case 'edit':
                selectedrow = data.selectedrow;
                rows = data.rows;
                component.set("v.selectedattributevalue", helper.editAttributeValue(component, selectedrow));
                helper.togglemodelpopup(component, event, helper);
                break;
            case 'delete':
                selectedrow = data.selectedrow;
                rows = data.rows;
                helper.deleteAttributeValue(component, selectedrow);
                component.set("v.attributeValueNameMap", helper.getAttributeValueNameMap(component));
                component.set("v.data", helper.getRows(component));
                break;
        }
        console.log(JSON.stringify(selectedrow));
        console.log(JSON.stringify(rows));
    },

    newRecord: function(component, event, helper) {
        var planFamily = component.get("v.Plan_Family__c");
        component.set("v.selectedattributevalue", helper.newAttributeValue(planFamily));
        helper.togglemodelpopup(component, event, helper);
    },

    cancelmodalpopup: function(component, event, helper) {
        helper.togglemodelpopup(component, event, helper);
    },

    saveRecord: function(component, event, helper) {
        //ToDO Add Duplicate Check
        helper.saveAttributeValue(component);
        component.set("v.attributeValueNameMap", helper.getAttributeValueNameMap(component));
        component.set("v.data", helper.getRows(component));
        helper.togglemodelpopup(component, event, helper);
    },


    reloaddatatable: function(component, event, helper) {
        component.set("v.attributeValueNameMap", helper.getAttributeValueNameMap(component));
        component.set("v.data", helper.getRows(component));
    },

});