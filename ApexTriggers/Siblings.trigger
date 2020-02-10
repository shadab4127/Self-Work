trigger Siblings on Contact (before insert, before update) 
{
    List<Contact> conList=New List<Contact>();
    list<String> listId=new list<String>();
    for(Contact co:Trigger.New)
    {
        listId.add(co.AccountId);
    }
    list<Contact> conId=[select Id,Siblings_Contacts__c from Contact where Id IN:listId];
    for(Contact c:Trigger.New)
    {
        c.Siblings_Contacts__c=listId.size();  
    }
  
}