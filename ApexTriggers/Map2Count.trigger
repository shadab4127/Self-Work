trigger Map2Count on Contact (after insert,after update, after delete) 
{
    map<Id, set<String>> mapId=new map<Id, set<String>>();
    list<Account> acList=new list<Account>();
    list<String> setId=new list<String>();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        for(Contact con:Trigger.New)
        {
            setId.add(con.AccountId);
        }
           
            for(Contact c1:[select Id,firstName,lastName,AccountId,Priority__c from Contact where accountId IN:setId])
               {
                   if(mapId.containsKey(c1.AccountId))
                   {
                       set<String> c2=mapId.get(c1.AccountId);
                       c2.add(c1.Priority__c);
                       mapId.put(c1.AccountId,c2);
                   }
                   else
                   {
                       set<String> c3=new set<String>();
                       c3.add(c1.Priority__c);
                       mapId.put(c1.AccountId,c3);
                   }  
                }
       
        for(Account ac:[select Id,Highest_Priority_Contact__c,CustomerPriority__c from Account where Id IN:mapId.keySet()])
        {
            for(Contact c:Trigger.New)
            {
                if(mapId.get(c.accountId).contains('High'))
                {
                    ac.CustomerPriority__c = 'High';                  
                }
                else if(mapId.get(c.accountId).contains('Medium'))
                {
                    ac.CustomerPriority__c = 'Medium';
                }
                else if(mapId.get(c.accountId).contains('Low'))
                {
                    ac.CustomerPriority__c = 'Low';
                }
                else
                {
                     ac.CustomerPriority__c = '';
                }
                acList.add(ac);
            }
        }
    }
    update acList;
}