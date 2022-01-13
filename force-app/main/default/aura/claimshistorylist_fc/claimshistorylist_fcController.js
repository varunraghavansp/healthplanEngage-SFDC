/**
 * Created by varun on 11/6/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.setColumns(component);
        var disabledFields = component.get("v.disableFields");
        helper.populateDetailGrid(component);
        if(disabledFields){
            helper.initializeCharts(component);
        }
    },

    quoteClaimHistoryChngd: function(component, event, helper){
        helper.populateDetailGrid(component);
    },

    calculateMLRRatio: function(component, event, helper){
        helper.initializeCharts(component);
    },

    readCSV : function(component, event, helper) {
        helper.readCSVFile(component, event, helper);
    },
});