/**
 * Created by varun on 11/5/2019.
 */

({
    doInit : function(component, event, helper){
        var account = component.get("v.account");
        var quote = component.get("v.quote");
        var eligibility = component.get("v.eligibility");
        if(!$A.util.isUndefinedOrNull(quote)){
            eligibility["Customer_Account__c"] = account["Id"];
        }

        if(!$A.util.isUndefinedOrNull(quote)){
            eligibility["Quote__c"] = quote["Id"];
        }
        eligibility["Status__c"] = "Active";
        component.set("v.eligibility",eligibility);
    },

     handleSubmit: function(component, event, helper){
    },

    handleSuccess: function(component, event, helper){
    },

    handleEligiblityUpdate: function(component, event, helper){
        var chngSrc = event.getParam("index");
        if (!$A.util.isUndefined(chngSrc) && !$A.util.isEmpty(chngSrc))
            switch(chngSrc){
                case 'Total_Eligible_Employees__c':
                    //helper.setRT6Employees(component, helper);
                    //helper.setActiveEnrolledEmployees(component, helper);
                break;
                case 'Number_Cobra_Continuants__c':
                    helper.setRT6Employees(component, helper);
                break;
                case 'Total_Employees__c':
                    helper.setParticipationRequirement(component, helper);
                    helper.setActualParticipation(component, helper);
                    helper.setTotalEligibleEmployees(component, helper);
                break;
                case 'Participation_Requirement_Percent__c':
                    helper.setParticipationRequirement(component, helper);
                break;
                case 'Active_Enrolled_Employees__c':
                    helper.setActualParticipation(component, helper);
                    helper.setActiveEnrolledEmployees(component, helper);
                    helper.setRT6Employees(component, helper);
                    helper.setTotalEligibleEmployees(component, helper);
                break;
                case 'Eligible_Emp_w_coverage__c':
                   helper.setActiveEnrolledEmployees(component, helper);
                break;
                case 'Total_PartTime__c':
                    helper.setTotalEligibleEmployees(component, helper);
                break;
                case 'Number_Employees_WP__c':
                    helper.setTotalEligibleEmployees(component, helper);
                break;
                default:
                break;
            }
    }
});