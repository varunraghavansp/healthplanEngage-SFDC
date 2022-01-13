({
    initFlowList: function(component, event, helper) {
        helper = this;
        var attlistjson = {};
        var querymap = {};
        var sObjectName = component.get("v.sObjectName") == undefined ? 'Account' : component.get("v.sObjectName");
        var sObjectId = component.get("v.recordId") == undefined? '0014P000028EyiCQAS' : component.get('v.recordId');
        // Initialize Component Through Chained Promise Execution
        // 1. Fetch Record Type,  2. Init Taskflow List, 3. Create Task list components
        component.set("v.showspinner", true);
        querymap['object'] = sObjectName;
        if(sObjectName === 'QuoteLineItem'){
           querymap['queryFields'] = 'Id';
        }else{
            querymap['queryFields'] = 'Id, RecordType.Name';
        }
        querymap['searchField'] = 'Id';
        querymap['searchTerm'] = sObjectId;
        var getRecordNameAction = component.get("c.getRecords");
        getRecordNameAction.setParams({
            "jsonString": JSON.stringify(querymap)
        });
        var getRecordNamePromise = helper.executePromisedAction(component, getRecordNameAction);
        getRecordNamePromise
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if (isSuccess == true) {
                        var responsedata = responsemsg.results.data[0];
                        attlistjson['objectType'] = sObjectName;
                        var objectLst = responsedata[sObjectName];
                        attlistjson['recordType'] = objectLst[0].RecordType == null || objectLst[0].RecordType == undefined ?  '' : objectLst[0].RecordType.Name;
                        attlistjson['Entity__c'] = attlistjson.recordType == '' || attlistjson.recordType == undefined ? sObjectName : attlistjson.recordType;
                        component.set("v.attlistjson", attlistjson);
                        querymap = {};
                        querymap['object'] = 'Flow_Entity_Mapper__mdt';
                        querymap['queryFields'] = 'DeveloperName , Display_Name__c, Display_Sequence__c, Entity__c, Flow_API_Name__c, Wrapper_Component__c';
                        querymap['searchField'] = 'Entity__c';
                        querymap['searchTerm'] = attlistjson.Entity__c;
                        querymap['order'] = 'Display_Sequence__c';
                        var getTaskflowAction = component.get("c.getRecords");
                        getTaskflowAction.setParams({
                            "jsonString": JSON.stringify(querymap)
                        });
                        var getTaskflowPromise = helper.executePromisedAction(component, getTaskflowAction);
                        return getTaskflowPromise;
                    } else {
                        console.log("Task List Initalization Promise Chain Failed With Error: " + responsemsg.errMsg);
                        component.set("v.showspinner", false);
                    }
                })
            )
            .then(
                $A.getCallback(function(result) {
                    var responsemsg = JSON.parse(result);
                    var isSuccess = responsemsg.isSuccess;
                    if (isSuccess == true) {
                        attlistjson = component.get("v.attlistjson");
                        var responsedata = responsemsg.results.data[0];
                        attlistjson.taskflow = responsedata.Flow_Entity_Mapper__mdt;
                        var tasknamemap = {}
                        for(var idx in attlistjson.taskflow){
                        	var taskflow = attlistjson.taskflow[idx];
                        	var taskcomponentname = taskflow['Wrapper_Component__c'];
                        	var taskdevelopername = taskflow['Flow_API_Name__c'];
                        	tasknamemap[taskdevelopername] = taskcomponentname;
                        }
                        attlistjson["tasknamemap"] = tasknamemap;
                        component.set("v.attlistjson", attlistjson);
                        var createComponentPromise = helper.createChapterCmp(component, helper);
                        return createComponentPromise;
                    } else {
                        console.log("Task List Initalization Promise Chain Failed With Error: " + responsemsg.errMsg);
                        component.set("v.showspinner", false);
                    }
                })
            )
            .then(
                $A.getCallback(function(result) {
                    component.set("v.showspinner", false);
                })
            )
            .catch(
                $A.getCallback(function(error) {
                    console.log("Task List Initalization Promise Chain Failed With Error: " + error.message);
                    component.set("v.showspinner", false);
                })
            );
    },

    //Creates Promise For Creation of the Active Chapter Link and Returns Callback
    createChapterCmp: function(component, helper, callback) {
        return new Promise(function(resolve, reject) {
            try {
                var taskchapters = component.get("v.attlistjson").taskflow;
                /* Sets the aura:id for the newly created component */
                var container = component.find("flowlstcontainer");
                if (container.isValid()) {
                    for (var idx in taskchapters) {
                        $A.createComponent("c:strike_tile", {
                                "aura:id": taskchapters[idx].Flow_API_Name__c,
                                "title": taskchapters[idx].Display_Name__c,
                                "variant": "icon",
                                "iconName": "standard:task"
                            },
                            function(newCmp, status, errorMessage) {
                                if (status === "SUCCESS") {
                                    var body = container.get("v.body");
                                    body.push(newCmp);
                                    container.set("v.body", body);
                                    $A.util.addClass(container, "slds-show");
                                } else if (status === "ERROR") {
                                    reject(Error("Error " + errorMessage));
                                }
                            });
                    }
                    resolve("SUCCESS");
                }
            } catch (e) {
                reject(Error("Error " + e));
            }
        });
    },

    //Executes Server side actions through a promise wrapper
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

    //Launches flow component on click of taskflow link
    startFlow: function(component, event, helper) {
        var contextRecordId = component.get("v.recordId");
        var srcCmp = event.getSource().getLocalId();
        if (!$A.util.isUndefined(srcCmp) && !$A.util.isEmpty(srcCmp)) {
        	var tasknamemap = component.get("v.attlistjson.tasknamemap");
        	var taskcmpname = tasknamemap[srcCmp];
        	var taskdevname = srcCmp;
             if (!$A.util.isUndefined(taskdevname) && !$A.util.isEmpty(taskdevname)){
            	 	var navEvt = $A.get("e.force:navigateToComponent");
		            navEvt.setParams({
		                componentDef: 'c:' + taskcmpname,
		                componentAttributes: {
		                    flowdevname: taskdevname,
		                    contextobjectId: contextRecordId
		                }
		            });
		            navEvt.fire();
             }
             else{
            	 console.log("Component Name for task " + srcCmp + " is not defined");
             }

        } else {
            console.log("Component Name not defined");
        }
    },

})