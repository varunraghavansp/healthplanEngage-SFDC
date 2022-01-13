/**
 * Created by varun on 11/5/2019.
 */

({
    fetchAccountTeamData: function(component){
        var helper = this;
        var account = component.get("v.account");
        var accountId = account["Id"];
        var querymap = {};
        if(!$A.util.isUndefinedOrNull(accountId)){

            component.set("v.showSpinner",true);
            querymap["object"] = "AccountTeamMember";
            querymap["queryFields"] = "Id,AccountId, TeamMemberRole,UserId ";
            querymap["searchField"] = "AccountId";
            querymap['searchTerm'] = accountId;
            var getAccountTeamAction = component.get("c.getUncachedRecords");
            getAccountTeamAction.setParams({
                "jsonString": JSON.stringify(querymap)
            });
            var getAccountTeamPromise = helper.executePromisedAction(component, getAccountTeamAction);
            getAccountTeamPromise
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if(isSuccess == true){
                        var responsedata = responsemsg.results.data[0].AccountTeamMember;
                        component.set("v.accountteammembers", responsedata);
                        helper.assignTeamMembers(component, responsedata);

                    }else{
                        console.log("Update Account Team failed with Error " + responsemsg.errMsg);
                    }
                })
            )
            .catch(
                $A.getCallback(function(error) {
                    console.log("Update Account Team failed with Error " + error.message);
                })
            )
            .finally($A.getCallback(function(){
                component.set("v.showSpinner",false);
            })
            );
        }
    },

    assignTeamMembers: function(component,accountTeamMembers){
        var accountTeamByRole = {};
        accountTeamMembers.forEach(function(accountTeamMember){
            switch(accountTeamMember.TeamMemberRole){
                case "Account Manager":
                    accountTeamByRole["accountManagerId"] = accountTeamMember.UserId;
                    break;
                case "Sales Manager":
                    accountTeamByRole["salesManagerId"] = accountTeamMember.UserId;
                    break;
                case "Underwriter":
                    accountTeamByRole["underwriterId"] = accountTeamMember.UserId;
                    break;
                default:
                break;
            }
        })
        console.log(accountTeamByRole);
        component.set("v.accountTeamByRole",accountTeamByRole);
    },

    updateTeamMembers: function(component,userId, role){
        var accountTeamMembers = component.get("v.accountteammembers");

        accountTeamMembers.forEach(function(accountTeamMember){
            if(accountTeamMember.TeamMemberRole === role){
                accountTeamMember.UserId = userId;
            }
        })
        component.set("v.accountteammembers",accountTeamMembers);
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