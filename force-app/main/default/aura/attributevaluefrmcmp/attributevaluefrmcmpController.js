/**
 * Created by varun on 8/20/2019.
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
                case 'he__In_Network_Value__c':
                    helper.updateVariantCode(component);
                    break;
                case 'he__Out_Of_Network_Value__c':
                    helper.updateVariantCode(component);
                    break;
                default:
                break;
             }
        }
    },
});