trigger AddContact on Account (After insert) 
{   
    list<Contact> accId=new list<Contact>();
    for(Account a:Trigger.New)
    {
        for(Integer i=1; i<10;i++)
        {
            Contact c=new Contact();
            c.AccountId = a.Id;
            c.lastName = a.Name +i;
            accId.add(c);
        }
    }
    if(accId.size()>0)
    {
        insert accId;
    }
}