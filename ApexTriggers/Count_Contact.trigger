trigger Count_Contact on Contact (after insert, after update, after delete) 
{
    list<Account> accList=new list<Account>();
    list<String> listId=new list<String>();
    if(Trigger.isInsert)
    {
        for(Contact con:Trigger.New)
        {
            listId.add(con.AccountId);
        }
        List<Account> accId=[select Id,Total_Contacts__c,(select Id from Contacts) from Account where ID IN:listId];
        for(Account ac:accId)
        {
            for(Contact c:Trigger.New)
            {
                if(ac.Id == c.AccountId)
                {
                    ac.Total_Contacts__c=ac.Contacts.size();
                    accList.add(ac);
                }
            }
        }
    }
    if(Trigger.isUpdate)
    {
        list<String> listId1=new list<String>();
        list<String> listId2=new list<String>();
        for(Contact c:trigger.New)
        {
            for(contact con:trigger.old)
            {
                listId1.add(c.AccountId);
                listId2.add(con.AccountId);
            }
        }
        list<Account> accList1=[select Id,Total_Contacts__c,(select Id from Contacts) from Account where ID IN:listId1];
        list<Account> accList2=[select Id,Total_Contacts__c,(select Id from Contacts) from Account where ID IN:listId2];
        for(Account a1:accList1)
        {
            for(Contact c1:Trigger.New)
            {
                if(a1.Id == c1.AccountId)
                {
                    a1.Total_Contacts__c=a1.Contacts.size();
                    accList.add(a1);
                }
            }
        }
        for(Account a2:accList2)
        {
            for(Contact c2:Trigger.old)
            {
                if(a2.Id == c2.AccountId)
                {
                    a2.Total_Contacts__c=a2.Contacts.size();
                    accList.add(a2);
                }
            }
        }
    }
    else if(Trigger.isdelete)
    {
        list<String> listId1=new list<String>();
       
            for(contact con:trigger.old)
            {
                listId1.add(con.AccountId);
            }
        
        list<Account> accList1=[select Id,Total_Contacts__c,(select Id from Contacts) from Account where ID IN:listId1];
        for(Account a1:accList1)
        {
            for(Contact c1:Trigger.old)
            {
                if(a1.Id == c1.AccountId)
                {
                    a1.Total_Contacts__c=a1.Contacts.size();
                    accList.add(a1);
                }
            }
        }
    }
    
    if(accList.size()>0)
    {
        update accList;
    }
 }