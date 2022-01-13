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
            if (chngSrc == 'Plan_Template__c') {
                helper.populatePlanName(component, event);
            }
        }
    },

    createorrevisechanged : function(component, event, helper) {
        var createMarketingPlan = component.get("v.createmarketingplan");
        if(createMarketingPlan){
            component.set("v.editmarketingplanid", "");
            component.set("v.disablecreationfields",false);
        }else{
            component.set("v.disablecreationfields",true);
            component.set("v.copyfrompplanfamilyid","");
            component.set("v.copyfrommarketingplanid", "");
        }
        helper.setMarketingPlan(component, event, helper);
    },

    resetmarketingplan : function(component, event, helper) {
        helper.setMarketingPlan(component, event, helper);
    },
});