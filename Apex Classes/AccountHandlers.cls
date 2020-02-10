public class AccountHandlers {
 @AuraEnabled
    public static List<Account> getAllAccount(){
        return [SELECT Id,Name,Phone FROM Account order by CreatedDate desc limit 5];
    }
    
    @AuraEnabled
    public static String delAccount(String[] lstAccountId){
        string msg='';
        List<Account> lstAcc=[SELECT Id FROM Account WHERE Id IN: lstAccountId];
        try{
            if(lstAcc.size()>0)
                delete lstAcc;
        }
        catch(Exception ex){
            msg=ex.getMessage()+'\n'+ex.getLineNumber()+'\n'+ex.getCause();
        }
        return msg;
    }
 }