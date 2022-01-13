/**
 * Created by varun on 8/26/2019.
 */

({
    //Set Product Component
    setBaseRateSchedule: function(component, event, helper){
        var helper = this;
        var productLine = component.get("v.ProductLine__c");
        var baseRateSchedule = component.get("v.BaseRateSchedule__c");
        var editratefactorid = component.get("v.editratefactorid");
        var copyfrompplanfamilyid = component.get("v.copyfrompplanfamilyid");
        var createratefactor = component.get("v.createratefactor");
        var baseRateScheduleId = "";
        if(createratefactor){
            baseRateScheduleId = component.get("v.copyfromratefactorid");
            productLine["Id"] = copyfrompplanfamilyid;
        }else{
            baseRateScheduleId = editratefactorid;
        }
        if($A.util.isUndefined(baseRateScheduleId) || baseRateScheduleId == ""){
            baseRateSchedule = {
                'Id': '',
                'Effective_Date__c': '',
                'Product_Line__c': productLine["Id"],
                'Name': '',
                'Status__c': 'Workspace',
                'Termination_Date__c': '',
                'Tier_Code__c': '',
                'Version__c': 1
            };
            component.set("v.Rate_Factor__c", baseRateSchedule);
            component.set("v.ProductLine__c", productLine);
        }else{
            var querymap = {};
            querymap['object'] = 'Rate_Factor__c';
            querymap['queryFields'] = 'Id, Effective_Date__c,Product_Line__c,Name,Status__c, Termination_Date__c, Tier_Code__c,Version__c';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = baseRateScheduleId;
            var getBaseRateScheduleAction = component.get("c.getRecords");
            getBaseRateScheduleAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getBaseRateSchedulePromise = helper.executePromisedAction(component, getBaseRateScheduleAction);
            getBaseRateSchedulePromise
            .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            baseRateSchedule = responsedata.Rate_Factor__c[0];
                            //If Selected for Creation, nullify Id
                            if(createratefactor){
                                baseRateSchedule["Id"] = "";
                                baseRateSchedule["Product_Line__c"] = productLine["Id"];
                            }
                            productLine["Id"] = baseRateSchedule["Product_Line__c"];

                            component.set("v.ProductLine__c", productLine);
                            component.set("v.Rate_Factor__c", baseRateSchedule);

                        } else {
                            console.log("SetbaseRateSchedule attribute failed with Error " + responsemsg.errMsg);
                            component.set("v.Rate_Factor__c", baseRateSchedule);
                            component.set("v.ProductLine__c", productLine);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("SetbaseRateSchedule attribute failed with Error " + error.message);
                        component.set("v.Rate_Factor__c", baseRateSchedule);
                        component.set("v.ProductLine__c", productLine);
                    })
                );
        }
    },

    //Set Product Component
    populateBaseRate: function(component, event){
        var helper = this;
        var planFamily = component.get("v.ProductLine__c");
        var baseRateSchedule = component.get("v.Rate_Factor__c");
        var planFamilyId = planFamily["Id"];
        if(!$A.util.isUndefined(planFamilyId) && planFamilyId != ""){
            var querymap = {};
            querymap['object'] = 'ProductLine__c';
            querymap['queryFields'] = 'Id, Name ,Effective_Date__c,Termination_Date__c';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = planFamilyId;
            var getPlanFamilyAction = component.get("c.getRecords");
            getPlanFamilyAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getPlanFamilyPromise = helper.executePromisedAction(component, getPlanFamilyAction);
            getPlanFamilyPromise
            .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            var planFamily = responsedata.ProductLine__c[0];
                            //If Selected for Creation, nullify Id
                            baseRateSchedule["Name"] = planFamily["Name"];
                            baseRateSchedule["Effective_Date__c"] = planFamily["Effective_Date__c"];
                            baseRateSchedule["Termination_Date__c"] = planFamily["Termination_Date__c"];
                            baseRateSchedule["Product_Line__c"] = planFamily["Id"];
                            component.set("v.Rate_Factor__c", baseRateSchedule);
                        } else {
                            console.log("Set Base Rate Schedule failed with Error " + responsemsg.errMsg);
                            component.set("v.Rate_Factor__c", baseRateSchedule);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Setp Base Rate Schedule failed with Error " + error.message);
                        component.set("v.Rate_Factor__c", baseRateSchedule);
                    })
                );
        }else{
             baseRateSchedule["Name"] = "";
             component.set("v.Rate_Factor__c", baseRateSchedule);
        }
    },

    //Helper Method which initializes picklist values for passed in Object and Field
    initPicklistValues: function(component, event, helper) {
        var helper = this;
        var querymap = {};
        var objecttype = 'Rate_Factor__c';
        var picklistFields = ['Tier_Code__c'];
        querymap['objecttype'] = objecttype;
        for(var idx in picklistFields){
            querymap['picklistfield'] = picklistFields[idx];
            var picklistFieldsAction = component.get("c.getPicklistValues");
            picklistFieldsAction.setParams({
                        "jsonString": JSON.stringify(querymap)
            });
            var getPicklistFieldsPromise = helper.executePromisedAction(component, picklistFieldsAction);
            getPicklistFieldsPromise
                .then(
                        $A.getCallback(function(result) {
                            var responsemsg = JSON.parse(result);
                            var isSuccess = responsemsg.isSuccess;
                            if (isSuccess == true) {
                                var responsedata = responsemsg.results.data;
                                var fieldName = responsedata[0]['fieldName'];
                                var picklists = component.get("v.picklists");
                                if($A.util.isUndefinedOrNull(picklists)){
                                    picklists = {};
                                }
                                picklists[fieldName + '_' + 'values'] = responsedata;
                                component.set("v.picklists", picklists);
                                component.set("v.picklistinitalized", true);
                            } else {
                                console.log("Init Picklist Values Promise Chain Failed with Error " + responsemsg.errMsg);
                            }
                        })
                )
                .catch(
                        $A.getCallback(function(error) {
                            console.log("Init Picklist Values Promise Chain Failed with Error " + error.message);
                        })
                );
        }
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