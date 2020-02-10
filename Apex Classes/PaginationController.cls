public class PaginationController 
{


    public integer totalRec=0;
    public integer OffsetSize=0;
    public integer LimitSize=10;
    public list<Account> acc;
    public list<Account> getAllAccounts()
    {
        list<Account> acc=[Select Name,Phone,Type,AccountNumber from Account LIMIT:LimitSize OFFSET:OffsetSize];
        return acc;
    }

    public PaginationController() 
    {
                totalRec=[select Count() from Account];
    }  
     public void first() 
    {
         OffsetSize=0;
        System.debug('??????????FIRST'+OffsetSize);
    } 
    public void Previous() 
    {
        OffsetSize=OffsetSize-LimitSize;
        System.debug('??????????PREVIOUS'+OffsetSize);
    }
    public void Next() 
    {
        OffsetSize=OffsetSize+LimitSize;
        System.debug('??????????Next'+OffsetSize);
    }
     public void last() 
     {
       OffsetSize=totalRec-math.mod(totalRec,LimitSize);
         System.debug('??????????lAST'+OffsetSize);
     }
    public boolean getPrev()
    {
        if(OffsetSize == 0)
            return true;
        else
            return false;
    }
    public boolean getNxt()
    {
        if(OffsetSize+LimitSize > totalRec)
            return true;
        else
            return false;
    }
   

}