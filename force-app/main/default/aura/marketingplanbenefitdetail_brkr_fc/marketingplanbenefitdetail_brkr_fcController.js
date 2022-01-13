/**
 * Created by varun on 8/18/2019.
 */

({
     doInit : function(component, event, helper) {
        component.set("v.columns",helper.getColumnDefinitions() );
        component.set("v.attributeNameMap", helper.getAttributeNameMap(component));
        component.set("v.allowedAttributeValueByCodeMap", helper.getAllowableAttributeValueByCodeMap(component));
        component.set("v.predefinedPlanBenefits", helper.getPlanBenefitList(component));
        helper.assignPlanBenefits(component);
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
            case 'edit_attribute_value':
                helper.editBenefitAttributeValue(component,row);
                break;
        }
    },

    reloaddatatable: function(component, event, helper){
       helper.assignPlanBenefits(component);
       component.set("v.data", helper.getRows(component));
    },

    readCSV : function(component, event, helper) {
        helper.readCSVFile(component, event, helper);
    },


});