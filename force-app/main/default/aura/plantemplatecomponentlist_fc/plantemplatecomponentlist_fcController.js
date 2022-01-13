/**
 * Created by varun on 8/18/2019.
 */

({
    doInit : function(component, event, helper) {
        console.log('Here');

        component.set("v.componentIdMap", helper.getComponentIdMap(component));
        component.set("v.templateComponentNameToIdMap", helper.getTemplateComponentNameMap(component));
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
            case 'delete':
                helper.deletePlanTemplateComponent(component, row);
                component.set("v.templateComponentNameToIdMap", helper.getTemplateComponentNameMap(component));
                component.set("v.data", helper.getRows(component));
                break;
        }
    },

    newRecord: function(component, event, helper){
        var planTemplate = component.get("v.Plan_Template__c");
        component.set("v.selectedtemplatecomponent", helper.newPlanTemplateComponent(planTemplate));
        helper.togglemodelpopup(component, event, helper);
    },

    cancelmodalpopup : function(component, event, helper){
        helper.togglemodelpopup(component, event, helper);
    },

    saveRecord : function(component, event, helper){
        //ToDO Add Duplicate Check
        helper.savePlanTemplateComponent(component);
        component.set("v.templateComponentNameToIdMap", helper.getTemplateComponentNameMap(component));
        component.set("v.data", helper.getRows(component));
        helper.togglemodelpopup(component, event, helper);
    },

});