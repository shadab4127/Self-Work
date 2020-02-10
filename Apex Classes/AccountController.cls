public with sharing class AccountController {
    
	@AuraEnabled //Save Account Data
    Public static void createAccount(Account objacc){
        try{
            //Insert Account Record
            insert objacc; 
             
        }catch(Exception e){
            //throw exception message
            throw new AuraHandledException(e.getMessage());
        }
        finally {
        }
    }
     
    @AuraEnabled //get Account Type Picklist Values
    public static Map<String, String> getType(){
        Map<String, String> options = new Map<String, String>();
        //get Account Type Field Describe
        Schema.DescribeFieldResult fieldResult = Account.Type.getDescribe();
        //get Account Type Picklist Values
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            //Put Picklist Value & Label in Map
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }
}