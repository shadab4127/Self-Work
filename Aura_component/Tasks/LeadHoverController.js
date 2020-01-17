({
    doInit : function(component, event, helper) {
        // console.log('inaction');
        var action = component.get("c.getLead");
        action.setParams({
            "leadId" : component.get("v.whoId")
        });
        action.setCallback(this,function(response){
            var state= response.getState();
            if(state=== "SUCCESS") {
                component.set("v.Lead",response.getReturnValue());
            } else {
                alert('no lead to show');
            }
        });
        console.log('whoId11---' +component.get("v.whoId"));
        $A.enqueueAction(action);
    },
    
    doClose :function(component, event, helper){
        component.set("v.hover",false);
    },
})
