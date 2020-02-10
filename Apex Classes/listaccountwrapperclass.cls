public class listaccountwrapperclass {
    
    public list<abc> listacc{get;set;}
    public list<account> listact{get;set;}
    public id params;
    public listaccountwrapperclass()
    {
        params = ApexPages.currentPage().getParameters().get('id');
        listacc= new List<abc>();
        listact=[select name,type,Rating,(select Name from opportunities),(select firstname from contacts),(select status from cases) from account where id =:params];
        for(Account a:listact) 
        {
            
            listacc.add(new abc(a,a.contacts,a.opportunities,a.cases));  
        }
        }
        
        
        public class abc{
            
            public account acct{get;set;}
            public list<contact> listcon{get;set;}
            public list<opportunity> listopp{get;set;}
            public list<case> listcas{get;set;}
            
            public abc(account acct1,list<contact> listcons,list<opportunity> listopps,list<case> listcass){
                acct=acct1;
                listcon=listcons;
                listopp=listopps;
                listcas=listcass;
            }  
        }
    }