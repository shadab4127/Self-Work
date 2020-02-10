public with sharing class LeadOverDetails {
    @AuraEnabled(cacheable=true)
    public static List<Lead> getLead(String leadId)
    {
        return [SELECT Id,Name,Title,Company,Phone,MobilePhone FROM Lead WHERE Id =:leadId];
    }
}