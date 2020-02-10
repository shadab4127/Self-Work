public class DeleteAccount1 
{
	list<account> accId=[select Id,Name from Account order by CreatedDate desc limit 5];
   // list<account> accId=[select id from account where isDeleted = true LIMIT 4 ALL ROWS];
    public DeleteAccount1()
    {
      	delete accId;
        //System.debug('Account Name : '+accId.Name);
    }
}