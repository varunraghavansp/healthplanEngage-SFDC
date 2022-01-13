/**
 * Created by varun on 8/21/2019.
 */

({
    //Helper Method for Updating attribute value with selected attribute values
    updateComponentInfo: function(component) {
        var componentIdMap = component.get("v.componentIdMap");
        var templateComponent = component.get("v.plantemplatecomponent");
        var selectedComponent = {};
        if(!$A.util.isUndefinedOrNull(templateComponent)){
            var componentId = templateComponent["Plan_Component__c"];
            selectedComponent = componentIdMap[componentId];
            if(!$A.util.isUndefinedOrNull(selectedComponent)){
                templateComponent["Component_Name__c"] = selectedComponent["Name"];
                templateComponent["Component_Type__c"] = selectedComponent["Product_Component_Type__c"];
                templateComponent["Is_Base_Component__c"] = selectedComponent["Is_Base_Component__c"];
            }
        }
        component.set("v.plantemplatecomponent",templateComponent);
    },
});