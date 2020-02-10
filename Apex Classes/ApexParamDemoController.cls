public class ApexParamDemoController{
    //Property to hold the Id of the Record to be Deleted
        public Id RecordToDelete {get; set;}
    
    //Query all the Leads from the Database
        public List<Account> AllAccounts{
        get{ return [SELECT Id, Name FROM Account]; }
    }
    
    //Delete the Record from the Database
        public void deleteRecord(){
        DELETE new Account(Id = RecordToDelete);
    }

}