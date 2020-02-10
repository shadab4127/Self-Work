public class DeleteRcords {
   
        //Property to hold the Id of the Record to be Deleted
        public Id RecordToDelete {get; set;}
    
    //Query all the Leads from the Database
        public List<Contact> AllContact{
        get{ return [SELECT Id, Name FROM Contact]; }
    }
    
    //Delete the Record from the Database
        public void deleteRecord(){
        DELETE new Contact(Id = RecordToDelete);
    }


}