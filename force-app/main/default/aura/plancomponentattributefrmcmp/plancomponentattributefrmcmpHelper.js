/**
 * Created by varun on 8/21/2019.
 */

({
    //Helper Method for Updating attribute value with selected attribute values
    updateAttributeInfo: function(component) {
        var attributeIdMap = component.get("v.attributeIdMap");
        var componentAttribute = component.get("v.componentattribute");
        var selectedAttribute = {};
        if(!$A.util.isUndefinedOrNull(componentAttribute)){
            var attributeId = componentAttribute["he__Attribute__c"];
            selectedAttribute = attributeIdMap[attributeId];
            if(!$A.util.isUndefinedOrNull(selectedAttribute)){
                componentAttribute["he__Attribute_Category__c"] = selectedAttribute["he__Attribute_Category__c"];
                componentAttribute["he__Attribute_Code__c"] = selectedAttribute["Name"];
                componentAttribute["he__Attribute_Display_Name__c"] = selectedAttribute["he__Attribute_Display_Name__c"];
                componentAttribute["he__Attribute_Name__c"] = selectedAttribute["he__Attribute_Name__c"];
            }
        }
        componentAttribute["he__Is_Key_Benefit__c"] = false;
        component.set("v.componentattribute",componentAttribute);
    },
});