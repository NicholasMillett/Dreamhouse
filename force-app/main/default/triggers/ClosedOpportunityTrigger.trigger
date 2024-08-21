trigger ClosedOpportunityTrigger on Opportunity (after insert,after update) {

    List<Task> tasksToInsert  = new List<Task>();

    for (Opportunity opp : Trigger.New) {
        if (opp.StageName == 'Closed Won') {
            tasksToInsert .add(new Task(
                Subject = 'Follow Up Test Task', 
                WhatId = opp.Id
                ));
        }
    }

    // Check if the user has permission to insert Tasks
    if (!tasksToInsert.isEmpty() && Schema.sObjectType.Task.isCreateable()) {
        try {
            insert tasksToInsert;
        } catch (DmlException e) {
            // Handle DML exceptions (e.g., log errors or send notifications)
            System.debug('Error inserting tasks: ' + e.getMessage());
        }
    } else if (!Schema.sObjectType.Task.isCreateable()) {
        System.debug('Current user does not have create permission on Task object.');
    }
}