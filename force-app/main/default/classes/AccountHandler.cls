public class AccountHandler {
    public static Account insertNewAccount(String accountName) {
        // Check if the account name is not empty
        if (String.isBlank(accountName)) {
            // If the account name is empty, return null
            return null;
        }

        // Create a new Account record
        Account newAccount = new Account(Name = accountName);

        try {
            // Try to insert the Account
            insert newAccount;
        } catch (DmlException e) {
            // If insertion fails, return null
            return null;
        }

        // Return the inserted account record
        return newAccount;
    }
}