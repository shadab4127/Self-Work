public class DeleteContacts {

    public PageReference Deleted() {
           return null;
    }

       public list<contact> listcon{get;set;}
       public boolean outputviewer{get;set;}
       public boolean inputviewer{get;set;}
    
       public DeleteContacts (){
           outputviewer=true;
           inputviewer=false;
           listcon=[select id,lastName from contact];
     }
 
       public PageReference editer() {
           outputviewer=false;
           inputviewer=true;
           return null;
     }


       public PageReference Save() {
           update listcon;
           outputviewer= true;
           inputviewer = false;
           return null;
     }
    
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