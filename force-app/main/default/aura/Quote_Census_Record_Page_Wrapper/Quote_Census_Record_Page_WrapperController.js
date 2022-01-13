/**
 * Created by varun on 2/22/2021.
 */

({
    doInit : function(component, event, helper) {
        helper.initQuoteCensus(component, event, helper);
    },

    downloadCSV : function(component, event, helper) {
        helper.downloadCSVFile(component, event, helper);
    },
});