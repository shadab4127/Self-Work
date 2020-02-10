public class ContactListControllers 
{
	
    @AuraEnabled
    public static List<Account> getContactList(List<Id> accountIds) 
    {
    	// Getting the list of contacts from where Id is in accountIds
		List<Account> accountList = [SELECT Id, Name, Phone,ParentId , Rating, AccountNumber,OwnerId,Site,	Amount__c,	AnnualRevenue,
                                    BillingAddress,NumberOfEmployees,Fax,Industry,Ownership,Sic,Type FROM Account];
		// Returning the contact list
        return accountList;
    }

    @AuraEnabled
    public static Map<String,String> saveContactList(List<Contact> contactList) 
    {
    	// Forming a  string map to return response
        Map<String,String> resultMap = new Map<String,String>();
        // Adding try catch for exception handling
        try {
        	// Updating the Contact List
            update contactList;
            // Setting the success status and message in resultMap
            resultMap.put('status', 'success');
	        resultMap.put('message', 'Contacts Updated Successfully');        
    	}
    	catch(Exception e) {
            // Setting the error status and message in resultMap
            resultMap.put('status', 'error');
			resultMap.put('message',e.getMessage());
    	}
    	// Returning the result string map
        return resultMap;
    }
    
    @AuraEnabled
    public static Map<String,String> deleteContactList(List<Id> contactIds) 
    {
        //Fetching Contacts
        List<Contact> contactsToDelete = [SELECT Id FROM Contact WHERE Id in :contactIds];
        // Forming a  string map to return response
        Map<String,String> resultMap = new Map<String,String>();
        // Adding try catch for exception handling
        try {
        	// Deleting the Contacts
            delete contactsToDelete;
            // Setting the success status and message in resultMap
            resultMap.put('status', 'success');
	        resultMap.put('message', 'Contacts Deleted Successfully');        
    	}
    	catch(Exception e) {
            // Setting the error status and message in resultMap
            resultMap.put('status', 'error');
			resultMap.put('message',e.getMessage());
    	}
    	// Returning the result string map
        return resultMap;                
    }

    @AuraEnabled
    public static Map<String, String> createContactRecord(Contact newContact) 
    {
        // Forming a  string map to return response
        Map<String,String> resultMap = new Map<String,String>();
        // Adding try catch for exception handling
        try {
            // Inserting the Contact
            insert newContact;
            // Setting the success status and message in resultMap
            resultMap.put('status', 'success');
            resultMap.put('message', 'Contact Inserted Successfully');        
        }
        catch(Exception e) {
            // Setting the error status and message in resultMap
            resultMap.put('status', 'error');
            resultMap.put('message',e.getMessage());
        }
        // Returning the result string map
        return resultMap;        
    }
}