/**
 * Created by varun on 8/26/2019.
 */



({
    doInit : function(component, event, helper) {
        helper.initPicklistValues(component, event, helper);
    },

    strikeinputchanged: function(component, event, helper) {
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)) {
            if (chngSrc == 'Id') {
                helper.populateBaseRate(component, event);
            }
        }
    },

    createorrevisechanged : function(component, event, helper) {
        var createBaseRateSchedule = component.get("v.createratefactor");
        if(createBaseRateSchedule){
            component.set("v.editratefactorid", "");
            component.set("v.disablecreationfields",false);
        }else{
            component.set("v.disablecreationfields",true);
            component.set("v.copyfrompplanfamilyid","");
            component.set("v.copyfromratefactorid", "");
        }
        helper.setBaseRateSchedule(component, event, helper);
    },

    resetpredefinedplan : function(component, event, helper) {
        helper.setBaseRateSchedule(component, event, helper);
    },
});