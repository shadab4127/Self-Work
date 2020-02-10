trigger CampaignMemberTrigger on CampaignMember(after insert, After update, after delete) {
    list < Lead > leadList = new list < Lead > ();
    map<Id, list<CampaignMember>> mapId=new map<Id, list<CampaignMember>>();
    if (Trigger.isInsert || Trigger.isUpdate) {   
        
        for (CampaignMember cm: Trigger.New) {
            if(mapId.containsKey(cm.LeadId))
            {
                list<CampaignMember> c=mapId.get(cm.LeadId);
                c.add(cm);
                mapId.put(cm.LeadId,c);
            }
            else
            {
                list<CampaignMember> c=new list<CampaignMember>();
                c.add(cm);
                mapId.put(cm.LeadId,c);
            }
        }
    }
    else if (Trigger.isDelete) {
         
        for (CampaignMember cm: Trigger.old) {
            if(mapId.containsKey(cm.LeadId))
            {
                list<CampaignMember> c=mapId.get(cm.LeadId);
                c.add(cm);
                mapId.put(cm.LeadId,c);
            }
            else
            {
                list<CampaignMember> c=new list<CampaignMember>();
                c.add(cm);
                mapId.put(cm.LeadId,c);
            }
        }
    }
        
    for (Lead l: [select id, Name, Campaign_Type__c, (select LeadId, CampaignId,Status, Campaign.Name from CampaignMembers) from Lead where Id IN:mapId.keySet()]) {
            string Names = '';
            set<String> setStr=new set<String>();
            for (CampaignMember cmp: l.CampaignMembers) {
                
                system.debug('$$$$$$$$$$$' + cmp.Campaign.Name);
                    
                if (cmp.Campaign.Name.contains('Excel') && cmp.Status =='Invited')
                    setStr.add('Excel');
                else if (cmp.Campaign.Name.contains('Microsoft') && cmp.Status =='Invited')
                    setStr.add('Microsoft');
                else if (cmp.Campaign.Name.contains('Salesforce') && cmp.Status =='Invited')
                    setStr.add('Salesforce');
                else if (cmp.Campaign.Name.contains('Tableav') && cmp.Status =='Invited')
                    setStr.add('Tableav');
                
                System.debug('Names ' + setStr);   
            }
            for(String str:setStr)
            {
                Names+=str+';';
            }
            l.Campaign_Type__c = names;
            leadList.add(l);
        }
    update leadList;
}