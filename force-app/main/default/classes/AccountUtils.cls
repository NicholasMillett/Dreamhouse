public class AccountUtils {

    public static List<Account> accountsByState(String stateAbbreviation) {
        // Check if the state abbreviation is null or empty
        if (String.isBlank(stateAbbreviation)) {
            // Return an empty list if the state abbreviation is null or empty
            return new List<Account>();
        }

        // Query to fetch accounts where BillingState matches the provided state abbreviation
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            WHERE BillingState = :stateAbbreviation
        ];

        return accounts;
    }
}