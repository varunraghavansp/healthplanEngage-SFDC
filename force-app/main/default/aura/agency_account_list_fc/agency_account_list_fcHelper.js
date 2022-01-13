/**
 * Created by varun on 7/31/2019.
 */

({
    setColumns: function(component){
        var actions = [
            { label: 'Edit', name: 'edit' },
            { label: 'Delete', name: 'delete' }
        ];
        var agencyColumns = [
            { label: 'Agency', fieldName: 'Agency_Name__c', type: 'text' },
            { label: 'Is Primary', fieldName: 'Is_Primary__c', type: 'boolean' },
            { label: 'Effective Date', fieldName: 'Effective_Date__c', type: 'text' },
            { label: 'Commission Split(%)', fieldName: 'Commission_Split__c', type: 'number' },
            { type: 'action', typeAttributes: { rowActions: actions } }
        ];
        var agentColumns = [
                    { label: 'Agency', fieldName: 'Agency_Name__c', type: 'text' },
                    { label: 'Agent', fieldName: 'Agent_Name__c', type: 'text' },
                    { label: 'Is Primary', fieldName: 'Is_Primary__c', type: 'boolean' },
                    { label: 'Effective Date', fieldName: 'Effective_Date__c', type: 'text' },
                    { type: 'action', typeAttributes: { rowActions: actions } }
        ];
        component.set("v.agencyColumns", agencyColumns);
        component.set("v.agentColumns", agentColumns);
    },

    fetchAgencyData: function(component){
        var helper = this;
        var account = component.get("v.account");
        var accountId = account["Id"];
        var querymap = {};
        if(!$A.util.isUndefinedOrNull(accountId)){

            component.set("v.showSpinner",true);
            querymap["object"] = "Account_Agency__c";
            querymap["queryFields"] = "Id,Agency__c, Agency_Name__c,Commission_Split__c,Customer_Account__c,Effective_Date__c,Is_Primary__c,Termination_Date__c";
            querymap["searchField"] = "Customer_Account__c";
            querymap['searchTerm'] = accountId;
            var getAgencyAction = component.get("c.getUncachedRecords");
            getAgencyAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getAgencyPromise = helper.executePromisedAction(component, getAgencyAction);
            getAgencyPromise
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if(isSuccess == true){
                        var responsedata = responsemsg.results.data[0].Account_Agency__c;
                        component.set("v.agencyData", responsedata);
                        helper.setPrimaryAgency(component, responsedata);
                    }else{
                        console.log("Update Agency Grid action failed with Error " + responsemsg.errMsg);
                    }
                })
            )
            .catch(
                $A.getCallback(function(error) {
                    console.log("Update Agency Grid action failed with Error " + error.message);
                })
            )
            .finally($A.getCallback(function(){
                component.set("v.showSpinner",false);
            })
            );
        }
    },

    fetchAgentData: function(component){
        var helper = this;
        var account = component.get("v.account");
        var accountId = account["Id"];
        var querymap = {};
        if(!$A.util.isUndefinedOrNull(accountId)){
            component.set("v.showSpinner",true);
            querymap["object"] = "Account_Agent__c";
            querymap["queryFields"] = "Id, Account_Agency__c,Agency_Name__c,Agent__c,Agent_Name__c,Customer_Account__c,Effective_Date__c,Is_Primary__c,Termination_Date__c";
            querymap["searchField"] = "Customer_Account__c";
            querymap['searchTerm'] = accountId;
            var getAgentAction = component.get("c.getUncachedRecords");
            getAgentAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getAgentPromise = helper.executePromisedAction(component, getAgentAction);
            getAgentPromise
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if(isSuccess == true){
                        var responsedata = responsemsg.results.data[0].Account_Agent__c;
                        component.set("v.agentData", responsedata);
                        helper.setPrimaryAgent(component, responsedata);
                    }else{
                        console.log("Update Agent Grid action failed with Error " + responsemsg.errMsg);
                    }
                })
            )
            .catch(
                $A.getCallback(function(error) {
                    console.log("Update Agent Grid action failed with Error " + error.message);
                })
            )
            .finally($A.getCallback(function(){
                component.set("v.showSpinner",false);
            })
            );
        }
    },

    setPrimaryAgency: function(component, agencyRecords){
        agencyRecords.forEach(function(agencyRecord){
           if(agencyRecord.Is_Primary__c){
               component.set("v.primaryAgencyId", agencyRecord.Agency__c);
           }
        });
    },

    setPrimaryAgent: function(component, agentRecords){
        agentRecords.forEach(function(agentRecord){
           if(agentRecord.Is_Primary__c){
               component.set("v.primaryAgentId", agentRecord.Agent__c);
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