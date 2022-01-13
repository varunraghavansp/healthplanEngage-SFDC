/**
 * Created by varun on 11/6/2019.
 */

({
    doInit : function(component, event, helper) {
         helper.bindDropdownItems(component,helper);
    },

     strikeinputchanged: function(component, event, helper){
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc))
        {
            if(chngSrc === "Subscriber_Only_Medical__c" || chngSrc === "Subscriber_Only_Prescription_Drug__c" || chngSrc === "Subscriber_Only_Incentives__c" || chngSrc === "Subscriber_Only_Medical_Management__c"){
                helper.updateRates(component, helper);
            }else if(chngSrc === "Subscriber_Spouse_Medical__c" || chngSrc === "Subscriber_Spouse_Prescription_Drug__c" || chngSrc === "Subscriber_Spouse_Incentives__c" || chngSrc === "Subscriber_Spouse_Medical_Management__c"){
                helper.updateRates(component, helper);
            }else if(chngSrc === "Subscriber_Children_Medical__c" || chngSrc === "Subscriber_Children_Prescription_Drug__c" || chngSrc === "Subscriber_Children_Incentives__c" || chngSrc === "Subscriber_Children_Medical_Management__c"){
                helper.updateRates(component, helper);
             }else if(chngSrc === "Family_Medical__c" || chngSrc === "Family_Prescription_Drug__c" || chngSrc === "Family_Incentives__c" || chngSrc === "Family_Medical_Management__c"){
                helper.updateRates(component, helper);
            }else if(chngSrc === "Tier__c"){

            }
        }
    },
});