/**
 * Created by varun on 8/18/2019.
 */

({
     doInit : function(component, event, helper) {
        component.set("v.attributeNameToIdMap", helper.getAttributeNameMap(component));
        component.set("v.attributeIdMap", helper.getAttributeIdMap(component));
        component.set("v.allowedAttributeValueNameMap", helper.getAllowableAttributeNameMap(component));
        helper.filterComponent_AttributeToAllowedValues(component);
        component.set("v.componentAttributeNameMap", helper.getComponentAttributeNameMap(component));
        component.set("v.columns",helper.getColumnDefinitions() );
        component.set("v.data", helper.getRows(component));
        component.set("v.columnsinitalized",true);
    },

    updateColumnSorting: function (component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    },

    handleRowAction: function (component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');

        switch (action.name) {
            case 'edit':
                component.set("v.selectedcomponentattribute", helper.editPlanComponentAttribute(component, row));
                helper.togglemodelpopup(component, event, helper);
                break;
            case 'delete':
                helper.deletePlanComponentAttribute(component, row);
                component.set("v.componentAttributeNameMap", helper.getComponentAttributeNameMap(component));
                component.set("v.data", helper.getRows(component));
                break;
        }
    },

    newRecord: function(component, event, helper){
        var planComponent = component.get("v.he__Plan_Component__c");
        component.set("v.selectedcomponentattribute", helper.newPlanComponentAttribute(planComponent));
        helper.togglemodelpopup(component, event, helper);
    },

    cancelmodalpopup : function(component, event, helper){
        helper.togglemodelpopup(component, event, helper);
    },

    saveRecord : function(component, event, helper){
        //ToDO Add Duplicate Check
        helper.saveComponentAttributeValue(component);
        component.set("v.componentAttributeNameMap", helper.getComponentAttributeNameMap(component));
        component.set("v.data", helper.getRows(component));
        helper.togglemodelpopup(component, event, helper);
    },


    reloaddatatable: function(component, event, helper){
        component.set("v.componentAttributeNameMap", helper.getComponentAttributeNameMap(component));
        component.set("v.data", helper.getRows(component));
    },

    readCSV : function(component, event, helper) {
        helper.readCSVFile(component, event, helper);
    },


});