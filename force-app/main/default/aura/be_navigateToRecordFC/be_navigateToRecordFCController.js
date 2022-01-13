/**
 * Created by varun on 11/4/2019.
 */

({
    invoke: function (component, event, helper) {
        var navService = component.find('navService');
        var recordId = component.get('v.recordId');
        var objectName = component.get('v.sObject');
        var mode = component.get('v.mode').toLowerCase();
        helper.closeFocusedTab(component, event, helper);
        // Open the Record page in View mode first so that it persists after the Edit Modal closes
        var pageReference = {
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: objectName,
                actionName: 'view'
            }
        }
        navService.navigate(pageReference);

        if (mode == 'edit') {
            var pageReference = {
                type: 'standard__recordPage',
                attributes: {
                    recordId: recordId,
                    objectApiName: objectName,
                    actionName: mode
                }
            }
            navService.navigate(pageReference);
        }

    }
})