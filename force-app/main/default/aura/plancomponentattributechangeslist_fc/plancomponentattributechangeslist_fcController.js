/**
 * Created by varun on 8/20/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.parseAttributeChanges(component);
        component.set("v.columns",helper.getColumnDefinitions() );
    },

    loaddatatables : function(component, event, helper) {
        component.set("v.createddata", helper.getRows(component.get("v.createComponentAttributesPrivate")));
        component.set("v.updateddata", helper.getRows(component.get("v.updateComponentAttributesPrivate")));
        component.set("v.deleteddata", helper.getRows(component.get("v.deleteComponentAttributesPrivate")));
        if(component.get("v.deleteComponentAttributes").length > 0){
            component.set("v.deleteRecords",true);
        }else{
            component.set("v.deleteRecords",false);
        }
        component.set("v.nochangedata", helper.getRows(component.get("v.nochangeComponentAttributes")));
        component.set("v.columnsinitalized",true);
         try{
                component.set("v.createComponentAttributes", component.get("v.createComponentAttributesPrivate"));
                component.set("v.updateComponentAttributes", component.get("v.updateComponentAttributesPrivate"));
                component.set("v.deleteComponentAttributes", component.get("v.deleteAttributeValuesPrivate"));
            }catch(e){
                console.log(e);
            }
    },

});