({
    countAccountRole : function(component,event)
    {
        var accountId=component.get("v.recordId");
        var action = component.get("c.countRole");
        action.setParams({
            "recordId" : accountId
        });
        action.setCallback(this,function(response)
        {
            var state =response.getState();
            if(state == 'SUCCESS')
            {
                var total=response.getReturnValue();
               /* console.log('Total --> '+total); */
                var t='Contact Roles ('+total+')';
                component.set("v.title",t);
            }
        });
        $A.enqueueAction(action);
    },
    callDoInit : function(component,event)
    {
        var action=component.get("c.getFiveRole");
        
        var accountId=component.get("v.recordId");
        action.setParams({
            "accId" :accountId
        });
        action.setCallback(this,function(response){
            var state=response.getState();
            //alert(state);
            if(state == 'SUCCESS')
            {
                component.set("v.accRole",response.getReturnValue());
               /* console.log('results---->',response.getReturnValue()); */
                component.set("v.all",true);
            }
        });
        $A.enqueueAction(action);
       
    }
});
