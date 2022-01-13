/**
 * Created by varun on 8/20/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.parseComponentChanges(component);
        component.set("v.columns",helper.getColumnDefinitions() );
    },

    loaddatatables : function(component, event, helper) {
        component.set("v.createddata", helper.getRows(component.get("v.createPlanTemplateComponentsPrivate")));
        component.set("v.updateddata", helper.getRows(component.get("v.updatePlanTemplateComponentsPrivate")));
        component.set("v.deleteddata", helper.getRows(component.get("v.deletePlanTemplateComponentsPrivate")));
        if(component.get("v.deletePlanTemplateComponents").length > 0){
            component.set("v.deleteRecords",true);
        }else{
            component.set("v.deleteRecords",false);
        }
        component.set("v.nochangedata", helper.getRows(component.get("v.noChangePlanTemplateComponents")));
        component.set("v.columnsinitalized",true);
        try{
            component.set("v.createPlanTemplateComponents", component.get("v.createPlanTemplateComponentsPrivate"));
            component.set("v.updatePlanTemplateComponents", component.get("v.updatePlanTemplateComponentsPrivate"));
            component.set("v.deletePlanTemplateComponents", component.get("v.deletePlanTemplateComponentsPrivate"));
        }catch(e){
            console.log(e);
        }
    },

});