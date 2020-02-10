public class Controller1 
{

  

    string Name1;
    list<Contact> ContactResult;
    
    public String getName() 
    {
        return Name1;
    }
    public void setName(String s)
    {
        if(s !=null)
        {
        Name1=s;}
        else
            Name1='Please Enter SearchText';
    }
   
    public List<Contact> getContResults() 
    {
        return ContactResult;
    }

    public PageReference doSearch() 
    {
        ContactResult = (List<Contact>)[FIND :Name1 RETURNING Contact(Name, Phone, Email)][0];
        return null;
    }
    
    
    // Deletion
    
    public Id DeleteToRecord{get;set;}
    
    public list<Contact> AllContacts
    {
        get
        {
            return [select Id, Name from contact all Rows];
        }
    }
    
     public PageReference DeleteRecord() 
     {
        DELETE New Contact(Id = DeleteToRecord);
        return null;
    }
    
    //EDIT
    
    
      public PageReference EditRecord() 
      {
        return null;
    }

}