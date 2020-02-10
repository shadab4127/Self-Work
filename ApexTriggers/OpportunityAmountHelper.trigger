trigger OpportunityAmountHelper on Opportunity(after insert, after update, after Delete, after unDelete) {
    OpportunityAmountClass handler = new OpportunityAmountClass();
    
    if (Trigger.isInsert || Trigger.isUpdate) {
        handler.bulkUpsert(Trigger.New);
    } else if (Trigger.isDelete) {
        handler.bulkDelete(Trigger.Old);
    }
}