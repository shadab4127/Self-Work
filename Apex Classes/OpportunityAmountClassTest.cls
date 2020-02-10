@isTest
private class OpportunityAmountClassTest 
{
    @isTest static void testMethod1()
    {  
        Account a1=new Account(Name='Account 3');
        Account a2=new Account(Name='Account 4');
        list<Account> accList=new list<Account>{a1,a2};
        insert accList;
        contact c1=new Contact(lastName='Contact 1',AccountId=a1.Id);
        contact c2=new Contact(lastName='Contact 2',AccountId=a1.Id);
        contact c3=new Contact(lastName='Contact 3',AccountId=a2.Id);
        contact c4=new Contact(lastName='Contact 3',AccountId=a2.Id);
        list<Contact> conList1=new List<Contact>{c1,c2};
        list<Contact> conList2=new List<Contact>{c3,c4};
        insert conList1;
        insert conList2;
        opportunity o1=new opportunity(Name='Opportuinity 1',StageName='Closed Won',CloseDate=Date.today(),AccountId=a1.Id,contactId=c1.Id,Amount=3000);
        opportunity o2=new opportunity(Name='Opportuinity 2',StageName='Closed Won',CloseDate=Date.today(),AccountId=a1.Id,contactId=c2.Id,Amount=2000);
        opportunity o3=new opportunity(Name='Opportuinity 3',StageName='Closed Won',CloseDate=Date.today(),AccountId=a1.Id,contactId=c1.Id,Amount=3000);
        opportunity o4=new opportunity(Name='Opportuinity 4',StageName='Closed Won',CloseDate=Date.today(),AccountId=a1.Id,contactId=c2.Id,Amount=2000);        
        list<Opportunity> opList=new list<Opportunity>{o1,o2,o3,o4};               
        Test.startTest();
        insert opList;
     	Test.stopTest();
     	OpportunityAmountClass handler=new OpportunityAmountClass();
     	handler.bulkUpsert(opList);
        handler.bulkDelete(opList);	
     	handler.ConUpdate(conList1);	
        handler.ConToUpdate(conList1,conList2);
        handler.ConToDelete(conList2);
     	opList=[SELECT ID FROM Opportunity];
        DELETE opList;
        conList1=[SELECT Id FROM Contact];
        DELETE conList1;
        System.assertEquals(null,a1.Amount__c);
    }
    
}