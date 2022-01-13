/**
 * Created by varun on 8/20/2019.
 */

({
    doInit : function(component, event, helper) {
        component.set("v.columns",helper.getColumnDefinitions() );
        helper.initChanges(component);
    },

    loaddatatables : function(component, event, helper) {
        component.set("v.createddata", helper.getRows(component.get("v.createAttributeValuesPrivate")));
        component.set("v.updateddata", helper.getRows(component.get("v.updateAttributeValuesPrivate")));
        component.set("v.deleteddata", helper.getRows(component.get("v.deleteAttributeValuesPrivate")));
        if(component.get("v.deleteAttributeValues").length > 0){
            component.set("v.deleteRecords",true);
        }else{
            component.set("v.deleteRecords",false);
        }
        component.set("v.nochangedata", helper.getRows(component.get("v.nochangeAttributeValues")));
        component.set("v.columnsinitalized",true);
        try{
            component.set("v.createAttributeValues", component.get("v.createAttributeValuesPrivate"));
            component.set("v.updateAttributeValues", component.get("v.updateAttributeValuesPrivate"));
            component.set("v.deleteAttributeValues", component.get("v.deleteAttributeValuesPrivate"));
        }catch(e){
            console.log(e);
        }
    },

});