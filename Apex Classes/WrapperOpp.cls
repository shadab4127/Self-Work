public class WrapperOpp {

   public List<OppWrapper> Opplist = new List<OppWrapper>();
   public String SelectedValue {get;set;}

    public List<SelectOption> Accs {get{
        List<SelectOption> AccName = new List<SelectOption>();
        for(Account a :[Select Id, name from Account limit 10])
        {
            AccName.add(new SelectOption(a.name,a.name));
        }
        return AccName;
      }
     }
     public PageReference refresh()
     {
       Opplist .clear();
       for(Account a :[Select id,name,(Select name from opportunities) from Account where name =:SelectedValue])
       {
         for (opportunity opp :a.opportunities)
         Opplist.add(new OppWrapper(false,opp));
       }
     return null;
     }

     public List<OppWrapper> getOppList()
     {
        System.debug('count'+Opplist.size());
        return Opplist;}

     public class OppWrapper{
    public Boolean selected{get;set;}
    public Opportunity opp{get;set;}
    public OppWrapper(Boolean selected1, Opportunity opp1)
    {
        selected = selected1;
        opp = opp1;
    }

}
}