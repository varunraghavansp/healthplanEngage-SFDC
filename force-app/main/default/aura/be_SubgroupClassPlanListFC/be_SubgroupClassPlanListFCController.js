/**
 * Created by varun on 11/7/2019.
 */

({
     doInit : function(component, event, helper) {
         console.log(JSON.stringify(component.get("v.account")));
         console.log(JSON.stringify(component.get("v.quote")));
         console.log(JSON.stringify(component.get("v.subAccountInformation")));
         console.log(JSON.stringify(component.get("v.accountClassPlans")));
         console.log(JSON.stringify(component.get("v.subAccountClassPlans")));
         console.log(JSON.stringify(component.get("v.accountClasses")));
         console.log(JSON.stringify(component.get("v.subAccountClasses")));
        helper.setColumns(component);
        helper.populateDetailGrid(component);
        helper.setSubAccountClassPlanMap(component);
    },

    handleRowSelectionChange : function(component, event, helper){
        var selectedSubAccountId = event.getParam('selectedrowid');
        var allSubAccountClassMap = component.get("v.allSubAccountClassMap");
        var selectedSubAccountClassMap = component.get("v.selectedSubAccountClassMap");
        var allSubAccountClassPlanMap = component.get("v.allSubAccountClassPlanMap");
        var selectedSubAccountClassPlanMap = component.get("v.selectedSubAccountClassPlanMap");

        if(!$A.util.isUndefinedOrNull(selectedSubAccountId) && selectedSubAccountId != ""){
            component.set("v.subAccountSelected", false);
            component.set("v.selectedSubAccount", event.getParam('selectedrow'));
            component.set("v.selectedSubAccountId", selectedSubAccountId);
            component.set("v.subAccountPlanRows", allSubAccountClassPlanMap[selectedSubAccountId]);
            component.set("v.subAccountClassPlanRowSelection", allSubAccountClassPlanMap[selectedSubAccountId]);
            component.set("v.subAccountSelected",true);
        }else{
            component.set("v.subAccountSelected", false);
        }
    },

    updateSubAccountSelectedRows: function(component, event, handler){

    },

    updateClassPlanAssociation : function(component, event, handler){

        //component.set("v.subAccountClasses", subAccountClasses);
        //component.set("v.selectedSubAccountClassMap", selectedSubAccountClassMap);
    }



});