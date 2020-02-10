public class ExampleApex {
    @AuraEnabled
public static list<Contact> getRelatedList(Id recordId)
{
        
List<Contact> Conlist = [Select id,firstname,lastname from Contact where AccountId =: recordId ];
return Conlist;
}
    
@AuraEnabled
public static void updateRelatedList(List<Contact> Conlist)
     {
          if(Conlist!= null && Conlist.size()>0)
          {
               update Conlist;
          }
         } 
}