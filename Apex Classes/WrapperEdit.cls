public class WrapperEdit {
    public Id RecordShow{get;set;}
    public list<WrapperTest> wrapper{get;set;}
      
    public WrapperEdit()
    {	
        wrapper=new list<WrapperTest>();
        list<Account> listAcc=new list<Account>();
        listAcc =[SELECT Id,Name,AccountNumber,(SELECT Id,Name,AccountId from Contacts),(select Id,AccountId from Cases),
                  (SELECT id,Name,AccountId From Opportunities) from Account];
        for(Account ac:listAcc)
        {
            wrapper.add(new WrapperTest(ac.Contacts,ac.Cases,ac.Opportunities ,ac));
        }
    }
    
    public class WrapperTest
    {
        public Account accList{get;set;}
        public list<Contact> conList{get;set;}
        public list<Case> caseList{get;set;}
        public list<Opportunity> oppList{get;set;}
      
        public WrapperTest(list<Contact> con,list<Case> cs,list<Opportunity> opp,Account ac)
        {
            this.accList = ac;
            this.conList = con;
            this.caseList= cs;
            this.oppList = opp;
        }
    }

}