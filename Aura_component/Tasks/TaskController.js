({
	doInit : function (component, event,helper) {
        var action = component.get("c.getAllTask");
        var today=$A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        var today1=new Date();
        var pre= today1.getFullYear() + "-" + (today1.getMonth() + 1) + "-" + (today1.getDate()-1 );
        var yes=$A.localizationService.formatDate(pre, "YYYY-MM-DD");
       	var next= today1.getFullYear() + "-" + (today1.getMonth()+1) + "-" + (today1.getDate()+1);
        var tom=$A.localizationService.formatDate(next, "YYYY-MM-DD");
        component.set("v.today",today);
        component.set("v.yesday",yes);
        component.set("v.tomorrow",tom);
       	console.log('YESTERDAY ---> '+yes);
        console.log('Tomorrow ---> '+tom);
        action.setParams({
            "filter" : component.get("v.heading")
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS')
            {          
                console.log(response.getReturnValue());
                component.set("v.Task",response.getReturnValue());   
            }
            else
            {
                Alert('No Task to show');
            }
        });
         $A.enqueueAction(action);
    },
    handleSelect: function (component, event,helper) {
       var selectedMenuItemValue = event.getParam("value");
       var menuItems=component.find("menuitems");
        menuItems.forEach(function(menuItem){
            if(menuItem.get("v.checked"))
            {
                menuItem.set("v.checked",false);
            }
            if(menuItem.get("v.value") == selectedMenuItemValue)
            {
               var selectlabel = menuItem.get("v.label");
                
               console.log('selectlabel--->'+selectlabel); 
                 menuItem.set("v.checked",true);
                 var selectHead=menuItem.get("v.value");
                
                if(selectHead == 'MenuItemFour')
                {
                    component.set("v.heading",'Completed Tasks');
                }
                else if(selectHead == selectedMenuItemValue)
                {
                    component.set("v.heading",selectlabel);
                }
                helper.helperMethod(component, selectlabel);
            }
        }); 
    },
    onChange : function(component, event, helper)
    {	
       	var today=$A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
       
       var selectedId = event.target.getAttribute('id');
       var isChecked = document.getElementById(selectedId).checked;
       
       if(isChecked)
       {	
           var action = component.get("c.getUpdateTask");
            action.setParams({
                "tskid": selectedId
            }); 
            action.setCallback(this,function(response){
                var state = response.getState();
                if(state == 'SUCCESS')
                {	
                    
                    document.getElementById(selectedId+'atag').style.textDecoration = "line-through";
                    var active = response.getReturnValue();
                    console.log('rep-->'+active['getTask']['ActivityDate']);
                    var date=active['getTask']['ActivityDate'];
                    console.log('ActivityDate-->'+date);
                    
                    if(date < today)
                    {
                        document.getElementById(selectedId+'tag').style.color = "black";
                    }
                    
                }
               
            });
            $A.enqueueAction(action);
       }
       else
        {
            component.set("v.tskIds",selectedId);
            helper.getTaskStatus(component,event);
            component.set("v.showModal",true);
        }
    },
    getRadioValue :function(component, event, helper){
      var status = event.getSource().get("v.value");
      console.log('Status ---> '+status);
      var selectedId = event.getSource().get("v.id");
      console.log('selectedId-->'+selectedId);
      var selectedStatus=component.set("v.rstatus",status);
      console.log('selectedStatus-------> '+selectedStatus);
    },
    saveTask : function(component, event, helper){
        var today=$A.localizationService.formatDate(new Date(), "YYYY-MM-DD");
        var action = component.get("c.saveStatus");
        var tskIds = component.get("v.tskIds");
        var status = component.get("v.rstatus");
        console.log('tskIds--->'+tskIds);
        console.log('status--->'+status);
        
        action.setParams({
            "tskId" : tskIds,
            "status" : status
        });
		action.setCallback(this,function(response){
            var state = response.getState();
            if(state == 'SUCCESS')
            { 	
                document.getElementById(tskIds+'atag').style.textDecoration = "none";
                document.getElementById(tskIds).checked = false;
                var active = response.getReturnValue();
                console.log('rep-->'+active['ActivityDate']);
                var date=active['ActivityDate'];
                console.log('ActivityDate-->'+date);
                if(date < today)
                    {
                        document.getElementById(tskIds+'tag').style.color = "#c23934";
                    }
            }
            else
            {
                Alert('No Task to show');
            }
        });
         $A.enqueueAction(action);       
        component.set("v.showModal",false);
    },
    
    //--------------UPDATE Status Using Radio button------------------//
    closeModel: function(component, event, helper){
        component.set("v.showModal",false);
    },
	mouseOver : function(component, event, helper){
       
        var whoId =  event.target.getAttribute("data-attriVal");
        console.log('idval--' +event.target.getAttribute('id'));
        console.log('tskId1--' +whoId);
        component.set("v.whoId",whoId);
        setTimeout(function(){component.set("v.hover",true);},1000);
        component.set("v.tagId",event.target.getAttribute('id'));
    },
    mouseOut : function(component, event, helper){
       setTimeout(function(){ component.set("v.hover",false); }, 3000);
    },    
})
