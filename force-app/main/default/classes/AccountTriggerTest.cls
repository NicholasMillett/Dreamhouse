@IsTest
public class AccountTriggerTest {

    @IsTest
    static void testShippingStateEqualsBillingState() {
        // List to hold the accounts for bulk insert
        List<Account> accountsToInsert = new List<Account>();

        for (Integer i = 0; i < 200; i++) {
            // Generate a unique account number by adding a fixed base value to the loop index
            Integer baseValue = 10000000;  // Start at a base value of 10000000 to ensure the number is 8 digits
            Integer uniqueAccountNumberInt = baseValue + i;  // Ensure uniqueness by incrementing the base value
            String uniqueAccountNumber = String.valueOf(uniqueAccountNumberInt);

            Account acc = new Account(
                Name = 'Test Account ' + i, 
                BillingState = 'CA',
                AccountNumber = uniqueAccountNumber
            );
            accountsToInsert.add(acc);
        }
        System.debug(accountsToInsert);
        // Insert the accounts
        insert accountsToInsert;

        // Query the inserted accounts to verify ShippingState
        List<Account> insertedAccounts = [SELECT Id, BillingState, ShippingState, AccountNumber FROM Account WHERE BillingState = 'CA'];

        // Assert that all accounts have ShippingState = 'CA' and AccountNumber is 8 digits long
        for (Account acc : insertedAccounts) {
            System.assertEquals('CA', acc.ShippingState, 'ShippingState should be equal to BillingState');
            System.assertEquals(8, acc.AccountNumber.length(), 'AccountNumber should be 8 characters long');
        }
    }
}
