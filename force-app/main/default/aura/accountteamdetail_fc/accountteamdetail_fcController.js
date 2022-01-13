/**
 * Created by varun on 11/5/2019.
 */

({
    doInit : function(component, event, helper) {
        helper.fetchAccountTeamData(component);
    },

    handleAccountRoleUpdate: function(component, event, helper){
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc)){
            switch(chngSrc){
                case 'accountManagerId':
                    helper.updateTeamMembers(component, component.get("v.accountTeamByRole.accountManagerId"), "Account Manager");
                break;
                case 'salesManagerId':
                    helper.updateTeamMembers(component, component.get("v.accountTeamByRole.salesManagerId"), "Sales Manager");
                break;
                case 'underwriterId':
                    helper.updateTeamMembers(component, component.get("v.accountTeamByRole.underwriterId"), "Underwriter");
                break;
                default:
                break;
            }
        }
    }
});