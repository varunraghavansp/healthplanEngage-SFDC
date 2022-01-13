/**
 * Created by varun on 11/3/2019.
 */

({
    bindDropdownItems: function (component,  helper) {
            var bindingItems_picklistField = [
                'Group_Category__c',
                'Type',
                'Industry'
            ];
            var bindingItems_optionattribute = [
                'options_Group_Category__c',
                'options_Type',
                'options_Industry'
            ];

            bindingItems_picklistField.forEach(function (picklistfield, index) {
                helper.initPicklistVals(component, event, helper, 'Account', picklistfield, bindingItems_optionattribute[index]);
            });

    },
    // To auto populate the Legal Entity Name if not previously populated
    populatelegalname: function(component, event) {
        component.set("v.account.Legal_Entity_Name__c", component.get("v.account.Name"));
    },
    //Helper Method for Updating account info with selected account details
    updateaccountinfo: function(component, event) {
        var helper = this;
        var accnt = component.get("v.account");
        var accountId = component.get("v.accountId");
        var querymap = {};
        if (!$A.util.isUndefined(accountId) && !$A.util.isEmpty(accountId)) {
            querymap['object'] = 'Account';
            querymap['queryFields'] = 'AccountNumber,AccountSource,Active__c,AnnualRevenue,Effective_Date__c,Group_Category__c,Name,Legal_Entity_Name__c,NumberOfEmployees,NumberofLocations__c,Phone,Rating_Zipcode__c,Rating_City__c,Rating_County__c,Rating_Region__c,Rating_State__c,Sic,Status__c,TIN_EIN__c,Type,Industry,BillingCity,BillingAddress,BillingCountry,BillingPostalCode,BillingState,BillingStreet';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = accountId;
            var getAccountAction = component.get("c.getRecords");
            getAccountAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getAccountPromise = helper.executePromisedAction(component, getAccountAction);
            getAccountPromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            accnt = responsedata.Account[0];
                            component.set("v.account", accnt);
                        } else {
                            console.log("Update account attribute failed Error " + responsemsg.errMsg);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Update account attribute failed Error " + error.message);
                    })
                );
        }
    },
    //Helper Method for Updating zipcode attribute with current rating info values
    updateRatingInfo: function(component, event, chngSrc) {
        var helper = this;
        var accnt = component.get("v.account");
        var zipCodeId = '';
        if (chngSrc == 'Rating_Zipcode__c') {
            zipCodeId = accnt.Rating_Zipcode__c;
        }
        var querymap = {};
        if (!$A.util.isUndefined(zipCodeId) && !$A.util.isEmpty(zipCodeId)) {
            querymap['object'] = 'Rating_Region__c';
            querymap['queryFields'] = 'Name,County__c,City__c, State__c, Country__c';
            querymap['searchField'] = 'Id';
            querymap['searchTerm'] = zipCodeId;
            var getZipcodeAction = component.get("c.getRecords");
            getZipcodeAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getZipcodePromise = helper.executePromisedAction(component, getZipcodeAction);
            getZipcodePromise
                .then(
                    $A.getCallback(function(result) {
                        var responsemsg = JSON.parse(result);
                        var isSuccess = responsemsg.isSuccess;
                        if (isSuccess == true) {
                            var responsedata = responsemsg.results.data[0];
                            if (chngSrc == 'Rating_Zipcode__c') {
                                accnt['Rating_County__c'] = responsedata.Rating_Region__c[0].County__c;
                                accnt['Rating_City__c'] = responsedata.Rating_Region__c[0].City__c;
                                accnt['Site'] = responsedata.Rating_Region__c[0].State__c;
                                accnt['BillingState'] = responsedata.Rating_Region__c[0].State__c;
                                accnt['BillingPostalCode'] = responsedata.Rating_Region__c[0].Name;
                                accnt['BillingCountry'] = responsedata.Rating_Region__c[0].Country__c;
                                accnt['BillingCity'] = responsedata.Rating_Region__c[0].City__c;
                            }
                            console.log(JSON.stringify(responsedata));
                            component.set("v.account", accnt);
                        } else {
                            console.log("Update zipcode attribute for Rating info failed Error " + responsemsg.errMsg);
                        }
                    })
                )
                .catch(
                    $A.getCallback(function(error) {
                        console.log("Update zipcode attribute for Rating info fields failed Error " + error.message);
                    })
                );
        }
    },
    initPicklistVals : function (component, event, helper, objectType, picklistField, bindingPpt) {
        var helper = this;
        var querymap = {};
        //console.group("Property bind started");
        //console.log("Object :", objectType);
        //console.log("Property :", picklistField);
        component.set('v.loaded', false);
        querymap['object'] = objectType;
        querymap['picklistfield'] = picklistField;
        var getPicklistValuesAction = component.get("c.getPicklistValues");
        getPicklistValuesAction.setParams({
            "jsonString": JSON.stringify(querymap)
        });
        var getPicklistValuesPromise = helper.executePromisedAction(component, getPicklistValuesAction);
        getPicklistValuesPromise
            .then(
                $A.getCallback(function (result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;

                    if (isSuccess == true) {
                        var responsedata = responsemsg.results.data;
                        //console.log(responsedata);
                        component.set("v." + bindingPpt, responsedata);
                    } else {
                        console.log("Init Picklist Values Promise Chain Failed with Error " + responsemsg.errMsg);
                    }
                    component.set('v.loaded', true);
                     //console.groupEnd();
                })
            )
            .catch(
                $A.getCallback(function (error) {
                    //console.log("Error :", error);
                    //console.groupEnd();
                    component.set('v.loaded', true);
                    console.log("Init Picklist Values Promise Chain Failed with Error " + error.message);
                })
            );
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