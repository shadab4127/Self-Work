public class standardsetctrl 
{

 	Public List<categoryWrapper> categories {get;set;}
    Public Account acc {get; set;}     
    public String accID;    
	public ApexPages.StandardSetController con 
    {
        get {
            String accID=  ApexPages.currentPage().getParameters().get('acId');
            acc=[select name,id,phone,Industry from account where id=:accID];
            if(con == null) 
            {
                con = new ApexPages.StandardSetController(Database.getQueryLocator([Select Id, Name, Phone, Email FROM Contact where AccountID=:accID Order By Name]));             
                con.setPageSize(5);                
            }
            return con;           
    		}
        set;
	}
  	public List<CategoryWrapper> getCategories() 
    {
        categories = new List<categoryWrapper>();
              for (Contact category : (List<Contact>)con.getRecords()) 
              {
            	categories.add(new CategoryWrapper(category));
        	  }
        system.debug('cons1'+categories.size());
        return categories;
    }
	public pagereference process()
    {         
        List<Contact> contactsDel=new List<Contact>();
 		for (CategoryWrapper cw : categories) 
        {
             if (cw.checked) 
             {
                 contactsDel.add(cw.cat);
             }            
        }
             if(contactsDel!=null)
             {
         		delete contactsDel;
                categories.clear();
                getCategories();
      		 }           
          PageReference p = new PageReference(ApexPages.currentPage().getUrl());
          p.setRedirect(true);     
          return p ;   
     }
     public Integer totalPages {
			get {
                Integer currPageNumber = con.getPageNumber();
                con.last();
                Integer totalPages = con.getPageNumber();
                con.setpageNumber(currPageNumber);
                return totalPages;
                }
            set;
	}

        public Boolean hasNext 
        {
        get 
        {
            return con.getHasNext();
        }
        set;
    }

    // indicates whether there are more records before the current page set.
    public Boolean hasPrevious {
        get {
            	return con.getHasPrevious();
        	}
        set;
    }

    // returns the page number of the current page set
    public Integer pageNumber {
        get 
        {
            return con.getPageNumber();
        }
        set;
    }
    public void first() 
    {
         con.first();
    }
     // returns the last page of records
     public void last() 
     {
         con.last();
     }

     // returns the previous page of records
     public void previous() 
     {
         con.previous();
     }

     // returns the next page of records
     public void next() 
     {
         con.next();
     }  
  // returns the PageReference of the original page, if known, or the home page.
     public void cancel() 
     {
         con.cancel();
     }
	public class CategoryWrapper 
	{
        public Boolean checked{ get; set;}
        public Contact cat { get; set;}

        public CategoryWrapper()
        {
            cat = new Contact();
            checked = false;
        }
        public CategoryWrapper(Contact c)
        {
            cat = c;
            checked = false;
        }
	}
}