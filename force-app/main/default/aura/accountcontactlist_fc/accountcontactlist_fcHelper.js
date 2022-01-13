/**
 * Created by varun on 7/31/2019.
 */

({
    setColumns: function(component){
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        var accountContactColumns = [
            { label: 'Account', fieldName: 'Account_Name__c', type: 'text' },
            { label: 'Contact', fieldName: 'Contact_Name__c', type: 'text' },
            { label: 'Is Primary', fieldName: 'Is_Primary__c', type: 'boolean' },
            { label: 'StartDate', fieldName: 'StartDate', type: 'text' },
            { label: 'Roles', fieldName: 'Roles', type: 'text' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ];

        component.set("v.accountContactColumns", accountContactColumns);
    },

    fetchContactData: function(component){
        var helper = this;
        var account = component.get("v.account");
        var accountId = account["Id"];
        var querymap = {};
        if(!$A.util.isUndefinedOrNull(accountId)){

            component.set("v.showSpinner",true);
            querymap["object"] = "AccountContactRelation";
            querymap["queryFields"] = "Id,AccountId, Account_Name__c,IsActive,ContactId,Contact_Name__c,Is_Primary__c,Roles,StartDate ";
            querymap["searchField"] = "AccountId";
            querymap['searchTerm'] = accountId;
            var getContactAction = component.get("c.getUncachedRecords");
            getContactAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getContactPromise = helper.executePromisedAction(component, getContactAction);
            getContactPromise
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if(isSuccess == true){
                        var responsedata = responsemsg.results.data[0].AccountContactRelation;
                        component.set("v.accountContactData", responsedata);
                        helper.setPrimaryContact(component, responsedata);
                    }else{
                        console.log("Update Contact Grid action failed with Error " + responsemsg.errMsg);
                    }
                })
            )
            .catch(
                $A.getCallback(function(error) {
                    console.log("Update Contact Grid action failed with Error " + error.message);
                })
            )
            .finally($A.getCallback(function(){
                component.set("v.showSpinner",false);
            })
            );
        }
    },

    setPrimaryContact: function(component, contactRecords){
        contactRecords.forEach(function(contactRecord){
           if(contactRecord.Is_Primary__c){
               component.set("v.primaryContactId", contactRecord.ContactId);
           }
        });
    },

	//Helper Method for Executing Asynch Actions Through a Promise Wrapper
    executePromisedAction: function(component, action, callback) {
        return new Promise(function(resolve, reject) {
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var retVal = response.getReturnValue();
                    resolve(retVal);
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            reject(Error("Error Message: " + errors[0].message));
                        } else {
                            reject(Error("Unknown Server Error"));
                        }
                    } else {
                        reject(Error("Unknown Error"));
                    }
                }
            });
            $A.enqueueAction(action);
        });
    },

});