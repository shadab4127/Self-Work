public with sharing class FieldExplorerController {
    @Auraenabled(cacheable=true)
    public static List<string> getObjects()
    {
        List<string> sObjectList = new List<string>();
        
        for(Schema.SObjectType objTyp : Schema.getGlobalDescribe().Values()){
            system.debug('objTyp-->'+objTyp);
            String name = objTyp.getDescribe().getName();
            system.debug('name-->'+name);
            if((!name.containsignorecase('history') && !name.containsignorecase('tag')&&
                !name.containsignorecase('share') && !name.containsignorecase('feed')) || 
               name.toLowerCase().right(3) ==  '__c'){      
                   sObjectList.add(name);
               }
        }
        system.debug('size:'+sObjectList.size());
        system.debug('sObjectList:'+sObjectList);
        return sObjectList;
    }
   
    @Auraenabled(cacheable=true)
    public static List<wrapperClass> getFields(sObject objInfo, string picklistFieldApi)
    {
         // Describe the SObject using its object type.
        Schema.DescribeSObjectResult objDescribe = objInfo.getSObjectType().getDescribe();
        // Get a map of fields for the SObject
        map < String, Schema.SObjectField > fieldMap = objDescribe.fields.getMap();
 
        // Get the list of picklist values for this field.
        list < Schema.PicklistEntry > values = fieldMap.get(picklistFieldApi).getDescribe().getPickListValues();
 
        // Create a list of wrapper to store picklist value/lable
        list < wrapperClass > objWrapper = new list < wrapperClass > ();
 
        for (Schema.PicklistEntry a: values) {
            wrapperClass oFatchValueWrapper = new wrapperClass();
            oFatchValueWrapper.slabel = a.getLabel();
            oFatchValueWrapper.svalue = a.getValue();
            objWrapper.add(oFatchValueWrapper);
        }
        return objWrapper;
    }
    
    public class wrapperClass
    {
        @Auraenabled
        public string Name{get;set;}
        @Auraenabled
        public string Label{get;set;}
        @auraEnabled public string slabel {get;set;}
        @auraEnabled public string svalue {get;set;}
    }
}