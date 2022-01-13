/**
 * Created by varun on 7/30/2019.
 */

({
    initChart: function(component, event, helper) {
        helper = this;
        var quoteCensus = component.get("v.quotecensus");
        var quoteCensusMap = helper.getEmployeeMap(quoteCensus);
        //console.log(quoteCensusMap);
        var ageGroups  = {"0-29": 0 , "30-39": 0, "40-44": 0, "45-49": 0, "50-54": 0, "55-59": 0, "60-64": 0, "65-70": 0, "70-99": 0};
        quoteCensus.forEach(function(quoteCensusRecord){
           var age =  helper.getAge(quoteCensusRecord["Date_Of_Birth__c"]);
           if(age < 30){
               ageGroups["0-29"] = ageGroups["0-29"] + 1;
           }else if(age < 40){
               ageGroups["30-39"] = ageGroups["30-39"] + 1;
           }else if(age < 45){
               ageGroups["40-44"] = ageGroups["40-44"] + 1;
           }else if(age < 50){
               ageGroups["45-49"] = ageGroups["45-49"] + 1;
           }else if(age < 55){
               ageGroups["50-54"] = ageGroups["50-54"] + 1;
           }else if(age < 60){
               ageGroups["55-59"] = ageGroups["55-59"] + 1;
           }else if(age < 65){
               ageGroups["60-64"] = ageGroups["60-64"] + 1;
           }else if(age < 71){
               ageGroups["65-70"] = ageGroups["65-70"] + 1;
           }else if(age < 100){
               ageGroups["70-99"] = ageGroups["70-99"] + 1;
           }
        });
        var donutData = [];
        for(var ageGroup in ageGroups){
            donutData.push({"segment": ageGroup, "value": ageGroups[ageGroup] });
        }
        //console.log(donutData);
        component.set("v.donutdata",donutData);

        var familyGroups  = {"Subscriber Only": 0 , "Subscriber Spouse": 0, "Subscriber Child": 0, "Family": 0};
        for(let employeeNumber in quoteCensusMap){
            if(quoteCensusMap[employeeNumber]["familyType"] === "Subscriber Only"){
                familyGroups["Subscriber Only"] = familyGroups["Subscriber Only"] + 1;
            }else if(quoteCensusMap[employeeNumber]["familyType"] === "Subscriber Spouse"){
                familyGroups["Subscriber Spouse"] = familyGroups["Subscriber Spouse"] + 1;
            }else if(quoteCensusMap[employeeNumber]["familyType"] === "Subscriber Child"){
                familyGroups["Subscriber Child"] = familyGroups["Subscriber Child"] + 1;
            }else if(quoteCensusMap[employeeNumber]["familyType"] === "Family"){
                familyGroups["Family"] = familyGroups["Family"] + 1;
            }
        }
        var barData = []
        for(var familyGroup in familyGroups){
            barData.push({"y": familyGroups[familyGroup], "x": familyGroup });
        }
        component.set("v.bardata", barData);
        component.set("v.datainitialized",true);
        //console.log(barData);
    },

    getEmployeeMap : function(quoteCensus, employeeMap) {
        var employeeMap = {};
        var helper = this;
        quoteCensus.forEach(function(quoteCensusRecord){
            var employeeNumber = quoteCensusRecord["Employee_Number__c"];
            var currEmployeeMap = employeeMap[employeeNumber];
            var employeeList;
            var subAge;
            if($A.util.isUndefinedOrNull(currEmployeeMap)){
                currEmployeeMap = {};
                employeeList = [];
                subAge = 0;
            }
            else{
                employeeList = currEmployeeMap["family"];
                subAge = currEmployeeMap["subAge"];
            }
            employeeList.push(quoteCensusRecord);

            if(quoteCensusRecord["Relation__c"] === "Self"){
                var subAge = helper.getAge(quoteCensusRecord["Date_Of_Birth__c"]);
            }
            var familyType;
            var spouseCount = 0;
            var childCount = 0;
            var subCount = 0
            employeeList.forEach(function(employeeRecord){
                if(employeeRecord["Relation__c"] === "Self"){
                    subCount += 1;
                }else if(employeeRecord["Relation__c"] === "Spouse"){
                    spouseCount += 1;
                }else if(employeeRecord["Relation__c"] === "Dependent"){
                    childCount += 1;
                }
            });
            if(subCount === 1 && spouseCount === 0 && childCount === 0){
                familyType = "Subscriber Only";
            }else if(subCount === 1 && spouseCount > 0 && childCount ===0){
                familyType = "Subscriber Spouse";
            }else if(subCount === 1 && spouseCount === 0 && childCount > 0){
                familyType = "Subscriber Child";
            }else if(subCount === 1 && spouseCount > 0 && childCount > 0){
                familyType = "Family";
            }

            employeeMap[employeeNumber] = {"family" : employeeList, "subAge" : subAge, "familyType" : familyType};
        });

        return employeeMap;
    },

    getAge : function (dateString) {
        var today = new Date();
        var birthDate = new Date(dateString);
        var age = today.getFullYear() - birthDate.getFullYear();
        var m = today.getMonth() - birthDate.getMonth();
        if (m < 0 || (m === 0 && today.getDate() < birthDate.getDate())) {
            age--;
        }
        return age;
    }

});