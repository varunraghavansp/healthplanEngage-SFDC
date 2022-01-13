/**
 * Created by varun on 8/18/2019.
 */

({
   doInit : function(component, event, helper) {
       helper.initPicklistValues(component, event, helper);
   },

   createorrevisechanged : function(component, event, helper) {
       var createplantemplate = component.get("v.createplantemplate");
       if(createplantemplate){
           component.set("v.editplantemplateid", "");
           component.set("v.disablecreationfields",false);
       }else{
           component.set("v.disablecreationfields",true);
           component.set("v.copyfrompplanfamilyid","");
           component.set("v.copyfromplantemplateid", "");
       }
       helper.setPlanTemplate(component, event, helper);
   },

resetproductcomponent : function(component, event, helper) {
       helper.setPlanTemplate(component, event, helper);
   },
});