trigger MapCampaignMember on CampaignMember(before insert, before update, before delete, after insert, after update, after delete) {
    list < Campaign > lstCam = new list < Campaign > ();
    map < Id, list < CampaignMember >> mapId = new map < Id, list < CampaignMember >> ();
     map<Id,Campaign> capId=new map<Id,Campaign>();
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate) {
            for (CampaignMember cm: Trigger.New) {
                if (mapId.containskey(cm.campaignId)) {
                    list < CampaignMember > listcmp = mapid.get(cm.campaignId);
                    listcmp.add(cm);
                    mapId.put(cm.campaignId, listcmp);
                } else {
                    list < CampaignMember > listcm = new list < CampaignMember > ();
                    listcm.add(cm);
                    mapId.put(cm.campaignId, listcm);
                }
            }
            
            map < Id, Decimal > camId = new map < Id, Decimal > ();
            for (Campaign c: [SELECT Id, Available_Seats__c FROM Campaign WHERE Id IN: mapId.keySet()]) {
                camId.put(c.Id, c.Available_Seats__c);
            }
            
            for (CampaignMember cmm: Trigger.New) 
            {
                if (camId.containsKey(cmm.CampaignId) && cmm.Status == 'Responded' && camId.get(cmm.CampaignId) > 0) 
                {
                    cmm.Status = 'Invited';
                    camId.put(cmm.CampaignId,camId.get(cmm.CampaignId)-1);
                } 
                else if (camId.containsKey(cmm.CampaignId) && cmm.Status == 'Waiting' && camId.get(cmm.CampaignId) > 0) 
                {
                    cmm.Status = 'Invited';
                    camId.put(cmm.CampaignId,camId.get(cmm.CampaignId)-1);
                } 
                else if (camId.containsKey(cmm.CampaignId) && cmm.Status == 'Responded' && camId.get(cmm.CampaignId) == 0) 
                {
                    cmm.Status = 'Waiting';
                }
                for(Id listId:camId.keySet())
                {
                    campaign c=new campaign();
                    c.Id =cmm.CampaignId;
                    c.Available_Seats__c=camId.get(cmm.CampaignId);
                    capId.put(c.Id,c);
                }
            }
        }
    }
    update capId.values();
}