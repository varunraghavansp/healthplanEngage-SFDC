/**
 * Created by varun on 7/31/2019.
 */

({
	doInit : function(component, event, helper){
        helper.setColumns(component);
        helper.fetchAgencyData(component);
        helper.fetchAgentData(component);
	},

	newAgencyRelationRecord: function(component, event, helper){
        var account= component.get("v.account");
        var accountId = account["Id"];
        if(!$A.util.isUndefinedOrNull(accountId)){
            var selectedAgency = {
                "Agency__c" : "",
                "Commission_Split__c": "",
                "Customer_Account__c": accountId,
                "Effective_Date__c": account["Effective_Date__c"],
                "Is_Primary__c": false
            };
            component.set("v.selectedAgency", selectedAgency);
            component.set("v.selectedRecordId","");
            component.set("v.editAgency", true);
            component.set("v.showAddPopupModal", true);
        }
    },

    newAgentRelationRecord: function(component, event, helper){
        var account= component.get("v.account");
        var accountId = account["Id"];
        if(!$A.util.isUndefinedOrNull(accountId)){
            var selectedAgent = {
                "Account_Agency__c" : "",
                "Agency_Name__c": "",
                "Agent__c": "",
                "Agent_Name__c": "",
                "Customer_Account__c": accountId,
                "Effective_Date__c": account["Effective_Date__c"],
                "Is_Primary__c": false
            };
            component.set("v.selectedAgent", selectedAgent);
            component.set("v.selectedRecordId","");
            component.set("v.editAgency", false);
            component.set("v.showAddPopupModal", true);
        }
    },

    handleAgencyRowAction: function(component, event, helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'edit':
                var selectedAgency = {
                            "Agency__c" : row.Agency__c,
                            "Commission_Split__c": row.Commission_Split__c,
                            "Customer_Account__c": row.Customer_Account__c,
                            "Effective_Date__c": row.Effective_Date__c,
                            "Is_Primary__c": row.Is_Primary__c
                };
                component.set("v.selectedAgency", selectedAgency);
                component.set("v.selectedRecordId",row.Id);
                component.set("v.editAgency", true);
                component.set("v.showAddPopupModal", true);
                break;
            case 'delete':

                break;
        }
    },

    handleAgentRowAction: function(component, event, helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'edit':
                var selectedAgent = {
                            "Account_Agency__c" : row.Account_Agency__c,
                            "Agency_Name__c" : row.Agency_Name__c,
                            "Agent__c": row.Agent__c,
                            "Customer_Account__c": row.Customer_Account__c,
                            "Effective_Date__c": row.Effective_Date__c,
                            "Is_Primary__c": row.Is_Primary__c
                };
                component.set("v.selectedAgent", selectedAgent);
                component.set("v.selectedRecordId",row.Id);
                component.set("v.editAgency", false);
                component.set("v.showAddPopupModal", true);
                break;
            case 'delete':

                break;
        }
    },

    cancelModalPopup: function(component, event, helper){
        component.set("v.showAddPopupModal", false);
    },

    handleSubmit: function(component, event, helper){
    },

    handleSuccess: function(component, event, helper){
        component.set("v.showAddPopupModal", false);
        helper.fetchAgencyData(component);
        helper.fetchAgentData(component);
    }

});