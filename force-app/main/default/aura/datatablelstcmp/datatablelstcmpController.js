/**
 * Created by varun on 9/4/2019.
 */

({
    doInit : function(component, event, helper) {
        component.set("v.columnsinitalized",true);
    },
    updateColumnSorting: function(component, event, helper) {
        var fieldName = event.getParam('fieldName');
        var sortDirection = event.getParam('sortDirection');
        component.set("v.sortedBy", fieldName);
        component.set("v.sortedDirection", sortDirection);
        helper.sortData(component, fieldName, sortDirection);
    },

    downloadCSV : function(component, event, helper) {
        helper.downloadCSVFile(component, event, helper);
    },

    uploadCSV : function(component, event, helper) {
        helper.readCSVFile(component, event, helper);
    },

    handleRowAction: function(component, event, helper) {
        var action = event.getParam('action');
        var row = event.getParam('row');
        var dataupdatedEvt = component.getEvent("dataupdated");
        switch (action.name) {
            case 'edit':
                dataupdatedEvt.setParam('data',{action: 'edit' ,selectedrow:row, rows: component.get("v.data")});
                dataupdatedEvt.fire();
                break;
            case 'delete':
                dataupdatedEvt.setParam('data',{action: 'delete' ,selectedrow:row, rows: component.get("v.data")});
                dataupdatedEvt.fire();
                break;
        }
    },
});