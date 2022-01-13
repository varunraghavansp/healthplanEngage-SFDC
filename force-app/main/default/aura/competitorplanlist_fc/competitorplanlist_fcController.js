/**
 * Created by varun on 11/6/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.setColumns(component);
        helper.populateDetailGrid(component);
    },

    competitorPlanInformationChanged: function(component, event, helper){
        helper.populateDetailGrid(component);
    },

    handleRowSelectionChange : function(component, event, helper){
        var selectedCompetitorId = event.getParam('selectedrowid');
        if(!$A.util.isUndefinedOrNull(selectedCompetitorId) && selectedCompetitorId != ""){
            component.set("v.selectedCompetitor", event.getParam('selectedrow'));
            component.set("v.competitorSelected",true);
        }else{
            component.set("v.competitorSelected", false);
        }

    },

    readCSV : function(component, event, helper) {
        helper.readCSVFile(component, event, helper);
    },

    placeholder : function(component, event, helper) {

    },
});