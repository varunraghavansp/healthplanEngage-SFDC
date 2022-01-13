/**
 * Created by varun on 8/18/2019.
 */

({
    doInit : function(component, event, helper) {
        //ToDo Add Filter for Plan Family Selection By Name
    },

    strikeinputchanged: function(component, event, helper) {
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)) {
            if (chngSrc == 'Package_Framework__c') {
                helper.populatePlanName(component, event);
            }
        }
    },

    createorrevisechanged : function(component, event, helper) {
        var createPredefinedPlan = component.get("v.createpredefinedplan");
        if(createPredefinedPlan){
            component.set("v.editpredefinedpackageid", "");
            component.set("v.disablecreationfields",false);
        }else{
            component.set("v.disablecreationfields",true);
            component.set("v.copyfrompplanfamilyid","");
            component.set("v.copyfrompredefinedpackageid", "");
        }
        helper.setPredefinedPlan(component, event, helper);
    },

    resetpredefinedplan : function(component, event, helper) {
        helper.setPredefinedPlan(component, event, helper);
    },
});