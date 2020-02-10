trigger leftContact on Contact (after insert) {
Map<Id,list<Contact>> mapId=new Map<Id,list<Contact>>();
Map<Id,Account> mapAccId=new Map<Id,Account>();
Map<Id,Account> mapAcc=new Map<Id,Account>();
    for(Contact c :Trigger.isDelete ? Trigger.old : Trigger.New){
        if (mapId.containskey(c.accountId)) {
           list < Contact > listcon = mapId.get(c.accountId);
           listcon.add(c);
           mapId.put(c.accountId, listcon);
        } else {
           list < Contact > listcon = new list < Contact > ();
           listcon.add(c);
           mapId.put(c.accountId, listcon);
        }
    }
    for(Account a :[SELECT Id,hasactivecontacts__c,(SELECT ID,leftthefirm__c FROM Contacts) FROM Account WHERE Id IN:mapId.keySet()]){
        if(a.contacts.size()>0){
            for(Contact cs: a.Contacts){
            if(cs.leftthefirm__c == true){
                Account a2=New Account();
                a2.hasactivecontacts__c  =false;
                a2.Id=a.Id;
                mapAccId.put(a2.Id, a2);
                
                }
                }
            }
            else
            {
                Account a2=New Account();
                a2.hasactivecontacts__c  =true;
                a2.Id=a.Id;
                mapAccId.put(a2.Id, a2);
            }
    }
    for(Id keys : mapAccId.keySet()){
        Account ac1 = new Account();
                        ac1.Id = keys;
                        ac1=mapAccId.get(keys);
                        mapAcc.put(ac1.Id, ac1);
    }
    update mapAcc.values();
}