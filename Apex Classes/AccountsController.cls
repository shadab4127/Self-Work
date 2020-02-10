public class AccountsController {
      @AuraEnabled
      public static List <Account> getAccounts() {
        return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone FROM Account ORDER BY createdDate ASC];
      }
    
     @AuraEnabled
    public static List <Account> getAccountsFiltered(String selectfield,String selectcondition,String Enteredvalue, Integer NoOfEmployees){
       //create list to fetch values based on conditions
        List<Account> myaccs=new List<Account>();
        //Dynamic query

        if(selectcondition=='Equals'){
            string query1='SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone FROM Account Where '+ selectfield +'='+'\''+Enteredvalue+'\'';
        Myaccs =Database.query(query1);
            }
        else if(selectcondition=='Not Equals'){
            string query2='SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone FROM Account Where '+ selectfield +'!='+'\''+Enteredvalue+'\'';
           Myaccs =Database.query(query2);

            }
        else if(selectcondition=='Contains'){
            string query3='SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone FROM Account Where '+ selectfield +' like'+'\'%'+Enteredvalue+'%\'' ;
            
            Myaccs =Database.query(query3);

            }
        
        return myaccs;
        
      }

  }