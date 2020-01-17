({
    doInit : function (component, event, helper){
        helper.countAccountRole(component, event, helper);
        helper.callDoInit(component, event, helper);
    },
     doClick: function (component, event, helper){
        var action=component.get("c.getAllRole");
        var accountId=component.get("v.recordId");
        action.setParams({accId:accountId});
        action.setCallback(this,function(response){
            var state=response.getState();
            //alert(state);
            if(state == 'SUCCESS')
            {
                component.set("v.accRole",response.getReturnValue());
               /* console.log('results---->',response.getReturnValue()); */
            }
        });
         $A.enqueueAction(action);
    },
    doDelete : function (component, event, helper){
        var selectedId = event.target.getAttribute('id');
        //alert(selectedId);
        component.set("v.acrId",selectedId);
        component.set("v.delModel",true);
    },
    doEdit : function (component, event, helper){
        var selectedId = event.target.getAttribute('id');
        component.set("v.acrId",selectedId);
        component.set("v.editModel",true);
    },
    doClose : function (component, event, helper){
         component.set("v.delModel",false);
    },
   
    openNew : function (component, event, helper){
        var action=component.get("c.getAccount");
        var accountId=component.get("v.recordId");
        action.setParams({
            "accId":accountId
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            //alert(state);
            if(state == 'SUCCESS')
            {
                component.set("v.accounts",response.getReturnValue());
              /*  console.log('Account name -->'+response.getReturnValue()); */
                component.set("v.newModel",true);
            }
        });
         $A.enqueueAction(action);
    },
    showAll : function (component, event, helper){
        helper.countAccountRole(component, event, helper);
        var action=component.get("c.getAllRole");
        
        var accountId=component.get("v.recordId");
        action.setParams({accId:accountId});
        action.setCallback(this,function(response){
            var state=response.getState();
            //alert(state);
            if(state == 'SUCCESS')
            {
                component.set("v.accRole",response.getReturnValue());
              /*  console.log('results---->',response.getReturnValue()); */
                component.set("v.all",false);
            }
        });
        $A.enqueueAction(action);
    }
});
