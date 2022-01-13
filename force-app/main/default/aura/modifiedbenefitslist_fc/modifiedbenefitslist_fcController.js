/**
 * Created by varun on 8/26/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.populatePlanName(component);
        helper.parsePlanBenefitChanges(component);
        component.set("v.columns",helper.getColumnDefinitions() );
    },

    loaddatatables : function(component, event, helper) {
        component.set("v.createddata", helper.getRows(component.get("v.createPlanBenefits")));
        component.set("v.updateddata", helper.getRows(component.get("v.updatePlanBenefits")));
        component.set("v.deleteddata", helper.getRows(component.get("v.deletePlanBenefits")));

        component.set("v.nochangedata", helper.getRows(component.get("v.nochangePlanBenefits")));
        component.set("v.columnsinitalized",true);
    },
});