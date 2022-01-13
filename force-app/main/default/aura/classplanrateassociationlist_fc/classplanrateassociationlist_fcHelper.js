/**
 * Created by varun on 11/11/2019.
 */

({
    setColumns: function(component){
        var classPlanColumns = [
            { label: 'Class ID', fieldName: 'Class_ID__c', type: 'text'},
            { label: 'Class Type', fieldName: 'Class_Type__c', type: 'text'},
            { label: 'Plan Name', fieldName: 'Plan_Name__c', type: 'text'},
            { label: 'Plan Family', fieldName: 'Plan_Family__c', type: 'text'},
            { label: 'Marketing Plan Name', fieldName: 'Marketing_Plan_Name__c', type: 'text'},
            { label: 'Effective Date', fieldName: 'Effective_Date__c', type: 'text'}
        ];
        var planBenefitsColumns = [
            { label: 'Component Type', fieldName: 'Component_Type__c', type: 'text', sortable: true},
            { label: 'Is Base Component Benefit', fieldName: 'Is_Base_Component_Benefit__c', type: 'boolean', sortable: true},
            { label: 'Is Key Benefit', fieldName: 'Is_Key_Benefit__c', type: 'boolean', sortable: true},
           { label: 'Attribute Category', fieldName: 'Attribute_Category__c', type: 'text', sortable: true},
           { label: 'Attribute Code', fieldName: 'Attribute_Code__c', type: 'text', sortable: true},
           { label: 'Attribute Display Name', fieldName: 'Attribute_Display_Name__c', type: 'text', sortable: true},
           { label: 'Attribute Value', fieldName: 'Attribute_Value_Amount__c', type: 'text', sortable: true},
           { label: 'In Network Display Value', fieldName: 'In_Network_Display_Name__c', type: 'text'},
           { label: 'Out of Network Display Value', fieldName: 'Out_Of_Network_Display_Value__c', type: 'text'}
        ];
        var proposedRateColumns = [
            {label: 'Subscriber Only($)', fieldName: 'Subscriber__c', type: 'currency', editable: true},
            { label: 'Subscriber Spouse($)', fieldName: 'Subscriber_And_Spouse__c', type: 'currency', editable: true},
            { label: 'Subscriber Child($)', fieldName: 'Subscriber_And_Child__c', type: 'currency', editable: true},
            { label: 'Family($)', fieldName: 'Family__c', type: 'currency', editable: true}
        ]
        component.set("v.classPlanColumns",classPlanColumns);
        component.set("v.planBenefitsColumns", planBenefitsColumns);
        component.set("v.proposedRateColumns", proposedRateColumns);
    },

    populateDetailGrid : function(component, helper) {
        component.set("v.showSpinner",true);
        var helper = this;
        var selectedClassPlans = component.get("v.selectedClassPlans");
        var planBenefitMap = component.get("v.planBenefitMap");
        var proposedRates = component.get("v.proposedRates");
        var proposedRateMap = component.get("v.proposedRateMap");
        if($A.util.isUndefinedOrNull(planBenefitMap)){
            planBenefitMap = {};
        }
        if($A.util.isUndefinedOrNull(proposedRateMap)){
            proposedRateMap = {};
        }
        component.set("v.classPlanRows", selectedClassPlans);
        component.set("v.rowsInitialized", true);
        var selectedPlanIds = new Set();
        var selectedComponentCodes = new Set();
        selectedClassPlans.forEach( function(selectedClassPlan){
            selectedPlanIds.add('\'' + selectedClassPlan["Marketing_Plan__c"] + '\'');
            selectedComponentCodes.add('\'' + selectedClassPlan["Plan_Component_Code__c"] + '\'');
        });
        var querymap = {};
        querymap['object'] = 'Marketing_Plan_Benefit__c';
        querymap['queryFields'] = 'Id, Marketing_Plan__c, Component_Type__c,Is_Base_Component_Benefit__c, Is_Key_Benefit__c,Attribute_Category__c, Attribute_Code__c, Attribute_Display_Name__c,Attribute_Value_Amount__c,In_Network_Display_Name__c,Out_Of_Network_Display_Value__c ';
        var filter = '';
        filter += 'Marketing_Plan__c IN (' + [...selectedPlanIds].join(',') + ')';
        querymap['filter'] = filter;
        var getPlanBenefitsAction = component.get("c.getRecords");
        getPlanBenefitsAction.setParams({
            "jsonString": JSON.stringify(querymap)
        });

        var getPlanBenefitsPromise = helper.executePromisedAction(component, getPlanBenefitsAction);
        getPlanBenefitsPromise
        .then(
            $A.getCallback(function(result) {
                var responsemsg = JSON.parse(result);
                var isSuccess = responsemsg.isSuccess;
                if(isSuccess == true){
                    var responsedata = responsemsg.results.data[0].Marketing_Plan_Benefit__c;
                    component.set("v.marketingPlanBenefits", responsedata);
                    var planBenefitMapList = [];
                    responsedata.forEach(function(predefinedPackageBenefit){
                        planBenefitMapList = planBenefitMap[predefinedPackageBenefit["Marketing_Plan__c"]];
                        if($A.util.isUndefinedOrNull(planBenefitMapList)){
                           planBenefitMapList = [];
                        }
                        planBenefitMapList.push(predefinedPackageBenefit);
                        planBenefitMap[predefinedPackageBenefit["Marketing_Plan__c"]] = planBenefitMapList;
                    });
                    component.set("v.planBenefitMap", planBenefitMap);

                    var querymap = {};
                    querymap['object'] = 'Base_Rate_Variant__c';
                    querymap['queryFields'] = 'Id, Base_Rate_Schedule__c, Policy_Form__c,Name, Subscriber__c,Subscriber_And_Child__c, Subscriber_And_Children__c, Subscriber_And_Family__c,Subscriber_And_Spouse__c,Variant_Code__c,Variant_Description__c ';
                    var filter = '';
                    filter += 'Variant_Code__c IN (' + [...selectedComponentCodes].join(',') + ')';
                    querymap['filter'] = filter;
                    console.log(JSON.stringify(querymap));
                    var getBaseRateVariantAction = component.get("c.getRecords");
                    getBaseRateVariantAction.setParams({
                        "jsonString": JSON.stringify(querymap)
                    });
                    var getBaseRateVariantsPromise = helper.executePromisedAction(component, getBaseRateVariantAction);
                    return getBaseRateVariantsPromise;
                }else{
                    console.log("Update Plan Benefit action failed with Error " + responsemsg.errMsg);
                }
            })
        )
        .then(
            $A.getCallback(function(result) {
                var responsemsg = JSON.parse(result);
                var isSuccess = responsemsg.isSuccess;
                if(isSuccess == true){
                    var responsedata = responsemsg.results.data[0].Base_Rate_Variant__c;
                    var idx = 0;
                    proposedRates = [];
                    responsedata.forEach(function(baseRateVariant){
                        selectedClassPlans.forEach(function(selectedClassPlan){
                            if(selectedClassPlan.Plan_Component_Code__c === baseRateVariant.Variant_Code__c){
                                var proposedRateRecord = {
                                    Subscriber__c : baseRateVariant.Subscriber__c,
                                    Subscriber_And_Spouse__c : baseRateVariant.Subscriber_And_Spouse__c,
                                    Subscriber_And_Child__c : baseRateVariant.Subscriber_And_Child__c,
                                    Family__c : baseRateVariant.Subscriber_And_Family__c,
                                    Proposed_Plan__c: selectedClassPlan.Id,
                                    idx : idx
                                }
                                proposedRates.push(proposedRateRecord);
                                idx = idx  +  1;
                            }
                        })
                    });
                    /*selectedClassPlans.forEach(function(selectedClassPlan){
                        if(selectedClassPlan.Plan_Component_Code__c === baseRateVariant.Variant_Code__c){
                            var proposedRateRecord = {
                                Subscriber__c : 250.00,
                                Subscriber_And_Spouse__c : 500.30,
                                Subscriber_And_Child__c : 475.25,
                                Family__c : 725.00,
                                Proposed_Plan__c: selectedClassPlan.Id,
                                idx : idx
                            }
                            proposedRates.push(proposedRateRecord);
                            idx = idx  +  1;
                        }
                    })*/
                    component.set("v.proposedRates", proposedRates);
                    proposedRates.forEach(function(proposedRate){
                        var proposedRateList = proposedRateMap[proposedRate.Proposed_Plan__c];
                        if($A.util.isUndefinedOrNull(proposedRateList)){
                            proposedRateList = [];
                        }
                        proposedRateList.push(proposedRate);
                        proposedRateMap[proposedRate.Proposed_Plan__c] = proposedRateList;
                    });
                    component.set("v.proposedRateMap", proposedRateMap);

                }else{
                    console.log("Update Base Rate Variant action failed with Error " + responsemsg.errMsg);
                }
            })
        )
        .catch(
            $A.getCallback(function(error) {
                console.log("Update Plan Benefit action failed with Error " + error.message);
            })
        )
        .finally($A.getCallback(function(){
            component.set("v.showSpinner",false);
        })
        );

    },

    editProposedRates : function(component, draftProposedRates){
        var proposedRateRows = component.get("v.proposedRateRows");
        var proposedRates = component.get("v.proposedRates");
        var proposedRateMap = component.get("v.proposedRateMap");
        var selectedClassPlanId = component.get("v.selectedClassPlanId");
          proposedRateRows = proposedRateRows.map(function(rowData) {
              for(let draftValue of draftProposedRates){
                  var draftRowIdx = parseInt(draftValue.idx.replace("row-",""));
                   if (rowData.idx === draftRowIdx){
                        rowData.Subscriber__c = draftValue.Subscriber__c === undefined? rowData.Subscriber__c : draftValue.Subscriber__c;
                        rowData.Subscriber_And_Spouse__c = draftValue.Subscriber_And_Spouse__c === undefined? rowData.Subscriber_And_Spouse__c : draftValue.Subscriber_And_Spouse__c;
                        rowData.Subscriber_And_Child__c = draftValue.Subscriber_And_Child__c === undefined? rowData.Subscriber_And_Child__c : draftValue.Subscriber_And_Child__c;
                        rowData.Family__c = draftValue.Family__c === undefined? rowData.Family__c : draftValue.Family__c;
                   }
              }
              return rowData;
          });
          proposedRateMap[selectedClassPlanId] = proposedRateRows;
          component.set("v.proposedRateRows", proposedRateRows);
          var proposedRateList = [];
          for(var key in proposedRateMap){
              proposedRateList.push(proposedRateMap[key]);
          }
        console.log(JSON.stringify(proposedRateList));
        component.set("v.proposedRates", proposedRateList);
    },

    //Helper Method for Executing Asynch Actions Through a Promise Wrapper
    executePromisedAction: function(component, action, callback) {
        return new Promise(function(resolve, reject) {
            action.setCallback(this, function(response) {
                var state = response.getState();
                if (state === "SUCCESS") {
                    var retVal = response.getReturnValue();
                    resolve(retVal);
                } else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            reject(Error("Error Message: " + errors[0].message));
                        } else {
                            reject(Error("Unknown Server Error"));
                        }
                    } else {
                        reject(Error("Unknown Error"));
                    }
                }
            });
            $A.enqueueAction(action);
        });
    },
});