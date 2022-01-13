/**
 * Created by varun on 8/18/2019.
 */

({
      //Set Product Component
    populatePlanDetails: function(component, event){
       var helper = this;
       var marketingPlan = component.get("v.Marketing_Plan__c");
       var marketingPlanId = marketingPlan["Id"];
       if(!$A.util.isUndefined(marketingPlanId) && marketingPlanId != ""){
           component.set("v.plantemplateselected",false);
           var querymap = {};
           querymap['object'] = 'Marketing_Plan__c';
           querymap['queryFields'] = 'Id, Name ,Effective_Date__c,Termination_Date__c,Plan_Template__c,Plan_Component_Code__c';
           querymap['searchField'] = 'Id';
           querymap['searchTerm'] = marketingPlanId;
           var getMarketingPlanAction = component.get("c.getRecords");
           getMarketingPlanAction.setParams({
               "jsonString": JSON.stringify(querymap)
           });
           var getMarketingPlanPromise = helper.executePromisedAction(component, getMarketingPlanAction);
           getMarketingPlanPromise
           .then(
                   $A.getCallback(function(result) {
                       var responsemsg = JSON.parse(result);
                       var isSuccess = responsemsg.isSuccess;
                       if (isSuccess == true) {
                           var responsedata = responsemsg.results.data[0];
                           var marketingPlan = responsedata.Marketing_Plan__c[0];
                           //If Selected for Creation, nullify Id
                           component.set("v.Marketing_Plan__c", marketingPlan);


                          var querymap = {};
                          querymap['object'] = 'Marketing_Plan_Benefit__c';
                          querymap['queryFields'] = 'Id, Attribute_Category__c, Attribute_Display_Name__c,Attribute_Id__c,Attribute_Long_Code__c,Attribute_Value__c,Component_Name__c,Component_Type__c,In_Network_Display_Name__c,Out_Of_Network_Display_Value__c,Plan_Template_Component__c,Marketing_Plan__c,Plan_Family__c,Attribute_Code__c,Attribute_Value_Amount__c,Is_Key_Benefit__c,Is_Base_Component_Benefit__c,Limits_And_Exceptions__c';
                          querymap['searchField'] = 'Marketing_Plan__c';
                          querymap['searchTerm'] = marketingPlanId;
                          var getPlanBenefitsAction = component.get("c.getRecords");
                          getPlanBenefitsAction.setParams({
                              "jsonString": JSON.stringify(querymap)
                          });
                          var getPlanBenefitsPromise = helper.executePromisedAction(component, getPlanBenefitsAction);
                          return getPlanBenefitsPromise;
                       } else {
                           console.log("Set marketingPlan attribute failed with Error " + responsemsg.errMsg);
                           component.set("v.Marketing_Plan__c", marketingPlan);
                       }
                   })
               )
               .then(
                      $A.getCallback(function(result) {
                          var responsemsg = JSON.parse(result);
                          var isSuccess = responsemsg.isSuccess;
                          if (isSuccess == true) {
                              var responsedata = responsemsg.results.data[0];
                              var marketingPlanBenefits = responsedata.Marketing_Plan_Benefit__c;
                              //If Selected for Creation, nullify Id
                              component.set("v.Marketing_Plan_Benefit__c", marketingPlanBenefits);
                              component.set("v.plantemplateselected",true);
                          } else {
                              console.log("Set marketingPlan benefits attribute failed with Error " + responsemsg.errMsg);
                              component.set("v.Marketing_Plan__c", marketingPlan);
                          }
                      })
              )
               .catch(
                   $A.getCallback(function(error) {
                       console.log("Set marketingPlan attribute failed with Error " + error.message);
                       component.set("v.Marketing_Plan__c", marketingPlan);
                   })
               );
       }else{
            marketingPlan["Name"] = "";
            component.set("v.Marketing_Plan__c", marketingPlan);
       }
    },

   //Updates Marketing Plan Benefit Values
   updateMarketingPlanBenefits : function(component, attributeId, attributeValueId ){
       var planBenefits = component.get("v.Marketing_Plan_Benefit__c");
       var attributeValueIdMap = component.get("v.attributevalueidmap")
        console.log(JSON.stringify(attributeValueIdMap));
       for(let planBenefit of planBenefits){
        if(planBenefit.Attribute_Id__c === attributeId){
            var attributeValue = attributeValueIdMap[attributeValueId];

            planBenefit.Attribute_Value__c = attributeValueId;
            planBenefit.In_Network_Display_Name__c = attributeValue["In_Network_Display_Value__c"];
            planBenefit.Out_Of_Network_Display_Value__c = attributeValue["Out_Of_Network_Display_Value__c"];
            planBenefit.Attribute_Value_Amount__c = attributeValue["Attribute_Value__c"];
            planBenefit.Limits_And_Exceptions__c = attributeValue["Limits_And_Exceptions_Text_Area__c"];
            break;
        }
       }
       component.set("v.Marketing_Plan_Benefit__c", planBenefits);
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