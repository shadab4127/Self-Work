trigger PolicyTrigger on Policy__c (before insert, before update) 
{
    if(Trigger.isInsert || Trigger.isUpdate)
    {
        map<String, map<String,Integer>> mapId=new  map<String, map<String,Integer>>();
        map<String, Integer> Hmap=new map<String, Integer>();
        map<String, Integer> Cmap=new map<String, Integer>();
        Hmap.put('3', 30);
        Hmap.put('5', 50);
        Cmap.put('3', 20);
        Cmap.put('5', 40);
        mapId.put('Health Insurance', Hmap);
        mapId.put('Car Insurance', Cmap);
        for(Policy__c pol:Trigger.New)
        {
            if(pol.Amount__c >= 200000)
            {
            pol.After_Discount__c=pol.Amount__c -(pol.Amount__c * (mapId.get(pol.Policy_Type__c).get(pol.Tenure__c))/100);
            }
            else
            {
                pol.Amount__c.adderror('Amount should be greater than 200000');
            }
        }
    }
}