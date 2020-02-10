public class ContactListController {
	@AuraEnabled
   public static List<Contact> getContacts() {
       return [SELECT Id, AccountId, Account.Name,FirstName, LastName,MobilePhone, Phone,Email
       FROM Contact ORDER BY LastModifiedDate];
   }
}