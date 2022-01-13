/**
 * Created by varun on 8/21/2019.
 */

({
    strikeinputchanged: function(component, event, helper){
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc))
        {
             switch(chngSrc){
                case 'he__Attribute__c':
                    helper.updateAttributeInfo(component);
                    break;
                default:
                break;
             }
        }
    },
});