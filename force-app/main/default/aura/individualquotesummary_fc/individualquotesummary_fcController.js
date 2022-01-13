/**
 * Created by varun on 11/3/2019.
 */

({
    doInit : function(component, event, helper) {

    },

    strikeinputchanged: function(component, event, helper) {
        var chngSrc = event.getParam("index");
        console.log(chngSrc);
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)) {
            if (chngSrc == 'Name') {
                helper.populatelegalname(component, event);
            } else if (chngSrc == 'postalCode') {
                helper.updateRatingInfo(component, event, chngSrc);
            }
        }
    },

    accntChanged : function(component, event, helper){
        console.log('Here');
        helper.updateaccountinfo(component, event);
    }
});