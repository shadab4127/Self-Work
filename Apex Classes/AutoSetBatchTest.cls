@isTest

private class AutoSetBatchTest {
    @isTest static void method1()
    {
        list<Batch__c> listAcc=new list<Batch__c>();
        for(integer i=1; i<20; i++)
        {
            Batch__c ab=new Batch__c(Company_Name__c='Abcd'+i);
           listAcc.add(ab);
        }
         insert listAcc;
    }
     @isTest static void method2()
    {
        list<Account> listAcc=new list<Account>();
        for(integer i=1; i<20; i++)
        {
            Account ab=new Account(Name='Abcd'+i);
           listAcc.add(ab);
        }
         insert listAcc;
    }
    
   

}