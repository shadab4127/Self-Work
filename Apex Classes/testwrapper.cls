public class testwrapper {

   
Public List<Account> deleteList{get;set;}

public List<abc> accountwrapperList{get;set;}
Public testwrapper(){
    if(accountwrapperList == Null)
    {
          accountwrapperList = new List<abc>();
          for(Account a:[select id,name from account]) 
          {
          accountwrapperList.add(new abc(false,a));
          }
}}
 public PageReference deleter() {
       deleteList = new List<Account>();
       For (Abc act:accountwrapperList)
       {
           if(act.selected == true)
           {
           deleteList.add(act.acc);
       }
       
       }
       if(deleteList.size()>0)
       {
       delete deleteList;
       }
        return null;
    }
public class abc{
public Boolean Selected{get;set;}
Public Account acc{get;set;}

public abc(Boolean sel,Account acr){
    selected = sel;
    acc= acr;
}

}
}