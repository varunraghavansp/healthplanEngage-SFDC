/**
 * Created by varun on 8/18/2019.
 */

({
   //returns Column Definition for datatable
       getColumnDefinitions: function () {
           var actions = [
                       { label: 'Edit', name: 'edit' },
                       { label: 'Delete', name: 'delete' }
           ];
           var columns = [
               { label: 'Attribute', fieldName: 'Attribute_Code__c', sortable: true, type: 'text'},
               { label: 'Attribute Category', fieldName: 'Attribute_Category__c', type: 'text', sortable: true},
               { label: 'Attribute Name', fieldName: 'Attribute_Name__c', type: 'text', sortable: true},
               { label: 'Is Key Benefit', fieldName: 'Is_Key_Benefit__c', type: 'boolean', sortable: true},
               { label: 'Is Rate Impacting', fieldName: 'Is_Rate_Impacting__c', type: 'boolean', sortable: true},
               { type: 'action', typeAttributes: { rowActions: actions } }
           ];
           return columns;
       },
       //creates a Name Map of the Attributes for Use in Upload Function
       getAttributeNameMap: function(component) {
           var attributes = component.get("v.Attribute__c");
           console.log(JSON.stringify(attributes));
           var attributeNameToIdMap = {}
           for (let attribute of attributes){
               attributeNameToIdMap[attribute['Name']] = attribute;
           }
           return attributeNameToIdMap;
       },
       //creates a Map of the Attributes Ids
       getAttributeIdMap: function(component) {
           var attributes = component.get("v.Attribute__c");
           var attributeIdMap = {}
           for (let attribute of attributes){
               attributeIdMap[attribute['Id']] = attribute;
           }
           return attributeIdMap;
       },
       //creates a Map of the Attribute Value Names
       getAllowableAttributeNameMap: function(component){
           var attributeValues = component.get("v.Attribute_Value__c");
           var attributeValueNameMap =  {};
           var attributeValueRecord = {};
           if (!$A.util.isUndefined(attributeValues) && !$A.util.isEmpty(attributeValues)){
               for(let attributeValue of attributeValues){
                   attributeValueNameMap[attributeValue.Attribute_Code__c] = attributeValue;
               }
           }
           return attributeValueNameMap;
       },
       //creates a Map of the Product Component Attribute Names
        getComponentAttributeNameMap: function(component){
            var allComponent_Attribute = component.get("v.Component_Attribute__c");
            var componentAttributeNameMap =  {};
            if (!$A.util.isUndefined(allComponent_Attribute) && !$A.util.isEmpty(allComponent_Attribute)){
               for(let componentAttribute of allComponent_Attribute){
                   componentAttributeNameMap[componentAttribute.Attribute_Code__c] = componentAttribute;
               }
            }
            return componentAttributeNameMap;
        },
       //filter Product Component Attributes into allowed values
       filterComponent_AttributeToAllowedValues: function(component){
           var allComponent_Attribute = component.get("v.Component_Attribute__c");
           var allowedAttributeValueNameMap = component.get("v.allowedAttributeValueNameMap");
           if(!$A.util.isUndefinedOrNull(allComponent_Attribute) && !$A.util.isEmpty(allComponent_Attribute)){

               var attrLen = allComponent_Attribute.length;
               var idx = 0;
               while(idx < attrLen){
                   if($A.util.isUndefined( allowedAttributeValueNameMap[allComponent_Attribute[idx].Attribute_Code__c])){
                        allComponent_Attribute.splice(idx,1);
                        idx = idx - 1;
                        attrLen = attrLen - 1;
                    }
                    idx++;
               }
               component.set("v.Component_Attribute__c", allComponent_Attribute);
           }

       },
       //returns row definition for datatable
       getRows: function(component){
           var componentAttributes = component.get("v.Component_Attribute__c");
           var row = {};
           var rows = [];
           if (!$A.util.isUndefined(componentAttributes) && !$A.util.isEmpty(componentAttributes)){
               for(let componentAttribute of componentAttributes){
                   row = {
                       "id": componentAttribute.Attribute_Code__c,
                       "Attribute_Code__c": componentAttribute.Attribute_Code__c,
                       "Attribute_Category__c": componentAttribute.Attribute_Category__c,
                       "Attribute_Name__c": componentAttribute.Attribute_Name__c,
                       "Attribute__c": componentAttribute.Attribute__c,
                       "Is_Key_Benefit__c": componentAttribute.Is_Key_Benefit__c,
                       "Is_Rate_Impacting__c": componentAttribute.Is_Rate_Impacting__c

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
       newPlanComponentAttribute: function (planComponent) {
           var planComponentAttribute = {
                 'Id':'',
                 'Attribute__c':'',
                 'Attribute_Category__c':'',
                 'Attribute_Code__c':'',
                 'Attribute_Display_Name__c':'',
                 'Attribute_Long_Code__c':'',
                 'Attribute_Name__c': '',
                 'Is_Key_Benefit__c': false,
                 "Is_Rate_Impacting__c": false,
                 'Plan_Component__c': planComponent["Id"]
           };
           return planComponentAttribute;
       },

       //returns existing instance of attributevalue
       editPlanComponentAttribute: function (component, row) {
           var rowId = row["id"];
           var componentAttributeNameMap =  component.get("v.componentAttributeNameMap");
           var componentAttribute = componentAttributeNameMap[rowId];
           return componentAttribute;
       },

       //returns existing instance of attributevalue
       deletePlanComponentAttribute: function (component, row) {
           var rowId = row["id"];
           var componentAttributes = component.get("v.Component_Attribute__c");
           var spliceIdx = -1;
           for(var idx in componentAttributes){
               if(componentAttributes[idx]["Attribute_Code__c"] == rowId){
                   spliceIdx = idx
                   break;
               }
           }
           if(spliceIdx >= 0){
               componentAttributes.splice(spliceIdx, 1);
           }
           component.set("v.Component_Attribute__c",componentAttributes);
       },

       //save attribute value
       saveComponentAttributeValue: function (component) {
           var errorMessage = "";
           var savedcomponentAttributeRecord = component.get("v.selectedcomponentattribute");
           var planComponentAttributes = component.get("v.Component_Attribute__c");
           var spliceIdx = -1;
           for(var idx in planComponentAttributes){
               if(planComponentAttributes[idx]["Attribute_Code__c"] == savedcomponentAttributeRecord["Attribute_Code__c"]){
                   spliceIdx = idx;
                   break;
               }
           }
           if(spliceIdx >= 0){
               planComponentAttributes.splice(spliceIdx, 1);
           }
           planComponentAttributes.push(savedcomponentAttributeRecord);
           component.set("v.Component_Attribute__c",planComponentAttributes);
       },

       readCSVFile: function(component, event, helper) {
           var helper = this;
           var planComponent = component.get("v.Plan_Component__c");
           var attributeNameToIdMap =  component.get("v.attributeNameToIdMap");
           var componentAttributes = [];
           var file = event.getSource().get("v.files")[0]; // component.find("upload").getElement().files[0];
           if (file) {
               var reader = new FileReader();
               reader.readAsText(file, "UTF-8");
               reader.onload = function(evt) {
                   var textdata = evt.target.result;
                   var componentAttributeArray = helper.CSVToArray(textdata, ",");
                   for (var idx in componentAttributeArray) {
                       var componentAttribute = {};
                       var componentAttributeRow = componentAttributeArray[idx];
                       //Skip If Empty Row and Header Row
                       if(componentAttributeRow[0] != "" && idx > 0){
                           var attributeMasterRecord =  attributeNameToIdMap[componentAttributeRow[0]];
                           //Skip if Attribute Definition Is not Present in Attribute Master List
                           if(!$A.util.isUndefinedOrNull(attributeMasterRecord)){
                               componentAttribute = helper.newPlanComponentAttribute(planComponent);
                               componentAttribute['Attribute__c'] = attributeMasterRecord["Id"];
                               componentAttribute['Attribute_Category__c'] = attributeMasterRecord["Attribute_Category__c"];
                               componentAttribute['Attribute_Code__c'] = componentAttributeRow[0];
                                componentAttribute['Attribute_Name__c'] =  componentAttributeRow[2];
                               componentAttribute['Attribute_Display_Name__c'] = attributeMasterRecord["Attribute_Display_Name__c"];
                               componentAttribute['Attribute_Long_Code__c'] = attributeMasterRecord["Attribute_Long_Code__c"];
                               componentAttribute['Is_Key_Benefit__c'] = componentAttributeRow[3] == "Y"? true: false;
                                componentAttribute['Is_Rate_Impacting__c'] = componentAttributeRow[4] == "Y"? true: false;
                               componentAttribute['Name'] = attributeMasterRecord["Id"] + "" + componentAttribute['Plan_Component__c'];
                               componentAttributes.push(componentAttribute);
                           }
                       }
                   }
                   component.set("v.Component_Attribute__c", componentAttributes);
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