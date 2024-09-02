public class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        // Force an error to test error handling
        throw new AuraHandledException('This is a simulated error for testing purposes.');
        
        // Normal query that would be used in production
        // return [SELECT FirstName, LastName, Email FROM Contact LIMIT 100];
    }
}
