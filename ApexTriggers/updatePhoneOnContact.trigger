trigger updatePhoneOnContact on Account (before insert,before update,after delete) 
{
    if(Trigger.isBefore && Trigger.isUpdate)
    {
        map<ID,Account> myMap=Trigger.newMap;
        list<Contact> con=new list<Contact>();
        list<Contact> cons=[select Id,Phone,AccountId from Contact where accountId IN:myMap.keySet()];
        for(Contact c:cons)
        {
            c.Phone=myMap.get(c.AccountId).Phone;
            con.add(c);
        }
        update con;
    }
    if(Trigger.isAfter && Trigger.isDelete)
    {
        map<ID,Account> myMap=trigger.oldMap;
       
        list<Contact> myCont=[select Id from Contact where AccountId IN:myMap.keySet()];
        delete myCont;
    }
}