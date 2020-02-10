trigger UpdatePriority on Contact (after insert,after delete,after update) 
{
    Set<Id> accid = new Set<Id>();
    List<contact> conList = new List<contact>();
    List<Account> accList = new List<Account>();
    List<Account> ListAcc = new List<Account>();
    List<Contact> ListCon = new List<Contact>();
    Map<Account,List<Contact>> AccPriority = new Map<Account,List<Contact>>();
    
        if(trigger.isinsert)
        {
            for(contact c:trigger.new)
            {
                accid.add(c.accountid);
            }
        }
        
        if(trigger.isdelete)
        {
            for(contact c:trigger.old)
            {
                accid.add(c.accountId);
            }
        }
        
        conList = [select id, name,Priority__c, accountId, createddate, LastModifiedDate from contact where accountid in:accid order by CreatedDate Asc];
        accList = [select id, name, CustomerPriority__c from account where id in:accid];
        
        if(conList.size()>0)
        {
            for(Account a:accList)
            {
                ListCon.clear();
                for(Contact c:conList)
                {
                    if(a.id == c.accountid)
                    {
                        ListCon.add(c) ;                        
                    }
                }
                AccPriority.put(a,ListCon);
            }
        }
        
        if(AccPriority.size()>0)
        {
            for(Account a:AccPriority.keyset())
            {
                List<Contact> customerList = AccPriority.get(a);
                system.debug('Contact List = '+ListCon);
                Integer Flag = 0;
                for(contact c:customerList)
                {
                        if(c.Priority__c == 'High' && Flag != 1)
                        {
                            a.CustomerPriority__c = 'High';
                            a.Highest_Priority_Contact__c = c.Name;
                            Flag = 1;
                            system.debug('High');
                        }
                        else if(c.Priority__c == 'Medium' && (Flag == 0 || Flag == 3))
                        {
                            a.CustomerPriority__c = 'Medium';
                            a.Highest_Priority_Contact__c = c.Name;
                            Flag = 2;
                            system.debug('Medium');
                        }
                        else if(c.Priority__c == 'Low' && Flag == 0)
                        {
                            a.CustomerPriority__c = 'Low';
                            a.Highest_Priority_Contact__c = c.Name;
                            Flag = 3;
                            system.debug('low');
                        }
                }
                ListAcc.add(a);
            } 
        }
        if(ListAcc.size()>0)
        {
            update ListAcc;
        }
}