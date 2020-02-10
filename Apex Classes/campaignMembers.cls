public class campaignMembers 
{
    List<CampaignMember> cms = new List<CampaignMember>();
	public campaignMembers()
    {
       

        CampaignMember cm1 = new CampaignMember();
        cm1.LeadId = '00Q2v00001XkcPt';
        cm1.CampaignId = '7012v0000020qSf';
        cm1.Status = 'Send';
        cms.add(cm1);
        
        CampaignMember cm2 = new CampaignMember();
        cm2.LeadId = '00Q2v00001XkcPe';
        cm2.CampaignId = '7012v0000020qSa';
        cm2.Status = 'Send';
        cms.add(cm2);
        CampaignMember cm3 = new CampaignMember();
        cm3.LeadId = '00Q2v00001XkcPZ';
        cm3.CampaignId = '7012v0000020qSk';
        cm3.Status = 'Send';
        cms.add(cm3);
        insert cms;
    }
}