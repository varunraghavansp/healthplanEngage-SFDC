/**
 * Created by varun on 11/3/2019.
 */

({
    //Helper Method for Updating zipcode attribute with current rating info values
    updateRatingInfo: function(component, event, chngSrc) {
        var helper = this;
        var lead = component.get("v.Lead");
        var zipCodeId = '';
        if (chngSrc == 'postalCode') {
            zipCodeId = lead.Address.postalCode;
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
                            if (chngSrc == 'postalCode') {
                                lead['County__c'] = responsedata.Rating_Region__c[0].County__c;
                                lead['city'] = responsedata.Rating_Region__c[0].City__c;
                                lead['state'] = responsedata.Rating_Region__c[0].State__c;
                            }
                            console.log(JSON.stringify(lead));
                            component.set("v.Lead", lead);
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