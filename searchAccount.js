({
	handleKeyUp : function(component, event, helper) {
		var searchText = component.find('searchText').get('v.value');
        var searchEvent = component.getEvent('LookupEvent');
        searchEvent.setParams({
            searchText : searchText
        });
        searchEvent.fire();
	},
    doHandleSearchEvent : function(component, event, helper) {
		var searchParam = event.getParam('searchText');
        var action = component.get('c.getAccountName');
        //alert(searchParam);
        action.setParams({
            sreachText : searchParam
        });
        if(!searchParam){
            component.set('v.recordList', null);
            return;
        }
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === 'SUCCESS' || state ==='DRAFT'){
                var responseValue = response.getReturnValue();
                console.log('responseValue ', responseValue);
                component.set('v.recordList', responseValue);
            }
        });
        $A.enqueueAction(action);
	},
   
    handleRemove : function(component, event, helper) {
        event.preventDefault();
        component.set('v.selecteRecord', null);
        component.set('v.recordValue', null);
        var eventSource = event.getSource();
        var index = eventSource.get('v.name');
        var selRecordList = component.get('v.selectedRecordList');
        selRecordList.splice(index, 1);
        component.set('v.selectedRecordList', selRecordList);
        var selectEvent = component.getEvent('selectEvent');
        selectEvent.setParams({
            record : selRecordList
        });
        selectEvent.fire();
    },
    doClose :  function(component, event, helper)
    {
        var urlEvent = $A.get("e.force:navigateToURL");
    	urlEvent.setParams({
      	"url": "/lightning/o/Account/home"
    	});
    	urlEvent.fire();
    },
    createRecord : function (component, event, helper) {
       
    var createRecordEvent = $A.get("e.force:createRecord");
    createRecordEvent.setParams({
        "entityApiName": "Account"       
    });
    createRecordEvent.fire();    
}
})
