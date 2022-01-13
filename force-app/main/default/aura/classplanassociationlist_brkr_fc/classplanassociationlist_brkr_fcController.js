/**
 * Created by varun on 11/7/2019.
 */

({
     doInit : function(component, event, helper) {
        helper.setColumns(component);
        helper.populateDetailGrid(component);
        helper.setClassPlanMap(component);
    },

    handleRowSelectionChange : function(component, event, helper){
        var selectedClassId = event.getParam('selectedrowid');
        var allClassPlanMap = component.get("v.allClassPlanMap");
        var selectedClassPlanMap = component.get("v.selectedClassPlanMap");
        if(!$A.util.isUndefinedOrNull(selectedClassId) && selectedClassId != ""){
            component.set("v.classSelected", false);
            component.set("v.selectedClass", event.getParam('selectedrow'));
            component.set("v.selectedClassId", selectedClassId);
            component.set("v.classPlanRows", allClassPlanMap[selectedClassId]);
            component.set("v.classPlanRowSelection", selectedClassPlanMap[selectedClassId]);
            component.set("v.classSelected",true);
        }else{
            component.set("v.classSelected", false);
        }
    },

    updateClassPlanAssociation : function(component, event, handler){
        var toast = $A.get("e.force:showToast");
        var selectedClassId = component.get("v.selectedClassId");
        var classPlanRowSelection = component.get("v.classPlanRowSelection");
        console.log(classPlanRowSelection);
        var selectedClassPlanMap = component.get("v.selectedClassPlanMap");
        var selectedClassPlans = [];
        for(var key in selectedClassPlanMap){
            if(selectedClassPlanMap[key] === selectedClassId){
                selectedClassPlanMap[key] = classPlanRowSelection;
            }
            selectedClassPlanMap[key].forEach(function(selectedClassPlan){
                selectedClassPlans.push(selectedClassPlan);
            });
        }
        component.set("v.selectedClassPlans", selectedClassPlans);
        component.set("v.selectedClassPlanMap", selectedClassPlanMap);

            toast.setParams({
                                    "title": "Success!",
                                    "message": "Plan Associated"
                                });
                                toast.fire();
        console.log(selectedClassPlans);
    }



});