/**
 * Created by varun on 7/31/2019.
 */

({

    	doInit : function(component, event, helper) {
    	    console.log(component.get("v.disableFields"));
            helper.setColumns(component);
    		helper.populateContactGird(component, event, helper);
    	},

        handlesubselectionchange: function(component, event, helper){
            component.set("v.selectedsubscriberid", event.getParam('selectedrowid'));
        },

        selectdependents: function(component, event, helper){
            var selectedSubscriber = component.get("v.selectedsubscriberid");
            var selectedDependents = [];
             if ($A.util.isUndefined(selectedSubscriber) || $A.util.isEmpty(selectedSubscriber)){
                 //Do Nothing
             }else{
                 var quotecensusdependents = component.get("v.quotecensusdependent");
                 for(var idx in quotecensusdependents){
                     if(quotecensusdependents[idx].Employee_Number__c == selectedSubscriber){
                         selectedDependents.push(quotecensusdependents[idx]);
                     }
                 }
             }
             component.set("v.selectedsubdependents",selectedDependents);
        },

    	quotecensuschngd: function(component, event, helper){
    	    helper.populateContactGird(component, event, helper);
        },

    	readCSV : function(component, event, helper) {
    		helper.readCSVFile(component, event, helper);
    	},

    	placeholder : function(component, event, helper) {

    	},
});