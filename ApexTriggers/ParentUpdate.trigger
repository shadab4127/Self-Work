trigger ParentUpdate on Account (after insert) {
    list<Account> accId=new list<Account>();
    set<Id> aId=new set<Id>();
    for(Account a:trigger.new)
    {
        aId.add(a.ParentId);
    }
    for(Account ac:[SELECT Id,Name,Amount__c from Account WHere Id IN:aId])
    {
        for(Account ac1:Trigger.New)
        {
            ac.Amount__c =ac1.Amount__c;
            accId.add(ac);
        }
    }
    update accId;
}