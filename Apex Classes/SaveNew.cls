public class SaveNew 
{   Account a;
    public SaveNew(ApexPages.StandardSetController controller)
    {
        Account a=new Account();
    }
    public Account getAcc()
    {
        return a;
    }
    public PageReference SaveAndNew()
    {
    insert a;
    PageReference pageRef = new PageReference('https://c.ap15.visual.force.com/apex/AccountPage?core.apexpages.request.devconsole=1');
    return pageRef;
    }
}