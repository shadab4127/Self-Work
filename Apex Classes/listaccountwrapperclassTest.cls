@isTest
private class listaccountwrapperclassTest 
{
@isTest static void testMethod1()
{
    List<Account> AccList=new List<Account>();
    List<Contact> conList=new List<Contact>();
    List<Opportunity> oppList=new List<Opportunity>();
    List<Case> caseList=new List<Case>();
    	Account a=new Account(Name='Shadab Alam');
    	Acclist.add(a);
    	insert Acclist;
    	Contact c=new Contact(lastName='Alam');
    	conList.add(c);
    	insert conList;
    	//opportunity op=new opportunity(Name='opport',StageName='Closed Won',CloseDate=Today());
    	//opplist.add(op);
    	//insert opplist;
    	case cs=new case(Status='Working',Origin='Email');
    	caseList.add(cs);
    	insert caseList;
    	 Account a1;
    	 list<contact> c1;
    	 list<Opportunity> op1;
    	 list<Case> cs1;
    	listaccountwrapperclass.abc wrap=new listaccountwrapperclass.abc(a1,c1,op1,cs1);
    	listaccountwrapperclass listWrapper=new listaccountwrapperclass();
}
}