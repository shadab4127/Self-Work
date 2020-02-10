public class TriggerFactoryClass {
    map < Id, list < CampaignMember >> mapId = new map < Id, list < CampaignMember >> ();
    map < Id, Campaign > capId = new map < Id, Campaign > ();
    map < ID, Decimal > camId1 = new map < ID, Decimal > ();
    map < ID, Decimal > camId2 = new map < ID, Decimal > ();

    //------------------------------------------------------------------------------------------------------//
    // ------------------------------------------BEFORE INSERT AND UPDATE-----------------------------------//
    //------------------------------------------------------------------------------------------------------//

    public void bulkBeforeInsert(list < CampaignMember > cmm) {
        for (CampaignMember cm: cmm) {
            if (mapId.containsKey(cm.CampaignId)) {
                list < CampaignMember > c = mapId.get(cm.CampaignId);
                c.add(cm);
                mapId.put(cm.CampaignId, c);
                System.debug('Keys : '+mapId.keyset());
            } else {
                list < CampaignMember > c = new list < CampaignMember > ();
                c.add(cm);
                mapId.put(cm.CampaignId, c);
                System.debug('Keys : '+mapId.keyset());
            }
        }
        for (Campaign c1: [SELECT ID, Available_Seats__c, Total_Seats__c FROM Campaign WHERE ID IN: mapId.keySet()]) {
            camId1.put(c1.Id, c1.Available_Seats__c);
        }
        for (CampaignMember c2: cmm) {
            if (camId1.containsKey(c2.campaignId) && (c2.status == 'Responded' || c2.status == 'waiting' || c2.status == 'Invited') && camId1.get(c2.campaignId) > 0) {
                c2.Status = 'Invited';
                camId1.put(c2.CampaignId, camId1.get(c2.CampaignId) - 1);
            } else if (camId1.containsKey(c2.campaignId) && (c2.status == 'Responded' || c2.status == 'waiting' || c2.status == 'Invited') && camId1.get(c2.campaignId) == 0) {
                c2.Status = 'Waiting';
            }
        }
    }

    //------------------------------------------------------------------------------------------------------//
    //-----------------------------------------AFTER INSERT AND UPDATE--------------------------------------//
    //------------------------------------------------------------------------------------------------------//	

    public void bulkAfterInsert(list < CampaignMember > cmm) {
        for (CampaignMember cm: cmm) {
            if (mapId.containsKey(cm.CampaignId)) {
                list < CampaignMember > c = mapId.get(cm.CampaignId);
                c.add(cm);
                mapId.put(cm.CampaignId, c);
                //System.debug('Keys : '+mapId.keyset());
            } else {
                list < CampaignMember > c = new list < CampaignMember > ();
                c.add(cm);
                mapId.put(cm.CampaignId, c);
                // System.debug('Keys : '+mapId.keyset());
            }
        }
        for (Campaign c1: [SELECT ID, Available_Seats__c, Total_Seats__c FROM Campaign WHERE ID IN: mapId.keySet()]) {
            camId1.put(c1.Id, c1.Available_Seats__c);
        }
        for (CampaignMember c2: cmm) {
            if (camId1.containsKey(c2.campaignId) && c2.status == 'Invited' && camId1.get(c2.campaignId) > 0) {
                camId1.put(c2.CampaignId, camId1.get(c2.CampaignId) - 1);
            }
            for (Id keys: camId1.keySet()) {
                if (camId1.get(c2.campaignId) >= 0) {
                    Campaign listCam = new Campaign();
                    listCam.Id = keys;
                    listCam.Available_Seats__c = camId1.get(c2.CampaignId);
                    capId.put(listCam.Id, listCam);
                    System.debug('Keys2 : ' + keys);
                }
            }
        }
        update capId.values();
    }

    //------------------------------------------------------------------------------------------------------//
    //-----------------------------------------AFTER DELETE-------------------------------------------------//
    //------------------------------------------------------------------------------------------------------//

    public void bulkAfterDelete(list < CampaignMember > cmm) {
        map < Id, list < CampaignMember >> mapId = new map < Id, list < CampaignMember >> ();
        map < Id, Campaign > capId = new map < Id, Campaign > ();
        for (CampaignMember cm: cmm) {
            if (mapId.containsKey(cm.CampaignId)) {
                list < CampaignMember > c = mapId.get(cm.CampaignId);
                c.add(cm);
                mapId.put(cm.CampaignId, c);
            } else {
                list < CampaignMember > c = new list < CampaignMember > ();
                c.add(cm);
                mapId.put(cm.CampaignId, c);
            }
        }
        for (Campaign c1: [SELECT ID, Available_Seats__c, Total_Seats__c FROM Campaign WHERE ID IN: mapId.keySet()]) {
            camId1.put(c1.Id, c1.Available_Seats__c);
            camId2.put(c1.Id, c1.Total_Seats__c);
        }
        for (CampaignMember c2: cmm) {
          
            for (Id keys: mapId.keySet()) {
                if (camId1.get(c2.campaignId) <= camId2.get(c2.campaignId)) {
                    Campaign listCam = new Campaign();
                    listCam.Id = keys;
                    listCam.Available_Seats__c = camId1.get(c2.CampaignId);
                    capId.put(listCam.Id, listCam);
                    System.debug('Keys2 : ' + keys);
                }
            }
            update capId.values();
        }
    }

    //--------------------------------------------------------------------------------------------------//
    //----------------------------------------TRIGGER ON CAMPAIGN---------------------------------------//
    //--------------------------------------------------------------------------------------------------//
 
       public void CampaignUpdate(list < Campaign > cmm) {
        set < String > setId = new set < String > ();
        for (Campaign cm: cmm) {
            setId.add(cm.Id);
        }
        list < CampaignMember > camList = [SELECT Id FROM CampaignMember WHERE CampaignId IN: setId AND Status = 'Invited'];
        if (camList.size() > 0) {
            for (CampaignMember c1: camList) {
                for (Campaign c: cmm) {
                    c.Available_Seats__c = c.Total_Seats__c - camList.size();
                }
            }
        } else {
            for (Campaign c: cmm) {
                c.Available_Seats__c = c.Total_Seats__c - camList.size();
            }
        }
    }
}