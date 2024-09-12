public class AddPrimaryContact implements Queueable {
    
    private Contact contact;
    private String stateAbbreviation;

    // Constructor that accepts a Contact sObject and a state abbreviation
    public AddPrimaryContact(Contact contact, String stateAbbreviation) {
        this.contact = contact;
        this.stateAbbreviation = stateAbbreviation;
    }

    // The execute method for the Queueable job
    public void execute(QueueableContext context) {
        // Query up to 200 Accounts with the specified BillingState
        List<Account> accounts = [
            SELECT Id 
            FROM Account 
            WHERE BillingState = :stateAbbreviation 
            LIMIT 200
        ];
        
        // List to hold the contacts to insert
        List<Contact> contactsToInsert = new List<Contact>();
        
        // Loop through the accounts and create a Contact for each
        for (Account account : accounts) {
            // Clone the contact and set the AccountId
            Contact newContact = contact.clone(false, false, false, false);
            newContact.AccountId = account.Id;
            contactsToInsert.add(newContact);
        }
        
        // Insert the contacts
        if (!contactsToInsert.isEmpty()) {
            insert contactsToInsert;
        }
    }
}
