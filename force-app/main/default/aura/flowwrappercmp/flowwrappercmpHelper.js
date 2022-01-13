/**
 * Created by varun on 2/28/2019.
 */
({
     initTaskflow: function(component, event, helper) {
        helper = this;
        var flowdevname = component.get("v.flowdevname");
        var contextobjectId = component.get("v.contextobjectId")
        var flow = component.find("flowData");
        var inputVariables = [
            { name : "context_record_id", type : "String", value: contextobjectId },
        ];
        flow.startFlow(flowdevname, inputVariables);
    },

    handleTaskStatusChange: function(component, event, helper) {
        helper = this;
        var eventStatus = event.getParam("status");
        if (!$A.util.isUndefined(eventStatus) && !$A.util.isEmpty(eventStatus))
        {
            if(eventStatus == "STARTED"){

            }else if(eventStatus == "PAUSED"){

            }else if(eventStatus == "FINISHED"){
                var flowvariables = event.getParam("outputVariables");
                helper.commitTransaction(component,event,flowvariables);
            }
        }
    },

    //Closes Tab if in Console Mode
    closeFocusedTab : function(component, event, helper) {
        var workspaceAPI = component.find("workspace");
        workspaceAPI.isConsoleNavigation().then(function(response) {
            if(response){
                return workspaceAPI.getFocusedTabInfo();
            }
        })
        .then(function(response) {
            var focusedTabId = response.tabId;
            workspaceAPI.closeTab({tabId: focusedTabId});
        })
        .catch(function(error) {
            console.log(error);
        });
    },

    commitTransaction: function(component, event, flowvariables) {
        var helper = this;
        var context_record_id= '';
        for (var i = 0; i < flowvariables.length; i++) {
            if(flowvariables[i].name === 'context_record_id'){
                context_record_id = flowvariables[i].value;
            }
        }
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
          "title": "Success!",
          "message": "Flow completed successfully.",
          "type": "success"
        });
        toastEvent.fire();
        if(context_record_id != '' && !$A.util.isUndefinedOrNull(context_record_id)){
            var navEvt = $A.get("e.force:navigateToSObject");
            navEvt.setParams({
              "recordId": context_record_id,
              "slideDevName": "related"
            });
            navEvt.fire();
        }

        var flowcompletedEvent = component.getEvent("flowcompleted");
        flowcompletedEvent.fire();

    },

})