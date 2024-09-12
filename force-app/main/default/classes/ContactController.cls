public class ContactController {
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts() {
        // Force an error to test error handling
        throw new AuraHandledException('This is a simulated error for testing purposes.');
        
    }
}
