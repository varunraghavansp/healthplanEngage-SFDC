/**
 * Created by varun on 7/31/2019.
 */

({
    setColumns: function(component){
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        var subAccountColumns = [
            { label: 'Sub-Account Name', fieldName: 'Name', type: 'text' },
            { label: 'Sub-Account Type', fieldName: 'Sub_Account_Type__c', type: 'text' },
            { label: 'Status', fieldName: 'Status__c', type: 'text' },
            { label: 'Effective Date', fieldName: 'Effective_Date__c', type: 'date' },
            { label: 'Sub-Account Site', fieldName: 'Site', type: 'text' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ];
        component.set("v.subAccountColumns", subAccountColumns);
    },

    fetchSubAccountData: function(component){
        var helper = this;
        var account = component.get("v.account");
        var accountId = account["Id"];
        var querymap = {};
        if(!$A.util.isUndefinedOrNull(accountId)){

            component.set("v.showSpinner",true);
            querymap["object"] = "Account";
            querymap["queryFields"] = "Id, Name, Sub_Account_Type__c,Status__c,Effective_Date__c,Site, TIN_EIN__c, AccountNumber, Legal_Entity_Name__c, RecordTypeId, Type, Group_Category__c, Phone, Rating_City__c, Rating_County__c, Rating_Region__c, Rating_State__c, Rating_Zipcode__c, BillingAddress, ParentId, BillingStreet, BillingCity, BillingState, BillingCountry, BillingPostalCode  ";
            querymap["searchField"] = "ParentId";
            querymap['searchTerm'] = accountId;
            var getSubAccountsAction = component.get("c.getUncachedRecords");
            getSubAccountsAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getSubAccountPromise = helper.executePromisedAction(component, getSubAccountsAction);
            getSubAccountPromise
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if(isSuccess == true){
                        var responsedata = responsemsg.results.data[0].Account;
                        component.set("v.subAccountData", responsedata);
                        component.set("v.subAccount", responsedata);
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