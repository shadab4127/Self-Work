trigger ContactDelete on Contact (after insert, after update, after delete) 
{
    OpportunityAmountClass handler = new OpportunityAmountClass();
    if (Trigger.isInsert) {
        handler.ConUpdate(Trigger.New);
        handler.ConToInsert(Trigger.New);
    }
    else if(Trigger.isUpdate) 
    {
        handler.ConUpdate(Trigger.Old);
        handler.ConToUpdate(Trigger.New,Trigger.Old);
    }
    else if (Trigger.isDelete) {
        handler.ConUpdate(Trigger.Old);
        handler.ConToDelete(Trigger.old);
    }
}