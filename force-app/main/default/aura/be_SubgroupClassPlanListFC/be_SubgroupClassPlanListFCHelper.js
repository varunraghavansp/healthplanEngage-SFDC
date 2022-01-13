/**
 * Created by varun on 11/7/2019.
 */

({
    setColumns: function(component){
         var subAccountColumns = [
            { label: 'Sub-Account Name', fieldName: 'Name', type: 'text' },
            { label: 'Sub-Account Type', fieldName: 'Sub_Account_Type__c', type: 'text' },
            { label: 'Status', fieldName: 'Status__c', type: 'text' },
            { label: 'Effective Date', fieldName: 'Effective_Date__c', type: 'date' },
            { label: 'Sub-Account Site', fieldName: 'Site', type: 'text' }
        ];
        var subAccountPlanColumns = [
            { label: 'Class ID', fieldName: 'Class_ID__c', type: 'text'},
            { label: 'Class Type', fieldName: 'Class_Type__c', type: 'text'},
            { label: 'Plan Family', fieldName: 'Plan_Family__c', type: 'text'},
            { label: 'Marketing Plan Name', fieldName: 'Marketing_Plan_Name__c', type: 'text'},
            { label: 'Plan Name', fieldName: 'Plan_Name__c', type: 'text'},
        ];
        component.set("v.subAccountColumns",subAccountColumns);
        component.set("v.subAccountPlanColumns",subAccountPlanColumns);
    },

    populateDetailGrid : function(component) {
        var subAccountInformation = component.get("v.subAccountInformation");
        if (!$A.util.isUndefined(subAccountInformation) && !$A.util.isEmpty(subAccountInformation)) {
            component.set("v.subAccountRows", subAccountInformation);
            component.set("v.rowsInitialized",true);
        }
    },

    setSubAccountClassPlanMap : function(component){
        var subAccountInformation = component.get("v.subAccountInformation");
        var subAccountClassPlans = component.get("v.subAccountClassPlans");

        var subAccountClassPlanMap = {};

        subAccountClassPlans.forEach(function(subAccountClassPlan){
            var subAccountClassPlanList = subAccountClassPlanMap[subAccountClassPlan.Installed_Account__c];
            if($A.util.isUndefinedOrNull(subAccountClassPlanList)){
                subAccountClassPlanList = [];
            }
            subAccountClassPlanList.push(subAccountClassPlan);
            subAccountClassPlanMap[subAccountClassPlan.Installed_Account__c] = subAccountClassPlanList;
        });

        component.set("v.allSubAccountClassPlanMap", subAccountClassPlanMap);
        component.set("v.selectedSubAccountClassPlanMap", subAccountClassPlanMap);
    },

});