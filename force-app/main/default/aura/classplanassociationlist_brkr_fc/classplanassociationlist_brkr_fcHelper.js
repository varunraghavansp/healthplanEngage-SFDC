/**
 * Created by varun on 11/7/2019.
 */

({
    setColumns: function(component){
        var classColumns = [
            { label: 'Class Id', fieldName: 'Name', type: 'text'},
            { label: 'Class Type', fieldName: 'Class_Type__c', type: 'text'},
            { label: 'Class Description', fieldName: 'Class_Description__c', type: 'text'}
        ];
        var classPlanColumns = [
            { label: 'Plan Name', fieldName: 'Plan_Name__c', type: 'text'},
            { label: 'Plan Family', fieldName: 'Plan_Family__c', type: 'text'},
            { label: 'Marketing Plan Name', fieldName: 'Marketing_Plan_Name__c', type: 'text'},
            { label: 'Effective Date', fieldName: 'Effective_Date__c', type: 'text'}
        ];
        component.set("v.classColumns",classColumns);
        component.set("v.classPlanColumns",classPlanColumns);
    },

    populateDetailGrid : function(component) {
        var groupClassInformation = component.get("v.groupClassInformation");
        if (!$A.util.isUndefined(groupClassInformation) && !$A.util.isEmpty(groupClassInformation)) {
            component.set("v.classRows", groupClassInformation);
            component.set("v.rowsInitialized",true);
        }
    },

    setClassPlanMap : function(component){
        var groupClassInformation = component.get("v.groupClassInformation");
        var groupPlans = component.get("v.groupPlans");
        var quote = component.get("v.quote");
        var isDisabled = component.get("v.disableFields");
        var classPlans = component.get("v.selectedClassPlans");
        var allClassPlanMap = {};
        var selectedClassPlans = [];
        if(!isDisabled){
             groupClassInformation.forEach(function(groupClassRecord){
                var allClassPlans = [];
                groupPlans.forEach(function(groupPlan){
                    allClassPlans.push({ 'Marketing_Plan__c': groupPlan.Id, 'Plan_Name__c': groupPlan.Plan_Name__c, 'Plan_Family__c': groupPlan.Plan_Family__c,'Marketing_Plan_Name__c': groupPlan.Name ,'Group_Class__c': groupClassRecord.Id, 'Effective_Date__c': '07/01/2020', 'Quote_Request__c': quote.Id});
                    selectedClassPlans.push({ 'Marketing_Plan__c': groupPlan.Id, 'Plan_Name__c': groupPlan.Plan_Name__c, 'Plan_Family__c': groupPlan.Plan_Family__c,'Marketing_Plan_Name__c': groupPlan.Name ,'Group_Class__c': groupClassRecord.Id, 'Effective_Date__c': '07/01/2020', 'Quote_Request__c': quote.Id});
                })
                allClassPlanMap[groupClassRecord.Id] = allClassPlans;
            })
        }else{
            classPlans.forEach(function(classPlan){
                var classPlanList = allClassPlanMap[classPlan.Group_Class__c];
                if($A.util.isUndefinedOrNull(classPlanList)){
                    classPlanList = [];
                };
                classPlanList.push(classPlan);
                allClassPlanMap[classPlan.Group_Class__c] = classPlanList;
            });
        }

        component.set("v.allClassPlanMap", allClassPlanMap);
        component.set("v.selectedClassPlanMap", allClassPlanMap);
    },

});