trigger beforeEvents on Contact (before insert,before update, before delete) 
{
    if(Trigger.isInsert)
    {
        list<Contact> conList=new list<Contact>();
        list<String> setId=new list<string>();
        for(Contact c:Trigger.new)
        {
           setId.add(c.Id);
        }
        for(Contact co:[select Id,lastName from Contact where Id=:setId])
        {
                co.lastName='Alam';
                conList.add(co);
        }
        update conList;
    }
    
}