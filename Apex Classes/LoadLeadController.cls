public class LoadLeadController {
    @AuraEnabled
    public static List<Lead> getLeaddata(String leadId)
    {
        List<Lead> leadlist=[SELECT Id,Name, Title, Company, Phone, MobilePhone FROM Lead where id =:leadId];
        system.debug(leadlist);
        return leadlist;
    }
    
}