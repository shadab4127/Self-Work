trigger TriggerOnCampaign on Campaign(before insert, before Update) 
{
    TriggerFactoryClass handler=new TriggerFactoryClass();
    if(Trigger.isInsert)
    {
        handler.CampaignUpdate(Trigger.new);
    }
     else if(Trigger.isUpdate)
    {
        handler.CampaignUpdate(Trigger.new);
    }
    
}