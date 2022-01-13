/**
 * Created by varun on 8/20/2019.
 */

({
    //Helper Method for Updating attribute value with selected attribute values
    updateAttributeInfo: function(component) {
        var attributeIdMap = component.get("v.attributeIdMap");
        var attributeValue = component.get("v.attributevalue");
        var selectedAttribute = {};
        if(!$A.util.isUndefinedOrNull(attributeValue)){
            var attributeId = attributeValue["he__Attribute__c"];
            selectedAttribute = attributeIdMap[attributeId];
            if(!$A.util.isUndefinedOrNull(selectedAttribute)){
                attributeValue["he__Attribute_Category__c"] = selectedAttribute["he__Attribute_Category__c"];
                attributeValue["he__Attribute_Name__c"] = selectedAttribute["he__Attribute_Name__c"];
                attributeValue["he__Attribute_Code__c"] = selectedAttribute["Name"];
                attributeValue["he__Value_Type__c"] = selectedAttribute["he__Value_Type__c"];
            }
        }
        attributeValue["he__Attribute_Value__c"] = "";
        attributeValue["Name"] = "";
        attributeValue["he__In_Network_Value__c"] = "";
        attributeValue["he__Out_Of_Network_Value__c"] = "";
        component.set("v.attributevalue",attributeValue);
    },
    //Helper Method for updating variant code to attribute value
    updateVariantCode: function(component) {
        var attributeValue = component.get("v.attributevalue");
        var attributeCode = "";
        var attributeValueAmt = "";
        var inNetworkValue = "";
        var outNetworkValue = "";
        var variantCode = "";
        if(!$A.util.isUndefinedOrNull(attributeValue)){
            attributeCode = attributeValue["he__Attribute_Code__c"];
            inNetworkValue = attributeValue["he__In_Network_Value__c"];
            outNetworkValue = attributeValue["he__Out_Of_Network_Value__c"];
            attributeValueAmt = outNetworkValue === "" ? inNetworkValue : inNetworkValue + "/" + outNetworkValue;
            variantCode = attributeCode + attributeValueAmt
        }
        attributeValue["he__Attribute_Value__c"] = attributeValueAmt;
        attributeValue["Name"] = variantCode;
        component.set("v.attributevalue",attributeValue);
    },
});