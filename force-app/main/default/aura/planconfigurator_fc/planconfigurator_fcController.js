/**
 * Created by varun on 3/22/2020.
 */

({
    doInit : function(component, event, helper) {
        var attributeValues = component.get("v.Attribute_Value__c");
        var attributeValueIdMap = {};
        for(let attributeValue of attributeValues){
            attributeValueIdMap[attributeValue.Id] = attributeValue;
        }
        component.set("v.attributevalueidmap", attributeValueIdMap);
    },

    strikeinputchanged: function(component, event, helper) {
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)) {
            if (chngSrc == 'Id') {
                helper.populatePlanDetails(component, event);
            }
        }
    },

    componentSelectionChanged: function(component, event, helper){
        component.set("v.componentselected", false);
        var selectedcomponentid = event.getParam('selectedcomponentid');
        component.set("v.selectedcomponentid", selectedcomponentid);
        if($A.util.isUndefinedOrNull(selectedcomponentid) || selectedcomponentid === ''){
            component.set("v.componentselected", false);

        }else{
            component.set("v.componentselected", true);
        }
    },

    attributeValueChanged: function(component, event, helper){
        console.log(event.getParam('attributevalueid'));
        helper.updateMarketingPlanBenefits(component, event.getParam('attribute'), event.getParam('attributevalueid'));
        console.log(JSON.stringify(component.get("v.Marketing_Plan_Benefit__c")));
    }

});