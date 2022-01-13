/**
 * Created by varun on 11/5/2019.
 */

({
    setTotalEligibleEmployees : function(component, helper) {
        var totalEmployees = parseInt(component.get("v.eligibility.Total_Employees__c"));
        var totalPartTime = parseInt(component.get("v.eligibility.Total_PartTime__c"));
        var totalWaitingPeriod = parseInt(component.get("v.eligibility.Number_Employees_WP__c"));
        var totalEligibleEmployees = totalEmployees - (totalPartTime  + totalWaitingPeriod);
        component.set("v.eligibility.Total_Eligible_Employees__c",totalEligibleEmployees);
    },

    setActiveEnrolledEmployees : function(component, helper) {
        var totalEligibleEmployees = parseInt(component.get("v.eligibility.Total_Eligible_Employees__c"));
        var totalEligiblewOtherCoverage = parseInt(component.get("v.eligibility.Eligible_Emp_w_coverage__c"));
        component.set("v.eligibility.Active_Enrolled_Employees__c",totalEligibleEmployees - totalEligiblewOtherCoverage);
    },

    setRT6Employees : function(component, helper) {
        var totalEligibleEmployees = parseInt(component.get("v.eligibility.Total_Eligible_Employees__c"));
        var cobraContinuants = parseInt(component.get("v.eligibility.Number_Cobra_Continuants__c"));
        component.set("v.eligibility.Number_Employees_RT6__c",totalEligibleEmployees + cobraContinuants);
    },

    setParticipationRequirement : function(component, helper) {
        var totalEmployees = parseInt(component.get("v.eligibility.Total_Employees__c"));
        var participationRequirementPercent = parseInt(component.get("v.eligibility.Participation_Requirement_Percent__c"));
        var participationRequirement = 0.01 * participationRequirementPercent * totalEmployees;
        component.set("v.eligibility.Participation_Requirement__c", (parseInt(participationRequirement)));
    },

    setActualParticipation : function(component, helper) {
        var activeEnrolledEmployees = parseInt(component.get("v.eligibility.Active_Enrolled_Employees__c"));
        var totalEmployees = parseInt(component.get("v.eligibility.Total_Employees__c"));
        var actualGroupParticipation = parseInt((activeEnrolledEmployees / totalEmployees) * 100);
        component.set("v.eligibility.Actual_Group_Participation__c" , actualGroupParticipation );
    },
});