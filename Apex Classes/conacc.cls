public with sharing class conacc {

  
    public List<MyWrapper> wrapper {get; set;}

  public List<Account> accLst1 {get; set;}

    public List<Contact> conLst1 {get; set;}

    public conacc ()

    {
    
      accLst1 = [select id,Name from Account  ] ;


       conLst1 = [select Id,Name from contact where AccountId IN : accLst1 ] ;

      

        wrapper = new List<MyWrapper>() ;
       for(Integer i=0 ; i < 20; i++)

            wrapper.add(new MyWrapper(  conLst1, accLst1[i])) ;

    System.debug('----------'+ wrapper);
       

    }

public class MyWrapper

    {

        public Account accRec1 {get; set;}

        public List<Contact> conRec1 {get; set;}

        

        public MyWrapper( List<Contact> con ,Account acc )

        {

            accRec1 = acc ;

            conRec1 = con ;

        }

}


}