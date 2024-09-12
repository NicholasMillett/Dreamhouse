@RestResource(urlMapping='/Accounts/*')
global with sharing class AccountManager {
    @HttpGet
    global static AccountWrapper getAccountById() {
        RestRequest request = RestContext.request;

        // Extract the Account ID from the URL
        String accountId = request.requestURI.substring(request.requestURI.lastIndexOf('/') + 1);

        // Validate the Account ID
        if (String.isBlank(accountId)) {
            RestContext.response.statusCode = 400; // Bad request
            return null;
        }

        // Query the Account with related Contacts
        List<Account> accountList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts) 
                                     FROM Account 
                                     WHERE Id = :accountId 
                                     LIMIT 1];

        if (accountList.isEmpty()) {
            RestContext.response.statusCode = 404; // Not Found
            return null;
        }

        // Wrap the Account and Contacts into a custom response object
        Account result = accountList[0];
        AccountWrapper wrapper = new AccountWrapper();
        wrapper.accountId = result.Id;
        wrapper.accountName = result.Name;
        wrapper.contacts = new List<ContactWrapper>();

        // Loop through the contacts and add them to the wrapper
        for (Contact contact : result.Contacts) {
            ContactWrapper contactWrapper = new ContactWrapper();
            contactWrapper.contactId = contact.Id;
            contactWrapper.contactName = contact.Name;
            wrapper.contacts.add(contactWrapper);
        }

        return wrapper;
    }

    // Account Wrapper Class to format the response
    global class AccountWrapper {
        public String accountId;
        public String accountName;
        public List<ContactWrapper> contacts;
    }

    // Contact Wrapper Class for each related Contact
    global class ContactWrapper {
        public String contactId;
        public String contactName;
    }
}
