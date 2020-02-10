public class MultipleContact{

	public list<cContact> listContact{get;set;}
    public MultipleContact()
    { 
        //constructor
        listContact=new list<cContact>();
        listContact.add(new cContact(new contact()));
    }
    public void addContact() 
    {
        Contact cnct = new Contact();
        MultipleContact.cContact cn = new MultipleContact.cContact(cnct);
        listContact.add(cn);
    }
    public pagereference saveContact()
    {
        List<Contact> myList = new List<Contact>();
        for(cContact c : listContact)
    {
        myList.add(c.con);
    }
        pagereference pg=new pagereference('/003/o');
        insert myList;
        return pg;
    }
    public pageReference RemoveContact() 
    {
        List<cContact> li = listContact;
        for(Integer i=0 ; i<li.size(); i++)
    {
    	if(li[i].isSelected == true)
    {
    	listContact.remove(i);
    }
    }
    pageReference pg1=new pageReference('/');
    	//delete listContact;
    	return null;
    }
    
    
    //Inner class of contact
    public class cContact
    {
        public Contact con{get;set;}
        public boolean isSelected{get;set;}
        public cContact(Contact con)
    {
        this.con = con;
        isSelected = false;
    }
    }

}