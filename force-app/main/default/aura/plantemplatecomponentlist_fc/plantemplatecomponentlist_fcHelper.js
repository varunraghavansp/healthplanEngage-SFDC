/**
 * Created by varun on 8/18/2019.
 */

({
    //returns Column Definition for datatable
    getColumnDefinitions: function () {
       var actions = [
                   { label: 'Delete', name: 'delete' }
       ];
       var columns = [
           { label: 'Component Name', fieldName: 'Component_Name__c', sortable: true, type: 'text'},
           { label: 'Component Type', fieldName: 'Component_Type__c', type: 'text', sortable: true},
           { label: 'Is Base Component', fieldName: 'Is_Base_Component__c', type: 'boolean', sortable: true},
           { type: 'action', typeAttributes: { rowActions: actions } }
       ];
       return columns;
    },
    //creates a Map of the Attributes Ids
    getComponentIdMap: function(component) {
       var planComponents = component.get("v.Plan_Component__c");
       var componentIdMap = {}
       for (let planComponent of planComponents){
           componentIdMap[planComponent['Id']] = planComponent;
       }
       return componentIdMap;
    },
    //creates a Map of the Product Component Attribute Names
    getTemplateComponentNameMap: function(component){
        var allPlanTemplateComponents = component.get("v.Plan_Template_Component__c");
        var templateComponentNameToIdMap =  {};
        if (!$A.util.isUndefined(allPlanTemplateComponents) && !$A.util.isEmpty(allPlanTemplateComponents)){
           for(let templateComponent of allPlanTemplateComponents){
               templateComponentNameToIdMap[templateComponent.Component_Name__c] = templateComponent;
           }
        }
        return templateComponentNameToIdMap;
    },
    //returns row definition for datatable
    getRows: function(component){
       var templateComponents = component.get("v.Plan_Template_Component__c");
       var row = {};
       var rows = [];
       if (!$A.util.isUndefined(templateComponents) && !$A.util.isEmpty(templateComponents)){
           for(let templateComponent of templateComponents){
               row = {
                   "id": templateComponent.Component_Name__c,
                   "Component_Name__c": templateComponent.Component_Name__c,
                   "Component_Type__c": templateComponent.Component_Type__c,
                   "Product_Component__c": templateComponent.Product_Component__c,
                   "Plan_Template__c": templateComponent.Plan_Template__c,
                   "Is_Base_Component__c": templateComponent.Is_Base_Component__c
               };
               rows.push(row);
           }
       }
       return rows;
    },

    sortData: function (component, fieldName, sortDirection) {
       var data = component.get("v.data");
       var reverse = sortDirection !== 'asc';
       data = Object.assign([],
           data.sort(this.sortBy(fieldName, reverse ? -1 : 1)));
           component.set("v.data", data);
    },

    sortBy: function (field, reverse, primer) {
       var key = primer ? function(x){return primer(x[field]);} : function(x) {return x[field];};
       return function (a, b) {
           var A = key(a);
           var B = key(b);
           return reverse * ((A > B) - (B > A));
       };
    },
    //returns new instance of attributevalue
    newPlanTemplateComponent: function (planTemplate) {
       var planTemplateComponent = {
             'Id':'',
             'Component_Name__c':'',
             'Component_Type__c':'',
             'Is_Base_Component__c':'',
             'Product_Component__c':'',
             'Is_Key_Benefit__c': false,
             'Plan_Template__c': planTemplate["Id"]
       };
       return planTemplateComponent;
    },
    //returns existing instance of attributevalue
    deletePlanTemplateComponent: function (component, row) {
       var rowId = row["id"];
       var planTemplateComponents = component.get("v.Plan_Template_Component__c");
       var spliceIdx = -1;
       for(var idx in planTemplateComponents){
           if(planTemplateComponents[idx]["Component_Name__c"] == rowId){
               spliceIdx = idx
               break;
           }
       }
       if(spliceIdx >= 0){
           planTemplateComponents.splice(spliceIdx, 1);
       }
       component.set("v.Plan_Template_Component__c",planTemplateComponents);
    },
    //save attribute value
    savePlanTemplateComponent: function (component) {
       var errorMessage = "";
       var savedTemplateComponentRecord = component.get("v.selectedtemplatecomponent");
       var planTemplateComponents = component.get("v.Plan_Template_Component__c");
       var spliceIdx = -1;
       for(var idx in planTemplateComponents){
           if(planTemplateComponents[idx]["Component_Name__c"] == savedTemplateComponentRecord["Component_Name__c"]){
               spliceIdx = idx;
               break;
           }
       }
       if(spliceIdx >= 0){
           planTemplateComponents.splice(spliceIdx, 1);
       }
       planTemplateComponents.push(savedTemplateComponentRecord);
       component.set("v.Plan_Template_Component__c",planTemplateComponents);
    },
    //Toggles Modal Popup State
    togglemodelpopup: function(component, event, helper) {
       var showmodalpopup = component.get("v.showaddpopupmodal");
       if (showmodalpopup)
           component.set("v.showaddpopupmodal", false);
       else
           component.set("v.showaddpopupmodal", true);
    },

});