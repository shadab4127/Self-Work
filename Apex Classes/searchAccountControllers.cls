public with sharing class searchAccountControllers {
 
 @AuraEnabled
    public static List<Account> getAccountName(String sreachText){
        String searchKey = '%' + sreachText + '%';
        String Query = 'SELECT Id,Name FROM Account WHERE Name LIKE : searchKey';
        List<Account> AccountList = Database.query(Query);
        System.debug(' #### sObjectList '+AccountList);
        return AccountList;
    }
}