public class controller2 {

    public list<Contact> listCon{get;set;}
    public Id RecordToDelete{get;set;}
    public Boolean outputviewer{get;set;}
    public Boolean inputviewer{get;set;}

    public controller2()
    {
        listCon=[select Id,Name from contact];
        outputviewer=true;
        inputviewer=false;
        
    }
    public list<Contact> AllContacts { get{return [SELECT ID,Name from Contact];} }
    
    public PageReference deleteRecord() 
    {
        DELETE new Contact(Id=RecordToDelete);
        outputviewer=true;
        inputviewer=false;
        return null;
    }
    
    //Updation 
    
     public Id RecordToUpadte{get;set;}
     public PageReference updateRecord() 
     {
        outputviewer=false;
        inputviewer=True;
     	return null;
     }
    
    //Save Record
    public PageReference doCancel() 
    {    
    
        outputviewer=true;
        inputviewer=false;    
        return null;
    }


    public PageReference doSave() {
        update listCon;
        outputviewer=true;
        inputviewer=false; 
        
        return null;
    }
}