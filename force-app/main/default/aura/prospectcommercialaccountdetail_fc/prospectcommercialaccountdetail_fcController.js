/**
 * Created by varun on 11/3/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.bindDropdownItems(component,helper);
    },

    strikeinputchanged: function(component, event, helper) {
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)) {
            if (chngSrc == 'Name') {
                helper.populatelegalname(component, event);
            } else if (chngSrc == 'Rating_Zipcode__c') {
                helper.updateRatingInfo(component, event, chngSrc);
            }
        }
    },
});