public class ContactHandler 
{
    map<Id, list<Contact>> mapId1=new map<Id, list<Contact>>();
    map<Id, list<Contact>> mapId2=new map<Id, list<Contact>>();
    map<Id,Decimal> mapCon1=new map<Id,Decimal>();
    map<Id,Decimal> mapCon2=new map<Id,Decimal>();
    map<Id,Account> mapAcc1=new map<Id,Account>();
    map<Id,Account> mapAcc2=new map<Id,Account>();
    public void ConToInsert(List < Contact > cons) 
    {
        for (Contact con: cons) 
        {
            if(mapId1.containsKey(con.AccountId))
            {
                list<Contact> conList=mapId1.get(con.AccountId);
                conList.add(con);
                mapId1.put(con.AccountId,conList);
            }
            else
            {
                list<Contact> conList=new  list<Contact> ();
                conList.add(con);
                mapId1.put(con.AccountId,conList);
            }
        }
            Decimal conSize=0;
            for(Account acc:[SELECT Total_Contacts__c,(SELECT ID FROM Contacts) FROM Account WHERE Id IN:mapId1.keySet()])
            {
                conSize=acc.Contacts.Size();
                mapCon1.put(acc.Id, conSize);
            }
            for(Id Keys:mapId1.keySet())
            {
                Account a=new Account();
                a.Id=keys;
                a.Total_Contacts__c =mapCon1.get(keys);
                mapAcc1.put(a.Id,a);
            }
            update mapAcc1.values();
    }
    public void ConToUpdate(List < Contact > cons1, List < Contact > cons2) 
    {
        for (Contact con1: cons1) 
        {
            for(Contact con2:cons2)
            {
                if(mapId1.containsKey(con1.AccountId))
                {
                    list<Contact> conList=mapId1.get(con1.AccountId);
                    conList.add(con1);
                    mapId1.put(con1.AccountId,conList);
                }
                else
                {
                    list<Contact> conList=new  list<Contact> ();
                    conList.add(con1);
                    mapId1.put(con1.AccountId,conList);
                }
                if(mapId2.containsKey(con2.AccountId))
                {
                    list<Contact> conList=mapId2.get(con2.AccountId);
                    conList.add(con2);
                    mapId2.put(con2.AccountId,conList);
                }
                else
                {
                    list<Contact> conList=new  list<Contact> ();
                    conList.add(con2);
                    mapId2.put(con2.AccountId,conList);
                }
            }
        }
            Decimal conSize=0;
            for(Account acc:[SELECT Total_Contacts__c,(SELECT ID FROM Contacts) FROM Account WHERE Id IN:mapId1.keySet()])
            {
                conSize=acc.Contacts.Size();
                mapCon1.put(acc.Id, conSize);
            }
        	for(Account acc:[SELECT Total_Contacts__c,(SELECT ID FROM Contacts) FROM Account WHERE Id IN:mapId2.keySet()])
            {
                conSize=acc.Contacts.Size();
                mapCon2.put(acc.Id, conSize);
            }
            for(Id Keys:mapId1.keySet())
            {
                Account a=new Account();
                a.Id=keys;
                a.Total_Contacts__c =mapCon1.get(keys);
                mapAcc1.put(a.Id,a);
            }
        	for(Id Keys:mapId2.keySet())
            {
                Account a=new Account();
                a.Id=keys;
                a.Total_Contacts__c =mapCon2.get(keys);
                mapAcc2.put(a.Id,a);
            }
            update mapAcc1.values();
        	update mapAcc2.values();
        } 
    public void ConToDelete(List < Contact > cons)
    {
        for(Contact con:cons)
        {
            if(mapId1.containsKey(con.AccountId))
            {
                list<Contact> conList=mapId1.get(con.AccountId);
                conList.add(con);
                mapId1.put(con.AccountId,conList);
            }
            else
            {
                list<Contact> conList=new  list<Contact> ();
                conList.add(con);
                mapId1.put(con.AccountId,conList);
            }
        }
        Decimal conSize=0;
            for(Account acc:[SELECT Total_Contacts__c,(SELECT ID FROM Contacts) FROM Account WHERE Id IN:mapId1.keySet()])
            {
                conSize=acc.Contacts.Size();
                mapCon1.put(acc.Id, conSize);
            }
            for(Id Keys:mapId1.keySet())
            {
                Account a=new Account();
                a.Id=keys;
                a.Total_Contacts__c =mapCon1.get(keys);
                mapAcc1.put(a.Id,a);
            }
            update mapAcc1.values();
    }
}