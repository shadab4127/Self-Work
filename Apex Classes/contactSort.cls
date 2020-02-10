public class contactSort 
{

    public PageReference AllContacts() {
        return null;
    }


    public list<Contact> contList;
    public string sortDirection = 'ASC';
    public string sortExp='name';
    
    public string sortExpression
    {
        get{
            return sortExp;
        }
        set
        {
            if(value == sortExp)
            {
                sortDirection = (sortDirection == 'ASC') ? 'DESC' : 'ASC';
            }
            else
            {
                sortDirection = 'ASC';
            }
            sortExp = value;
        }
    }
    
    public String getsortDirection()
    {
        if(sortExpression == null || sortExpression == ' ')
        {
            return 'ASC';
        }
        else
        
        return sortDirection;
    }
    public void setsortDirection(String value)
    {
        sortDirection=value;
    }
    public List<Contact> getAllContacts() 
    {
        String sortFullExp =sortExpression  + ' ' +sortDirection;
        list<Contact> conList=Database.query('select Id,name,Phone,Email from contact order by '+ sortFullExp +' limit 200');
        return conList;
    }

}