/**
 * Created by varun on 11/5/2019.
 */

/**
 * Created by varun on 7/31/2019.
 */

({
	doInit : function(component, event, helper){
        helper.setColumns(component);
        helper.fetchContactData(component);
	},

	newContactRelationRecord: function(component, event, helper){
        var account= component.get("v.account");
        var accountId = account["Id"];
        if(!$A.util.isUndefinedOrNull(accountId)){
            var selectedContact = {
                "ContactId" : "",
                "AccountId": accountId,
                "IsActive": true,
                "StartDate": account["Effective_Date__c"],
                "Is_Primary__c": false,
                "Roles": ""
            };
            component.set("v.selectedContact", selectedContact);
            component.set("v.selectedRecordId","");
            component.set("v.addNewContact", false);
            component.set("v.showAddPopupModal", true);
        }
    },

    handleContactRowAction: function(component, event, helper){
        var action = event.getParam('action');
        var row = event.getParam('row');
        switch (action.name) {
            case 'edit':
                var selectedContact = {
                            "ContactId" : row.ContactId,
                            "AccountId": row.AccountId,
                            "IsActive": row.IsActive,
                            "StartDate": row.StartDate,
                            "Is_Primary__c": row.Is_Primary__c,
                            "Roles": row.Roles
                };
                component.set("v.selectedContact", selectedContact);
                component.set("v.selectedRecordId",row.Id);
                component.set("v.addNewContact", false);
                component.set("v.showAddPopupModal", true);
                break;
            case 'delete':

                break;
        }
    },

    addNewContact : function(component, event, helper){
        var account= component.get("v.account");
        var accountId = account["Id"];
        if(!$A.util.isUndefinedOrNull(accountId)){
            var newContact = {
                "AccountId": accountId,
                "Phone": account["Phone"],
                "MailingAddress": account["BillingAddress"]
            };
            component.set("v.newContact", newContact);
            component.set("v.selectedRecordId","");
            component.set("v.showAddPopupModal", false);
            component.set("v.addNewContact", true);
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
        helper.fetchContactData(component);
    }

});