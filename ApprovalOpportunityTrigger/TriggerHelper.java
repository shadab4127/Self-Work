public class TriggerHelper {
    public static Opportunity checkCriteria(Opportunity op, List < TriggerHelper.FilterDetail > filter) {
     
     for (TriggerHelper.FilterDetail filt: filter) {
      string exp = filt.expression;
      for (object o: filt.predicate) {
       Map < string, object > map3 = (map < string, object > ) o;
       string critFieldValue = string.valueof(map3.get('FieldValue'));
       string critFieldName = string.valueof(map3.get('FieldName'));
       string fieldType = string.valueof(map3.get('FieldType'));
       string compopr = string.valueof(map3.get('CompOper'));
       string rowno = string.valueof(map3.get('RowNum'));
       if (fieldType == 'PICKLIST') {
        string value = string.valueOf(op.get(critFieldName));
        if (compopr == 'equal to') {
             if (value.equalsIgnoreCase(critFieldValue)) {  
              exp = exp.replace(rowno, 'true');
             } else {
              exp = exp.replace(rowno, 'false');
             }
        }
        else if (compopr == 'greater than') {
         if ( value > critFieldValue ) {  
          exp = exp.replace(rowno, 'true');
         } else {
          exp = exp.replace(rowno, 'false');
         }
        }
       }
      }
      if (BooleanExpressionCalculation.evaluateExpression(exp)) {
       op.Approval_Status__c = 'Not Submitted';
      }
     }
     return null;
    }
    public class FilterDetail {
     public list < object > predicate;
     public String expression;
    }
   }