trigger Duplication on Account (before insert, before update) 
{
    list<String> accList=new list<String>();
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        for(Account ac:Trigger.New)
        {
            accList.add(ac.Name);
        }
        list<Account> accId=[select Id,Name,Rating from Account where Name IN:accList];
        for(Account a:accId)
        {
            for(Account ac1:Trigger.New)
            {
                if(a.Name == ac1.Name && a.Rating == ac1.Rating)
                {
                    ac1.Name.addError('Duplicate Name');
                    ac1.Rating.addError('Duplicate Rating');
                }
            }
        } 
    }
}