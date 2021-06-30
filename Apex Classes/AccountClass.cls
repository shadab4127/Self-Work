public class AccountClass {
	@AuraEnabled
    public static list<Account> getAccount(String recordName){
        Return [SELECT Id,Name,Type,(SELECT ID,Name FROM Contacts) FROM Account WHERE Name =:recordName ];
    }
    @AuraEnabled
    public static list<Account> getAllAccount(){
        Return [SELECT Id,Name,Type,(SELECT ID,Name FROM Contacts) FROM Account];
    }
}