/**
 * Created by varun on 11/4/2019.
 */

({
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
});