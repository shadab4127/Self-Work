@isTest

private class CampaignMemberTriggerTest 
{
     @isTest static void Test1()
        {   list<Lead> ld=new list<Lead>();
            list<Campaign> cmp=new list<Campaign>();
            Campaign Cam=new Campaign(Name='Graz Microsoft');
            Lead l=new lead(lastName='ABC', Company='Grazitti');
            ld.add(l);
            insert ld;
            cmp.add(Cam);
            insert cmp;
            list<CampaignMember> listCam=new list<CampaignMember>();  
            CampaignMember cm1=new CampaignMember(LeadId=l.Id,CampaignId=cam.id,Status='sent');
            listCam.add(cm1);
            Test.startTest();
            insert listCam;
            CampaignMember c=[Select Id from CampaignMember];
            delete c;
            Test.stopTest();
        }
    @isTest static void Test2()
        {    list<Lead> ld=new list<Lead>();
            list<Campaign> cmp=new list<Campaign>();
            Campaign Cam=new Campaign(Name='Graz Excel');
            Lead l=new lead(lastName='ABC', Company='Grazitti');
            ld.add(l);
            insert ld;
            cmp.add(Cam);
            insert cmp;
            list<CampaignMember> listCam=new list<CampaignMember>();  
            CampaignMember cm1=new CampaignMember(LeadId=l.Id,CampaignId=cam.id,Status='sent');
            listCam.add(cm1);
            Test.startTest();
            insert listCam;
            Test.stopTest();
        }
    @isTest static void Test3()
        {    
            list<Lead> ld=new list<Lead>();
            list<Campaign> cmp=new list<Campaign>();
            Campaign Cam=new Campaign(Name='Graz Tableav');
            Lead l=new lead(lastName='ABC', Company='Grazitti');
            ld.add(l);
            insert ld;
            cmp.add(Cam);
            insert cmp;
            list<CampaignMember> listCam=new list<CampaignMember>();  
            CampaignMember cm1=new CampaignMember(LeadId=l.Id,CampaignId=cam.id,Status='sent');
            listCam.add(cm1);
            Test.startTest();
            insert listCam;
            Test.stopTest();
        }
    @isTest static void Test4()
        {    
            list<Lead> ld=new list<Lead>();
            list<Campaign> cmp=new list<Campaign>();
            Campaign Cam=new Campaign(Name='Graz Salesforce');
            Lead l=new lead(lastName='ABC', Company='Grazitti');
            ld.add(l);
            insert ld;
            cmp.add(Cam);
            insert cmp;
            list<CampaignMember> listCam=new list<CampaignMember>();  
            CampaignMember cm1=new CampaignMember(LeadId=l.Id,CampaignId=cam.id,Status='sent');
            listCam.add(cm1);
            Test.startTest();
            insert listCam;
            Test.stopTest();
        }
}