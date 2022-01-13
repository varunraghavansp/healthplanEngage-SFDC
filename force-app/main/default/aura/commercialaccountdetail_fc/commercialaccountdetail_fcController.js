/**
 * Created by varun on 11/3/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.bindDropdownItems(component,helper);
        var accnt = component.get("v.account");
        var accntId = "";
        if($A.util.isUndefinedOrNull(accnt) || $A.util.isEmpty(accnt["Id"]) || accnt["Id"] == ''){

        }else{
            accntId = accnt["Id"];
            component.set("v.accountId", accntId);
        }
    },

    strikeinputchanged: function(component, event, helper) {
        var chngSrc = event.getParam("index");
        console.log(chngSrc);
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)) {
            if (chngSrc == 'Name') {
                helper.populatelegalname(component, event);
            } else if (chngSrc == 'Rating_Zipcode__c') {
                helper.updateRatingInfo(component, event, chngSrc);
            }
        }
    },

    accntChanged : function(component, event, helper){
        console.log('Here');
        helper.updateaccountinfo(component, event);
    }
});