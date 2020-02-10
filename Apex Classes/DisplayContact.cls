public with sharing class DisplayContact {
    public List<Contact> conList {get;set;}
    public List<Opportunity> oppList {get;set;}
    public DisplayContact(ApexPages.StandardSetController controller) {

    }
    
    public PageReference ContactLists()
    {
    if(ApexPages.currentPage().getParameters().get('id') != null)
    {
      conList = [Select id,Name,Phone,Email from contact where accountId =: ApexPages.currentPage().getParameters().get('id')];
      oppList = [Select id,Name,Type,StageName,CloseDate from Opportunity where accountId =: ApexPages.currentPage().getParameters().get('id')];
     
    }
        return null;
    }  
    
}