trigger AccountTrigger on Account (before insert) {
    // Check if the trigger is before insert
    if (Trigger.isBefore && Trigger.isInsert) {
        // Call the handler method to process the records
        AccountTriggerHandler.CreateAccounts(Trigger.New);
    }
}