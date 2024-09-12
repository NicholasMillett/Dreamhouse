@isTest
public class AddPrimaryContactTest {

    @isTest
    static void testAddPrimaryContactForCA() {
        // Insert 50 Accounts for NY with valid 8-character AccountNumber
        List<Account> nyAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            nyAccounts.add(new Account(Name = 'NY Account ' + i, BillingState = 'NY', AccountNumber = '000000NY'));
        }
        insert nyAccounts;
        
        // Insert 50 Accounts for CA with valid 8-character AccountNumber
        List<Account> caAccounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            caAccounts.add(new Account(Name = 'CA Account ' + i, BillingState = 'CA', AccountNumber = '000000CA'));
        }
        insert caAccounts;

        // Create a Contact to be cloned
        Contact contact = new Contact(FirstName = 'Primary', LastName = 'Contact', Email = 'primary@example.com');

        // Instantiate the AddPrimaryContact class and enqueue the job for CA
        Test.startTest();
        AddPrimaryContact job = new AddPrimaryContact(contact, 'CA');
        System.enqueueJob(job);
        Test.stopTest();
        
        // Verify that 50 contacts were inserted for the CA Accounts
        List<Contact> insertedContacts = [SELECT Id, AccountId FROM Contact WHERE Email = 'primary@example.com'];
        System.assertEquals(50, insertedContacts.size(), '50 Contacts should have been inserted for CA Accounts');
        
        // Verify that all inserted contacts are associated with CA accounts
        for (Contact insertedContact : insertedContacts) {
            Account acc = [SELECT BillingState FROM Account WHERE Id = :insertedContact.AccountId];
            System.assertEquals('CA', acc.BillingState, 'The inserted contact should be associated with a CA Account');
        }
    }
}
