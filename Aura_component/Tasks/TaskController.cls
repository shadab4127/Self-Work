public class TaskController {
    @AuraEnabled
    public static list<wrapperClass> getAllTask(string filter)
    {
      list<Task> listTask=new list<Task>();
      list<wrapperClass> wrapperTask=new list<wrapperClass>();
        if(filter.contains('Today'))
        {
            system.Debug(filter);
			listTask=[SELECT Id,Subject,Status,ActivityDate,Who.Name,WhoId,isClosed FROM Task WHERE Who.type = 'Lead' AND ActivityDate =: system.today() AND isClosed=false LIMIT 5];
            system.Debug(filter+' List '+listTask);
        }
        else if(filter.contains('My'))
        {
            listTask=[SELECT Id,Subject,Status,ActivityDate,Who.Name,WhoId,isClosed FROM Task WHERE Who.type = 'Lead' AND OwnerId=:userinfo.getUserId() AND isClosed=false LIMIT 5]; 
            system.Debug(filter+' List '+listTask);
        }
        else if(filter.contains('All'))
        {
            listTask=[SELECT Id,Subject,Status,ActivityDate,Who.Name,WhoId,isClosed FROM Task WHERE Who.type = 'Lead' AND ActivityDate <: System.today() AND isClosed=false LIMIT 5];
            system.Debug(filter+' List '+listTask);
        }
        else if(filter.contains('Completed'))
        {
            listTask=[SELECT Id,Subject,Status,ActivityDate,Who.Name,WhoId,isClosed FROM Task WHERE Who.type = 'Lead' AND isClosed=True LIMIT 5]; 
            system.Debug(filter+' List '+listTask);
        }
        else
        {
            return null;
        }
        for(Task t:listTask)
        {
            wrapperClass obj=new wrapperClass();
            obj.getTask=t;
            obj.getTaskId=t.Id;
            obj.flag=t.IsClosed;
            system.debug('Flag'+obj.flag);
            wrapperTask.add(obj);
        }
        return wrapperTask;
    }
    @AuraEnabled public static wrapperClass getUpdateTask(String tskid)
    {
       wrapperClass obj=new wrapperClass();
       Task listTask=[SELECT Id,status,ActivityDate FROM Task WHERE Id =:tskid];
       obj.getTask=listTask;
            if(listTask.status != 'Completed')
        	{
                listTask.Status='Completed';
                obj.flag=true;
        		
        	}
        	update listTask;
   			return obj;
    }
    public class wrapperClass
    {
        @AuraEnabled public Task getTask{get;set;}
        @AuraEnabled public String getTaskId{get;set;}
        @AuraEnabled public boolean flag{get;set;}
        
    }
    @AuraEnabled
    public static Map<String, String> getStatus()
    {
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult statusResult=Task.Status.getDescribe();
        List<Schema.PicklistEntry> statusList=statusResult.getPicklistValues();
        for(Schema.PicklistEntry p:statusList)
        {
           if(p.label !='Completed')
           {
                options.put(p.getValue(), p.getLabel());
           }
        }
        return options;
    }
    @AuraEnabled
    public static Task saveStatus(String tskId, String status)
    {        
        String sts=status;
        Task tsk=[SELECT Id,Status,ActivityDate FROM Task WHERE Id =:tskId];
        tsk.status=sts;
        update tsk;
        return tsk;
    }
    @AuraEnabled
    public static Lead getLead(String leadId)
    {
        return [SELECT Id,Name,Title,Company,Phone,MobilePhone FROM Lead WHERE Id =:leadId];
    }
}
