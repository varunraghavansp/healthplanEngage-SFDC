/**
 * Created by varun on 8/21/2019.
 */

({
    strikeinputchanged: function(component, event, helper){
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc))
        {
             switch(chngSrc){
                case 'Plan_Component__c':
                    helper.updateComponentInfo(component);
                    break;
                default:
                break;
             }
        }
    },
});