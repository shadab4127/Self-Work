public class TaskCustomController {
    @AuraEnabled
    public static List<wrapperClass> getTaskList(String filter) {
        system.debug('filter-' +filter);
        List<Task> tsklist=new   List<Task>();
        if(filter == 'Todays Tasks' || filter== 'Today') {
            tsklist= [SELECT Subject,ActivityDate,Who.Name,lastmodifieddate,status
                      FROM Task 
                      WHERE who.type='Lead' and ActivityDate=:system.today() AND IsClosed= false LIMIT 5];
            
            // return tsklist;
        } 
        else if (filter == 'My Tasks') {
            tsklist= [SELECT Subject,ActivityDate,Who.Name,OwnerId,lastmodifieddate,status
                      FROM Task 
                      WHERE who.type='Lead' and OwnerId=:userinfo.getUserId() AND IsClosed = false LIMIT 5];
            
            // return tsklist;	
        } 
        else if(filter == 'Completed Tasks') {
            tsklist= [SELECT Subject,ActivityDate,Who.Name,OwnerId,lastmodifieddate,status
                      FROM Task 
                      WHERE who.type='Lead' and IsClosed= true LIMIT 5];
            
            // return tsklist;	
        } else if(filter == 'All Overdue') {
            Date todaydate = System.today();
            tsklist= [SELECT Subject,ActivityDate,Who.Name,OwnerId,lastmodifieddate,status
                      FROM Task 
                      WHERE who.type='Lead' and ActivityDate <: todaydate AND IsClosed= false LIMIT 5];
            
            // return tsklist;	
        }
        else {
            return null;
        }
        
        
        List<wrapperClass> wrapList=new List<wrapperClass>();
        for(Task t:tsklist)
        {
            wrapperClass obj=new wrapperClass();
            obj.tasklist=t;
            //  system.debug(System.now().format('YYYY-MM-DD') +'  lst ' +t.lastmodifieddate.format('YYYY-MM-DD'));
            //  //System.now()==t.lastmodifieddate && 
            if((System.now() > t.ActivityDate) && t.Status!='Completed')
            {
                obj.flag=true;
            }
            else
            {
                obj.flag=false;
            }
            wrapList.add(obj);
        }
        system.debug(wrapList);
        return wrapList;
        // wrapperClass returnwrapperClass = new  wrapperClass (); 
    }
    @AuraEnabled
    public static String updateTaskstatus(String tskid,String status)
    {
        // system.debug(tskid);
        string returnStr;
        try
        {
            Task task=[select  id,Status from Task   WHERE id =: tskid];
            // if (!task.isEmpty())
            // {
            if(task.status=='Completed')
            {
                task.Status='In Progress';
            }
            else
            {
                task.Status='Completed';
            }
            update task;
            returnStr='Status updated to '+ task.Status;
            
        }
        catch(Exception e) {
            
            System.debug('An unexpected error has occurred: ' + e.getMessage());
            returnStr='An unexpected error has occurred: ' + e.getMessage();
        }
        return returnStr;
    }
    public class wrapperClass{
        @AuraEnabled public  Task tasklist{get;set;}
        @AuraEnabled public boolean flag{get;set;}
        // @AuraEnabled public String headerMsg {get;set;}
    }
    
}