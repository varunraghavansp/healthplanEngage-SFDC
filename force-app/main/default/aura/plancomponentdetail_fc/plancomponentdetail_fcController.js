/**
 * Created by varun on 8/16/2019.
 */

({
    doInit : function(component, event, helper) {
            helper.initPicklistValues(component, event, helper);
        },

        createorrevisechanged : function(component, event, helper) {
            var createplancomponent = component.get("v.createplancomponent");
            if(createplancomponent){
                component.set("v.editplancomponentid", "");
                component.set("v.disablecreationfields",false);
            }else{
                component.set("v.disablecreationfields",true);
                component.set("v.copyfrompplanfamilyid","");
                component.set("v.copyfromplancomponentid", "");
            }
            helper.setProductComponent(component, event, helper);
        },

        resetplancomponent : function(component, event, helper) {
            helper.setProductComponent(component, event, helper);
        },
});