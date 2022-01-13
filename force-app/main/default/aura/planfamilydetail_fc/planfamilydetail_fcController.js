/**
 * Created by varun on 8/16/2019.
 */
({
    doInit: function(component, event, helper) {
        helper.initPicklistValues(component, event, helper);
        helper.setProductLine(component, event, helper);
    },

    createorrevisechanged: function(component, event, helper) {
        var selectedProductLine = component.get("v.selectedplanfamily");
        component.set("v.disablecreationfields", !(component.get("v.createplanfamily")));
        if (!$A.util.isUndefined(selectedProductLine)) {
            component.set("v.selectedplanfamily", "");
        }
    },

    planfamilyselectionchanged: function(component, event, helper) {
        helper.setProductLine(component, event, helper);
    },

});