/**
 * Created by varun on 11/5/2019.
 */

({
	doInit : function(component, event, helper){
        helper.setColumns(component);
        helper.fetchSubAccountData(component);
	},

	newSubAccountRecord: function(component, event, helper){
        var account= component.get("v.account");
        var accountId = account["Id"];
        if(!$A.util.isUndefinedOrNull(accountId)){
            var selectedSubAccount = {
                "Name" : account.Name,
                "Sub_Account_Type__c": "",
                "Status__c": "Pending",
                "Effective_Date__c": account["Effective_Date__c"],
                "Site": account["Site"],
                "TIN_EIN__c": account["TIN_EIN__c"],
                "Legal_Entity_Name__c": account["Legal_Entity_Name__c"],
                "Type": account["Type"],
                "Group_Category__c": account["Group_Category__c"],
                "Phone": account["Phone"],
                "Rating_City__c": account["Rating_City__c"],
                "Rating_County__c": account["Rating_County__c"],
                "Rating_Region__c": account["Rating_Region__c"],
                "Rating_State__c": account["Rating_State__c"],
                "Rating_Zipcode__c": account["Rating_Zipcode__c"],
                "BillingStreet": account["BillingStreet"],
                "BillingCity": account["BillingCity"],
                "BillingState": account["BillingState"],
                "BillingCountry": account["BillingCountry"],
                "BillingPostalCode": account["BillingPostalCode"],
                "ParentId": account["Id"],
                "RecordTypeId": "0126g000000gGJCAA2"
            };
            component.set("v.selectedSubAccount", selectedSubAccount);
            component.set("v.newSubAccount", selectedSubAccount);
            component.set("v.selectedRecordId","");
            component.set("v.addNewSubAccount", false);
            component.set("v.showAddPopupModal", true);
        }
    },

    handleSubAccountRowAction: function(component, event, helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'edit':
                var selectedSubAccount = {
                            "Name" : row.Name,
                            "Sub_Account_Type__c": row["Sub_Account_Type__c"],
                            "Status__c": row["Status__c"],
                            "Effective_Date__c": row["Effective_Date__c"],
                            "Site": row["Site"],
                            "TIN_EIN__c": row["TIN_EIN__c"],
                            "Legal_Entity_Name__c": row["Legal_Entity_Name__c"],
                            "Type": row["Type"],
                            "Group_Category__c": row["Group_Category__c"],
                            "Phone": row["Phone"],
                            "Rating_City__c": row["Rating_City__c"],
                            "Rating_County__c": row["Rating_County__c"],
                            "Rating_Region__c": row["Rating_Region__c"],
                            "Rating_State__c": row["Rating_State__c"],
                            "Rating_Zipcode__c": row["Rating_Zipcode__c"],
                            "BillingStreet": row["BillingStreet"],
                            "BillingCity": row["BillingCity"],
                            "BillingState": row["BillingState"],
                            "BillingCountry": row["BillingCountry"],
                            "BillingPostalCode": row["BillingPostalCode"],
                            "RecordTypeId": "0126g000000gGJCAA2"
                };
                component.set("v.selectedSubAccount", selectedSubAccount);
                component.set("v.selectedRecordId",row.Id);
                component.set("v.addNewSubAccount", false);
                component.set("v.showAddPopupModal", true);
                break;
            case 'delete':

                break;
        }
    },

    addNewSubAccount : function(component, event, helper){
        var account= component.get("v.account");
        var accountId = account["Id"];
        if(!$A.util.isUndefinedOrNull(accountId)){
            var newSubAccount = {
                "AccountId": accountId,
                "Phone": account["Phone"],
                "MailingAddress": account["BillingAddress"]
            };
            component.set("v.newSubAccount", newSubAccount);
            component.set("v.selectedRecordId","");
            component.set("v.showAddPopupModal", false);
            component.set("v.addNewSubAccount", true);
            component.set("v.showAddPopupModal", true);

        }
    },

    cancelModalPopup: function(component, event, helper){
        component.set("v.showAddPopupModal", false);
    },

    handleSubmit: function(component, event, helper){
    },

    handleSuccess: function(component, event, helper){
        component.set("v.showAddPopupModal", false);
        helper.fetchSubAccountData(component);
    }

});