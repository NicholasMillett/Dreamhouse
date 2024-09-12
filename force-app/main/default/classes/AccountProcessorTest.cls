/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an org are executed whenever Apex code is deployed
 * to a production org to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production org. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the org size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
public class AccountProcessorTest {

    @isTest
    static void testCountContacts() {
        // Create a test account with a valid 8-character AccountNumber
        Account testAccount1 = new Account(
            Name = 'Test Account 1',
            AccountNumber = '12345678' // 8 characters long
        );
        insert testAccount1;

        // Create contacts associated with the test account
        List<Contact> contacts = new List<Contact>();
        contacts.add(new Contact(FirstName = 'Test', LastName = 'Contact 1', AccountId = testAccount1.Id));
        contacts.add(new Contact(FirstName = 'Test', LastName = 'Contact 2', AccountId = testAccount1.Id));
        insert contacts;

        // Create another test account with no contacts and a valid 8-character AccountNumber
        Account testAccount2 = new Account(
            Name = 'Test Account 2',
            AccountNumber = '87654321' // 8 characters long
        );
        insert testAccount2;

        // Call the future method
        Test.startTest();
        AccountProcessor.countContacts(new List<Id>{testAccount1.Id, testAccount2.Id});
        Test.stopTest();

        // Retrieve the accounts to verify the number of contacts was updated
        Account updatedAccount1 = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :testAccount1.Id];
        Account updatedAccount2 = [SELECT Number_Of_Contacts__c FROM Account WHERE Id = :testAccount2.Id];

        // Assert the values
        System.assertEquals(2, updatedAccount1.Number_Of_Contacts__c, 'The number of contacts for Account 1 should be 2');
        System.assertEquals(0, updatedAccount2.Number_Of_Contacts__c, 'The number of contacts for Account 2 should be 0');
    }
}
