/**
 * Created by varun on 8/18/2019.
 */

({
   //returns Column Definition for datatable
   getColumnDefinitions: function () {
           var columns = [
               { label: 'Component Type', fieldName: 'Component_Type__c', type: 'text', sortable: true},
               { label: 'Is Base Component Benefit', fieldName: 'Is_Base_Component_Benefit__c', type: 'boolean', sortable: true},
               { label: 'Is Key Benefit', fieldName: 'Is_Key_Benefit__c', type: 'boolean', sortable: true},
               { label: 'Attribute Category', fieldName: 'Attribute_Category__c', type: 'text', sortable: true},
               { label: 'Attribute Code', fieldName: 'Attribute_Code__c', type: 'text', sortable: true},
               { label: 'Attribute Display Name', fieldName: 'Attribute_Display_Name__c', type: 'text', sortable: true},
               { label: 'Attribute Value', type: 'button', initialWidth: 150, typeAttributes:{ label: { fieldName: 'Attribute_Value__c'}, title: 'Click to Edit', name: 'edit_attribute_value', iconName: 'utility:edit', class: 'btn_next'}},
               { label: 'In Network Display Value', fieldName: 'In_Network_Display_Name__c', type: 'text'},
               { label: 'Out of Network Display Value', fieldName: 'Out_Of_Network_Display_Value__c', type: 'text'}
           ];
             return columns;
       },
   //creates a Name Map of the Attributes for Use in Upload Function
   getAttributeNameMap: function(component) {
       var attributes = component.get("v.Attribute__c");
       var attributeNameToIdMap = {}
       for (let attribute of attributes){
           attributeNameToIdMap[attribute['Name']] = attribute;
       }
       return attributeNameToIdMap;
   },
   //creates a Map of the allowed Attribute Values by Attribute Code
   getAllowableAttributeValueByCodeMap: function(component){
       var attributes = component.get("v.Attribute__c");
       var attributeValues = component.get("v.Attribute_Value__c");
       var allowedAttributeValuesByCode =  {};
       if (!$A.util.isUndefined(attributeValues) && !$A.util.isEmpty(attributeValues) && !$A.util.isEmpty(attributes) && !$A.util.isEmpty(attributes)){
           for(let attribute of attributes){
               var attributeCode = attribute["Name"];

               for(let attributeValue of attributeValues){
                   if(attributeValue["Attribute_Code__c"] == attributeCode){
                        var allowedAttributeValues = allowedAttributeValuesByCode[attributeCode];
                        if($A.util.isUndefined(allowedAttributeValues) || $A.util.isEmpty(allowedAttributeValues)){
                           allowedAttributeValues = [];
                        }
                        allowedAttributeValues.push(attributeValue);
                        allowedAttributeValuesByCode[attributeCode] = allowedAttributeValues;
                   }
               }
           }
       }
       return allowedAttributeValuesByCode;
   },
   //creates a default list of plan Benefits from plan template components without values
   getPlanBenefitList : function(component){
        var marketingPlanId = component.get("v.Marketing_Plan__c")["Id"];
       //This List has the package frameworks for the Selected Plan
       var planTemplateComponents = component.get("v.Plan_Template_Component__c");
       //This List has the all component attributes for the PLan Family
       var allPlanComponentAttributes = component.get("v.Component_Attribute__c");
       var planBenefitList = [];
       if(!$A.util.isUndefinedOrNull(planTemplateComponents) && !$A.util.isUndefinedOrNull(allPlanComponentAttributes)){
           for(let planTemplateComponent of planTemplateComponents){

                for(let planComponentAttribute of allPlanComponentAttributes){

                  if(planTemplateComponent["Plan_Component__c"] == planComponentAttribute["Plan_Component__c"]){//Check this value
                    var planBenefit = {
                        Id: "",
                        Name: "",
                        Attribute_Value__c: "",
                        Marketing_Plan__c: marketingPlanId,
                        Plan_Template_Component__c: planTemplateComponent["Id"],
                        Component_Attribute__c: planComponentAttribute["Id"],
                        //Related Component Calculated Fields
                        Component_Type__c: planTemplateComponent["Component_Type__c"],
                        Component_Name__c: planTemplateComponent["Component_Name__c"],
                        Is_Base_Component_Benefit__c: planTemplateComponent["Is_Base_Component__c"],
                        //Related Component Attribute Calculated Fields
                        Attribute_Display_Name__c: planComponentAttribute["Attribute_Display_Name__c"],
                        Attribute_Code__c: planComponentAttribute["Attribute_Code__c"],
                        Attribute_Category__c: planComponentAttribute["Attribute_Category__c"],
                        Attribute_Long_Code__c: planComponentAttribute["Attribute_Long_Code__c"],
                        Is_Key_Benefit__c: planComponentAttribute["Is_Key_Benefit__c"],
                        //Related Attribute Value Calculated Fields
                        Attribute_Value_Amount__c: "",
                        Out_Of_Network_Display_Value__c: "",
                        In_Network_Display_Name__c: ""
                    };
                    planBenefitList.push(planBenefit)
                  }
                }
           }
       }
       return planBenefitList;
   },
   //Assign Values to the Plan Benefits From The Input in Predefined Package Benefits
   assignPlanBenefits: function(component){
        var inputPlanBenefits = component.get("v.Marketing_Plan_Benefit__c");
        var selectedPlanBenefits = component.get("v.predefinedPlanBenefits");

        var allowedAttributeValuesByCode = component.get("v.allowedAttributeValueByCodeMap");
        var allowedAttributeValuesForBenefit = [];
        var attributeCode = "";
        var Attribute_Value__c = "";
        var Attribute_Value_Amount__c = "";
        var Out_Of_Network_Display_Value__c = "";
        var In_Network_Display_Name__c = "";
        var benefitIdx = 0;
        if(!$A.util.isUndefinedOrNull(selectedPlanBenefits)){
            for(let selectedPlanBenefit of selectedPlanBenefits){

                attributeCode = selectedPlanBenefit["Attribute_Code__c"];
                allowedAttributeValuesForBenefit = allowedAttributeValuesByCode[attributeCode];
                if(!$A.util.isUndefinedOrNull(allowedAttributeValuesForBenefit)){
                    Attribute_Value__c = allowedAttributeValuesForBenefit[0].Id;
                    Attribute_Value_Amount__c = allowedAttributeValuesForBenefit[0].Attribute_Value__c;
                    Out_Of_Network_Display_Value__c = allowedAttributeValuesForBenefit[0].Out_Of_Network_Display_Value__c;
                    In_Network_Display_Name__c = allowedAttributeValuesForBenefit[0].In_Network_Display_Value__c;
                    if(!$A.util.isUndefinedOrNull(inputPlanBenefits)){
                        //TODO Check Component Type as well
                        for(let inputBenefit of inputPlanBenefits){
                            if(inputBenefit["Attribute_Code__c"] == attributeCode){
                                for(let attributeValue of allowedAttributeValuesForBenefit){
                                    if(inputBenefit["Attribute_Value_Amount__c"] == attributeValue["Attribute_Value__c"]){
                                        Attribute_Value__c = attributeValue.Id;
                                        Attribute_Value_Amount__c = attributeValue.Attribute_Value__c;
                                        Out_Of_Network_Display_Value__c = attributeValue.Out_Of_Network_Display_Value__c;
                                        In_Network_Display_Name__c = attributeValue.In_Network_Display_Value__c;
                                        break;
                                    }
                                }
                                break;
                            }
                        }
                    }
                    selectedPlanBenefit.Attribute_Value__c = Attribute_Value__c;
                    selectedPlanBenefit.Attribute_Value_Amount__c = Attribute_Value_Amount__c;
                    selectedPlanBenefit.Out_Of_Network_Display_Value__c = Out_Of_Network_Display_Value__c;
                    selectedPlanBenefit.In_Network_Display_Name__c = In_Network_Display_Name__c;
                    benefitIdx++;
                }
                else{
                   selectedPlanBenefits.splice(benefitIdx, 1);
                }
            }
        }
        component.set("v.Marketing_Plan_Benefit__c",selectedPlanBenefits);
   },
   //returns row definition for datatable
   getRows: function(component){
       var predefinedPackageBenefits = component.get("v.Marketing_Plan_Benefit__c");
       var row = {};
       var rows = [];
       if (!$A.util.isUndefined(predefinedPackageBenefits) && !$A.util.isEmpty(predefinedPackageBenefits)){
           for(let predefinedPackageBenefit of predefinedPackageBenefits){
               row = {
                   "id": predefinedPackageBenefit.Component_Type__c + predefinedPackageBenefit.Attribute_Code__c,
                   "Component_Type__c": predefinedPackageBenefit.Component_Type__c,
                   "Is_Base_Component_Benefit__c": predefinedPackageBenefit.Is_Base_Component_Benefit__c,
                   "Is_Key_Benefit__c": predefinedPackageBenefit.Is_Key_Benefit__c,
                   "Attribute_Category__c": predefinedPackageBenefit.Attribute_Category__c,
                   "Attribute_Code__c": predefinedPackageBenefit.Attribute_Code__c,
                   "Attribute_Display_Name__c": predefinedPackageBenefit.Attribute_Display_Name__c,
                   "Attribute_Value__c": predefinedPackageBenefit.Attribute_Value_Amount__c,
                   "In_Network_Display_Name__c": predefinedPackageBenefit.In_Network_Display_Name__c,
                   "Out_Of_Network_Display_Value__c": predefinedPackageBenefit.Out_Of_Network_Display_Value__c
               };

               //if(predefinedPackageBenefit.Is_Key_Benefit__c === 'Y' || predefinedPackageBenefit.Is_Key_Benefit__c === true){
                    rows.push(row);
               //}
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

    editBenefitAttributeValue: function(component, row){
          var data = component.get('v.data');
          var allowedAttributeValuesByCode = component.get("v.allowedAttributeValueByCodeMap");
          var predefinedPackageBenefits = component.get("v.Marketing_Plan_Benefit__c");

          data = data.map(function(rowData) {
              if (rowData.id === row.id) {
                  for(let predefinedPackageBenefit of predefinedPackageBenefits){
                      if(predefinedPackageBenefit.Component_Type__c + predefinedPackageBenefit.Attribute_Code__c === rowData.id){
                        var attributeCode = predefinedPackageBenefit.Attribute_Code__c;
                        var allowedAttributeValuesForBenefit = allowedAttributeValuesByCode[attributeCode];
                        var currentAttributeValue = row.Attribute_Value__c;
                        var selectedIdx = 0;
                        var allowedAttributeSize = allowedAttributeValuesForBenefit.length;
                        for(let attributeValue of allowedAttributeValuesForBenefit){
                            if(attributeValue.Attribute_Value__c === currentAttributeValue){
                                break;
                            }
                            selectedIdx++;
                        }
                        if(selectedIdx + 1 <  allowedAttributeSize){
                            selectedIdx++;
                        }else{
                            selectedIdx = 0;
                        }
                        predefinedPackageBenefit.Attribute_Value__c = allowedAttributeValuesForBenefit[selectedIdx].Id;
                        predefinedPackageBenefit.Attribute_Value_Amount__c = allowedAttributeValuesForBenefit[selectedIdx].Attribute_Value__c;
                        predefinedPackageBenefit.Out_Of_Network_Display_Value__c = allowedAttributeValuesForBenefit[selectedIdx].Out_Of_Network_Display_Value__c;
                        predefinedPackageBenefit.In_Network_Display_Name__c = allowedAttributeValuesForBenefit[selectedIdx].In_Network_Display_Value__c;

                        rowData.Attribute_Value__c = allowedAttributeValuesForBenefit[selectedIdx].Attribute_Value__c;
                        rowData.In_Network_Display_Name__c = allowedAttributeValuesForBenefit[selectedIdx].In_Network_Display_Value__c;
                        rowData.Out_Of_Network_Display_Value__c = allowedAttributeValuesForBenefit[selectedIdx].Out_Of_Network_Display_Value__c;
                        break;
                      }
                  }
              }
              return rowData;
          });

          component.set("v.data", data);
      },

   readCSVFile: function(component, event, helper) {
       var helper = this;
       var inputBenefits = [];
       var file = event.getSource().get("v.files")[0]; // component.find("upload").getElement().files[0];
       if (file) {
           var reader = new FileReader();
           reader.readAsText(file, "UTF-8");
           reader.onload = function(evt) {
               var textdata = evt.target.result;
               var benefitValueArray = helper.CSVToArray(textdata, ",");
               for (var idx in benefitValueArray) {
                   var benefitValue = {};
                   var benefitValueRow = benefitValueArray[idx];
                   //Skip If Empty Row and Header Row
                   if(benefitValueRow[0] != "" && idx > 0){
                       benefitValue['Component_Type__c'] = benefitValueRow[0];
                       benefitValue['Attribute_Code__c'] = benefitValueRow[1];
                       benefitValue['Attribute_Value_Amount__c'] = benefitValueRow[2];
                       inputBenefits.push(benefitValue);
                   }
               }
               component.set("v.Marketing_Plan_Benefit__c", inputBenefits);
               var csvCompletedEvent = component.getEvent("csvloadcompleted");
               csvCompletedEvent.fire();
           }
           reader.onerror = function(evt) {
               console.log("error reading file");
           }
       }
   },

   CSVToArray : function ( strData, strDelimiter ){
       // Check to see if the delimiter is defined. If not, then default to comma.
       strDelimiter = (strDelimiter || ",");
       // Create a regular expression to parse the CSV values.
       var objPattern = new RegExp(
          (
              // Delimiters.
              "(\\" + strDelimiter + "|\\r?\\n|\\r|^)" +
              // Quoted fields.
              "(?:\"([^\"]*(?:\"\"[^\"]*)*)\"|" +
              // Standard fields.
              "([^\"\\" + strDelimiter + "\\r\\n]*))"
          ),"gi");
       // Create an array to hold our data. Give the array
       // a default empty first row.
       var arrData = [[]];
       // Create an array to hold our individual pattern
       // matching groups.
       var arrMatches = null;
       // Keep looping over the regular expression matches
       // until we can no longer find a match.
       while (arrMatches = objPattern.exec( strData )){
          // Get the delimiter that was found.
          var strMatchedDelimiter = arrMatches[ 1 ];
          // Check to see if the given delimiter has a length
          // (is not the start of string) and if it matches
          // field delimiter. If id does not, then we know
          // that this delimiter is a row delimiter.
          if (strMatchedDelimiter.length && strMatchedDelimiter !== strDelimiter){
              // Since we have reached a new row of data,
              // add an empty row to our data array.
              arrData.push( [] );
          }
          var strMatchedValue;
          // Now that we have our delimiter out of the way,
          // let's check to see which kind of value we
          // captured (quoted or unquoted).
          if (arrMatches[ 2 ]){
              // We found a quoted value. When we capture
              // this value, unescape any double quotes.
              strMatchedValue = arrMatches[ 2 ].replace(new RegExp( "\"\"", "g" ),"\"");
          } else {
              // We found a non-quoted value.
              strMatchedValue = arrMatches[ 3 ];
          }
          // Now that we have our value string, let's add
          // it to the data array.
          arrData[ arrData.length - 1 ].push( strMatchedValue );
       }
       // Return the parsed data.
       return arrData;
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