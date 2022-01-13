/**
 * Created by varun on 11/11/2019.
 */

({
     doInit : function(component, event, helper) {
        helper.setColumns(component);
        helper.populateDetailGrid(component);
    },

    handleRowSelectionChange : function(component, event, helper){
        var selectedClassPlanId = event.getParam('selectedrowid');
        var selectedClassPlan = {};
        var planBenefitMap = component.get("v.planBenefitMap");
        var proposedRateMap = component.get("v.proposedRateMap");
        console.log(JSON.stringify(planBenefitMap));
        if(!$A.util.isUndefinedOrNull(selectedClassPlanId) && selectedClassPlanId != ""){
            component.set("v.classPlanSelected", false);
            var selectedClassPlan = event.getParam('selectedrow')
            component.set("v.selectedClassPlan", selectedClassPlan);
            component.set("v.selectedPlanId", selectedClassPlan["Predefined_Plan__c"]);
            component.set("v.selectedClassPlanId",selectedClassPlan["Id"] );
            component.set("v.planBenefitsRows", planBenefitMap[selectedClassPlan["Predefined_Plan__c"]]);
            component.set("v.proposedRateRows", proposedRateMap[selectedClassPlan["Id"]]);
            console.log(JSON.stringify(component.get("v.proposedRateRows")));
            component.set("v.classPlanSelected",true);
        }else{
            component.set("v.classPlanSelected", false);
        }
    },

    handleSaveAction: function(component, event, helper){
        var draftProposedRates = event.getParam('draftValues');
        helper.editProposedRates(component, draftProposedRates);
        component.set("v.draftProposedRates",[]);
    }
});