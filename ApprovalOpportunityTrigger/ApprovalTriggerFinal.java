trigger ApprovalTrigger on Opportunity(before update) {
 list < object > predicateList = new list < object > ();
 set < string > fields = new set < string > ();
 List < TriggerHelper.FilterDetail > filterWrapper = new List < TriggerHelper.FilterDetail > ();
     
    for (Apttus_Approval_ApprovalRule__c app: [SELECT Name, Apttus_Approval_Criteria__c FROM Apttus_Approval_ApprovalRule__c]) {
          object obj = json.deserializeUntyped(app.Apttus_Approval_Criteria__c);
          map < string, object > map1 = (map < string, object > ) obj;
          map < string, object > map2 = (map < string, object > ) map1.get('filter');
          predicateList = (List < object > ) map2.get('predicates');
          TriggerHelper.FilterDetail f = new TriggerHelper.FilterDetail();
          string critConExpr = string.valueof(map2.get('condExpr'));
          f.predicate = predicateList;
          f.expression = critConExpr;
          filterWrapper.add(f);
     }
    
     for (object o: predicateList) {
          Map < string, object > map3 = (map < string, object > ) o;
          fields.add(string.valueof(map3.get('FieldName')));
     }
    
     for (Opportunity op: trigger.new) {
          Opportunity oldOpp = Trigger.oldMap.get(op.Id);
          Opportunity newOpp = Trigger.newMap.get(op.Id);
              for (string flds: fields) {
                   if ((oldOpp.get(flds) != newOpp.get(flds)) && oldOpp.Approval_Status__c != 'Not Submitted') {
                    Opportunity op2 = TriggerHelper.checkCriteria(op, filterWrapper);
                   }
              }
     }
}