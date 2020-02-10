@isTest
private class TriggerFactoryClassTest 
{
    @isTest static void myTest1()
    {  
        list<Lead> leadIds=new list<Lead>();
        lead l1=new lead(lastName='Lead1',Company='Grazitti');
        leadIds.add(l1);
        lead l2=new lead(lastName='Lead2',Company='Grazitti');
        leadIds.add(l2);
        lead l3=new lead(lastName='Lead3',Company='Grazitti');
        leadIds.add(l3);
        lead l4=new lead(lastName='Lead4',Company='Grazitti');
        leadIds.add(l4);
        insert LeadIds;
        
        list<Campaign> cam=new list<Campaign>();
        Campaign c=new Campaign(Name='Salesforce one');
        c.Available_Seats__c=1;
        c.Total_Seats__c=1;
        cam.add(c);
        insert cam;
        
        list<CampaignMember> cmm=new list<CampaignMember>();
        CampaignMember c1=new CampaignMember(CampaignId =c.Id,LeadId=l1.Id,Status='Responded');
        CampaignMember c2=new CampaignMember(CampaignId =c.Id,LeadId=l2.Id,Status='Waiting');
        CampaignMember c3=new CampaignMember(CampaignId =c.Id,LeadId=l3.Id,Status='Responded');
        CampaignMember c4=new CampaignMember(CampaignId =c.Id,LeadId=l4.Id,Status='Waiting');
        cmm.add(c1);
        cmm.add(c2);

        Test.startTest();
        insert cmm;
        Test.stopTest();
        
        TriggerFactoryClass handler=new TriggerFactoryClass();
        handler.bulkBeforeInsert(cmm);
        handler.bulkAfterInsert(cmm);
        handler.bulkAfterDelete(cmm);
        handler.CampaignUpdate(cam);
     
        cmm=[Select Id from CampaignMember];
        delete cmm;      
     }     
}