@isTest

private class testwrapperTest 
{
    static testMethod void Method1()
    {   
        list<Account> acc=new list<Account>(); 
        for(Integer i=1; i<100; i++)
        {
            Account a=new Account(Name='Abc'+i);
            acc.add(a);
        }
        insert acc;
        PaginationController pc =new PaginationController();
        pc.First();
        pc.Next();
        pc.Last();
        pc.Previous();
        pc.getNxt();
        pc.getPrev();
        pc.getAllAccounts();
     }   
     
     static testMethod void Method2()
    {
        
        PaginationController pc =new PaginationController();
        pc.getPrev();
        pc.getNxt();
     }   
      static testMethod void Method3()
    {
        
        PaginationController pc =new PaginationController();
        
     }   
         
}