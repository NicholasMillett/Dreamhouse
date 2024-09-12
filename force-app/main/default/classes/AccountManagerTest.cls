@isTest
private class AccountManagerTest {

    @isTest
    static void testGetAccountWithContacts() {
        // Create a test account and contacts
        Account testAccount = new Account(Name = 'Test Account', AccountNumber = '12345678');
        insert testAccount;

        List<Contact> contactList = new List<Contact>{
            new Contact(FirstName = 'John', LastName = 'Doe', AccountId = testAccount.Id),
            new Contact(FirstName = 'Jane', LastName = 'Smith', AccountId = testAccount.Id)
        };
        insert contactList;

        // Mock the HTTP request and response
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Accounts/' + testAccount.Id + '/contacts';
        RestContext.request = req;
        RestContext.response = res;

        // Call the method
        AccountManager.AccountWrapper result = AccountManager.getAccountById();

        // Assert the results
        System.assertEquals(testAccount.Id, result.accountId, 'Account ID should match');
        System.assertEquals('Test Account', result.accountName, 'Account name should match');
        System.assertEquals(2, result.contacts.size(), 'There should be 2 contacts');
    }

    @isTest
    static void testAccountNotFound() {
        // Mock HTTP request for a non-existent account
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/Accounts/001NonExistentAccountId/contacts';
        RestContext.request = req;
        RestContext.response = res;

        // Call the method
        AccountManager.AccountWrapper result = AccountManager.getAccountById();

        // Assert the result is null and response status is 404
        System.assertEquals(null, result);
        System.assertEquals(404, RestContext.response.statusCode);
    }
}
