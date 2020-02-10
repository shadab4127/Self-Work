public with sharing class contactRole {
   @AuraEnabled(cacheable=true)
    public static list<wrapperClass> getAccountRoles(list<String> accId)
    {
        list<AccountContactRole> accConRole=new list<AccountContactRole>();
        list<wrapperClass> wrapperRoleAcc=new list<wrapperClass>();
        accConRole = [SELECT Id,IsDeleted, Contact.name,Contact.Account.Name,Contact.Id,Contact.Account.Id,
                      isPrimary,Contact.Phone,Contact.Email,Role 
                	  FROM AccountContactRole WHERE Account.id in : accId ORDER BY isPrimary DESC];
        for(AccountContactRole acr:accConRole)
        {
            wrapperClass obj=new wrapperClass();
            if(acr.IsDeleted == false)
            {
                obj.getAccConRole=acr;
            }
            wrapperRoleAcc.add(obj);
        }
        return wrapperRoleAcc;
    }
    @AuraEnabled 
    public static String getSaveRole(string recordId, boolean isPrimary,string conId,string role)
    {
        AccountContactRole ac=new AccountContactRole();
        ac.AccountId = recordId;
        ac.ContactId = conId;
        ac.IsPrimary = isPrimary;
        ac.Role = role;
        insert ac;
        return 'inserted';
    }
 @AuraEnabled public static string deleteRecord(string roleId)
 {
    String str = roleId;
    String roleIds=str.substringBefore('-');
    string result ='Delete Success';
    AccountContactRole delRole=[SELECT Id FROM AccountContactRole WHERE Id =:roleIds];
    delete delRole;
    return result;
 }
 @AuraEnabled public static string updateRecord(string recordId, boolean isPrimary,string conId,string role)
 {
    String str = recordId;
    String recordIds=str.substringBefore('-');
    AccountContactRole ac=[SELECT Id,Account.Name, ContactId,IsPrimary,Role FROM AccountContactRole WHERE Id = :recordIds];
        ac.ContactId = conId;
        ac.IsPrimary = isPrimary;
        ac.Role = role;
        update ac;
        return 'Updated';
 }   
 @AuraEnabled(cacheable=true) 
    public static wrapperClass recordToEdit(string roleId){
        String str = roleId;
        String recordIds=str.substringBefore('-');
        AccountContactRole ac=[SELECT Id,Contact.Name,Account.Name, ContactId,IsPrimary,Role FROM AccountContactRole WHERE Id =: recordIds];
        wrapperClass obj = new wrapperClass();
        obj.getAccConRole = ac;
        obj.slabel = ac.Role;
        obj.svalue = ac.Role;
        return obj;
    }
    @AuraEnabled(cacheable=true)
    public static List < wrapperClass > fatchPickListValue(sObject objInfo, string picklistFieldApi) {
        // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objInfo.getSObjectType().getDescribe();
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
 
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values = fieldMap.get(picklistFieldApi).getDescribe().getPickListValues();
 
        // Create a list of wrapper to store picklist value/lable
        list < wrapperClass > objWrapper = new list < wrapperClass > ();
 
        for (Schema.PicklistEntry a: values) {
            wrapperClass oFatchValueWrapper = new wrapperClass();
            oFatchValueWrapper.slabel = a.getLabel();
            oFatchValueWrapper.svalue = a.getValue();
            objWrapper.add(oFatchValueWrapper);
        }
        return objWrapper;
    }
    public class wrapperClass
    {
        @AuraEnabled public String getId{get;set;}
        @AuraEnabled public boolean flag{get;set;}
        @AuraEnabled public AccountContactRole getAccConRole{get;set;}
        @auraEnabled public string slabel {get;set;}
        @auraEnabled public string svalue {get;set;}
    }
    @AuraEnabled(cacheable=true)
    public static List < Contact > getContact(String searchText) {
        String searchKey = '%'+searchText + '%';
        
        List < Contact > returnList = new List < Contact > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'SELECT Id, Name,Account.Name FROM Contact WHERE Name LIKE: searchKey order by createdDate DESC';
        List < Contact > lstOfRecords = Database.query(sQuery);
        
        for (Contact obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    @AuraEnabled(cacheable=true) 
    public static integer countRole(list<string> recordId){
        integer count=[SELECT COUNT() FROM AccountContactRole WHERE Account.id in : recordId];
        return count;
    }
    @AuraEnabled(cacheable=true)
    public static String getAccounts(string accId){
        Account a=[SELECT ID,Name FROM Account WHERE Id = :accId];
        return a.Name;
    }
}
