/**
 * Created by varun on 2/28/2019.
 */
({
     doInit: function(component, event, helper) {
            helper.initTaskflow(component, event, helper);
        },

     handleStatusChange: function(component, event, helper) {
          helper.handleTaskStatusChange(component, event, helper);
      },

      closeFlowTab: function(component, event, helper){
          helper.closeFocusedTab(component);
      }
})