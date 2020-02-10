trigger TriggerHandlerHelper on CampaignMember(before insert, after Insert, before update, after update, before delete, after Delete) {
    TriggerFactoryClass handler = new TriggerFactoryClass();
    if (Trigger.isBefore) {
        if (Trigger.isInsert || Trigger.isUpdate)
            handler.bulkBeforeInsert(Trigger.New);
       
    } else if (Trigger.isAfter) {
        if (Trigger.isInsert || Trigger.isUpdate)
            handler.bulkAfterInsert(Trigger.New);
        else if (Trigger.isDelete)
            handler.bulkAfterDelete(Trigger.old);
    }
}