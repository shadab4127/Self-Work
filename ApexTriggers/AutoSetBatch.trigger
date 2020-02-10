trigger AutoSetBatch on Batch__c (before insert, after update) 
{   
    list<String> listId=new list<String>();
    for(Batch__c b:Trigger.New)
    {
        listId.add(b.Company_Name__c);
    }
    list<Account> aclist = [select Id,Name from Account where Name IN : listId];
    for(Account ac:aclist)
    {
        for(Batch__c bc: Trigger.New)
        {
           
            if(bc.Company_Name__c == ac.Name)
                {
                    bc.Account__c=ac.Id;
                }
            else if(bc.Company_Name__c != ac.Name)
               {
                   System.debug('&&&&&&&&&&&&&&&`1');
                   bc.Account__c='';
               } 
            else
                {
                    bc.Account__c=null;
                    System.debug('&&&&&&&&&&&&&&&2s');
                }
        }
    }
    
}