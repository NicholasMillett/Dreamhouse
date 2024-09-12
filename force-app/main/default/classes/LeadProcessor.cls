public class LeadProcessor implements Database.Batchable<SObject> {

    // Start method to collect all Lead records in the org
    public Database.QueryLocator start(Database.BatchableContext batchableContext) {
        // Query all Leads in the org
        return Database.getQueryLocator('SELECT Id FROM Lead');
    }

    // Execute method to update LeadSource for each batch of Lead records
    public void execute(Database.BatchableContext batchableContext, List<Lead> scope) {
        for (Lead l : scope) {
            l.LeadSource = 'Dreamforce';
        }
        // Update the leads in the database
        update scope;
    }

    // Finish method (optional) to perform any cleanup or post-processing
    public void finish(Database.BatchableContext batchableContext) {
        // Any post-batch operations can be handled here (e.g., sending notifications)
    }
}
