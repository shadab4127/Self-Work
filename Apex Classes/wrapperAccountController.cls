public with sharing class wrapperAccountController {

    public String accountIdParam = '';
    public List<OppWrapper> Opplist = new List<OppWrapper>();
   
    
    public wrapperAccountController(Apexpages.standardcontroller controller){
        accountIdParam = ApexPages.currentPage().getParameters().get('id');
        system.debug('@@hellow'+accountIdParam);
     for(Account a :[Select id,name,(Select name from opportunities),(Select casenumber,Product__c from cases),(Select FirstName, Email from contacts) from Account where id =: accountIdParam]){
           
                Opplist.add(new OppWrapper(a,a.opportunities,a.contacts,a.cases));
           
        }
    }

    public List<OppWrapper> getOppList()
    {
        System.debug('count'+Opplist.size());
        return Opplist;
    }
 


    public class OppWrapper{
    public account a{get;set;}
        public list<Opportunity> opp { get; set; }
        public list<contact> con{get;set;}
        public list <case> cas{get;set;}
        public OppWrapper(account ac,List<Opportunity>opp1,List<Contact> con1,List<Case>cas1){
            a=ac;
            opp = opp1;
            con=con1;
            cas=cas1;
        }
    }


}