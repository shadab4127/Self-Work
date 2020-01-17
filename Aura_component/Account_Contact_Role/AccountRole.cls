public class AccountRole {
    
    /* ----------------Get 5 Role -----------------*/
	@AuraEnabled
    public static list<wrapperClass> getFiveRole(list<String> accId)
    {
        list<AccountContactRole> accConRole=new list<AccountContactRole>();
        list<wrapperClass> wrapperRoleAcc=new list<wrapperClass>();
        accConRole = [SELECT Id,IsDeleted, Contact.name,Contact.Account.Name,Contact.Id,Contact.Account.Id,
                      isPrimary,Contact.Phone,Contact.Email,Role 
                	  FROM AccountContactRole WHERE Account.id in : accId ORDER BY isPrimary DESC LIMIT 5];
        System.debug('accConRole'+accConRole);
        for(AccountContactRole acr:accConRole)
        {
            wrapperClass obj=new wrapperClass();
            if(acr.IsDeleted == false)
            {
                obj.getAccConRole=acr;
                System.debug('obj.getAccConRole--->'+obj.getAccConRole);
            }
            wrapperRoleAcc.add(obj);
        }
        return wrapperRoleAcc;
    }
    
    
  	/* ----------------Get All Role -----------------*/
    @AuraEnabled
    public static list<wrapperClass> getAllRole(list<String> accId)
    {
        list<AccountContactRole> accConRole=new list<AccountContactRole>();
        list<wrapperClass> wrapperRoleAcc=new list<wrapperClass>();
        accConRole = [SELECT Id,IsDeleted, Contact.name,Contact.Account.Name,Contact.Id,Contact.Account.Id,
                      isPrimary,Contact.Phone,Contact.Email,Role 
                	  FROM AccountContactRole WHERE Account.id in : accId ORDER BY isPrimary DESC];
        System.debug('accConRole'+accConRole);
        for(AccountContactRole acr:accConRole)
        {
            wrapperClass obj=new wrapperClass();
            if(acr.IsDeleted == false)
            {
                obj.getAccConRole=acr;
                System.debug('obj.getAccConRole--->'+obj.getAccConRole);
            }
            wrapperRoleAcc.add(obj);
        }
        return wrapperRoleAcc;
    }
    
    /* ----------------Wrapper Class -----------------*/
    
    public class wrapperClass
    {
        @AuraEnabled public String getId{get;set;}
        @AuraEnabled public boolean flag{get;set;}
        @AuraEnabled public AccountContactRole getAccConRole{get;set;}
    }
    
      /* ----------------Display Role -----------------*/
    
    @AuraEnabled
    public static Map<String, String> getPickListValuesIntoList()
    {
        Map<String, String> options = new Map<String, String>();
        Schema.DescribeFieldResult statusResult=AccountContactRole.Role.getDescribe();
        List<Schema.PicklistEntry> statusList=statusResult.getPicklistValues();
        for(Schema.PicklistEntry p:statusList)
        {
                options.put(p.getValue(), p.getLabel());
        }
        return options;
    }  
    
      /* ----------------Fetch Account -----------------*/
    
    @AuraEnabled
    public static Account getAccount(String accId)
    {
        Account acc=[SELECT id, Name FROM Account WHERE id=:accId];
        return acc;
    }
    
    /* ---------------- Fetch LookUp Values  -----------------*/
    @AuraEnabled
    public static List < Contact > fetchLookUpValues(String searchKeyWord, String ObjectName) {
        system.debug('ObjectName-->' + ObjectName);
        String searchKey = searchKeyWord + '%';
        
        List < Contact > returnList = new List < Contact > ();
      
        // Create a Dynamic SOQL Query For Fetch Record List with LIMIT 5   
        String sQuery =  'select id, Name from ' +ObjectName + ' where Name LIKE: searchKey order by createdDate DESC LIMIT 10';
        List < Contact > lstOfRecords = Database.query(sQuery);
        
        for (Contact obj: lstOfRecords) {
            returnList.add(obj);
        }
        return returnList;
    }
    
      /* ----------------Save Role -----------------*/
    
    @AuraEnabled 
    public static String getSaveRole(string recordId, boolean isPrimary,string conId,string role)
    {
        System.debug('recordId---> '+recordId);
        System.debug('isPrimary---> '+isPrimary);
        System.debug('conId---> '+conId);
        System.debug('role---> '+role);
        AccountContactRole ac=new AccountContactRole();
        ac.AccountId = recordId;
        ac.ContactId = conId;
        ac.IsPrimary = isPrimary;
        ac.Role = role;
        insert ac;
        System.debug('AccountContactRole---> '+ac);
        return 'inserted';
    }
    
    
    
    /* ----------------Edit Role -----------------*/
    
    @AuraEnabled
    public static string getRoleEdit(string roleId, boolean isPrimary,string conId,string role){
        System.debug('recordId---> '+roleId);
        System.debug('isPrimary---> '+isPrimary);
        System.debug('conId---> '+conId);
        System.debug('role---> '+role);
        AccountContactRole ac=[SELECT Id,Account.Name, ContactId,IsPrimary,Role FROM AccountContactRole WHERE Id =: roleId];
        ac.ContactId = conId;
        ac.IsPrimary = isPrimary;
        ac.Role = role;
        update ac;
        System.debug('AccountContactRole---> '+ac);
        return 'Updated';
    }
 /* ----------------Record on Edit Role -----------------*/
    @AuraEnabled
    public static AccountContactRole getAccountRole(string roleId){
        System.debug('recordId---> '+roleId);
        AccountContactRole ac=[SELECT Id,Contact.Name, ContactId,Account.Name,IsPrimary,Role FROM AccountContactRole WHERE Id =: roleId];
        System.debug('AccountContactRole---> '+ac);
        return ac;
    }
      /* ----------------Delete Role -----------------*/
    
    
 	 @AuraEnabled
     public static String getRoleDelete(String roleId){
         system.debug('roleId-->'+roleId);
         AccountContactRole delAcc=[SELECT Id FROM AccountContactRole WHERE id=:roleId];
         delete delAcc;
         return 'Delete';
    }    
	    /* ----------------Count Role -----------------*/
    @AuraEnabled 
    public static integer countRole(list<string> recordId){
        
        integer count=[SELECT COUNT() FROM AccountContactRole WHERE Account.id in : recordId];
		system.debug('Count'+count);
        return count;
        
    }
}
