({
	helperMethod : function(component,selectlabel) {
       
		var action = component.get("c.getAllTask");
        action.setParams({
            
            "filter" : selectlabel
        });
       
       action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS')
            {
                component.set("v.Task",response.getReturnValue());
            }
            else
            {
                Alert('No Task to show');
            }
        });
         $A.enqueueAction(action);
	},
    getTaskStatus : function(component,event)
    {
        var action = component.get("c.getStatus");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var statusMap = [];
                for(var key in result){
                    statusMap.push({label: result[key], value: key});
                }
                console.log('statusMap--->'+statusMap);
                component.set("v.status", statusMap);
            }
        });
        $A.enqueueAction(action); 
    },
    getLeadDate : function(component,event){
       var action = component.get("c.getLead");
         action.setParams({
            "leadId" : component.get("v.whoId")
        });
        action.setCallback(this,function(response){
            var state= response.getState();
            if(state=== "SUCCESS") {
                component.set("v.Leads",response.getReturnValue());
            } 
        });
        console.log('whoId11---' +component.get("v.whoId"));
        $A.enqueueAction(action);
    }
})
