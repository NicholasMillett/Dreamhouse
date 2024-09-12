public class AccountProcessor {

    @future
    public static void countContacts(List<Id> accountIds) {
        // Create a map to hold the count of contacts for each account
        Map<Id, Integer> contactCountMap = new Map<Id, Integer>();

        // Aggregate the number of contacts for each account
        List<AggregateResult> results = [
            SELECT AccountId, COUNT(Id) totalContacts
            FROM Contact
            WHERE AccountId IN :accountIds
            GROUP BY AccountId
        ];

        // Populate the map with the contact counts
        for (AggregateResult ar : results) {
            contactCountMap.put((Id)ar.get('AccountId'), (Integer)ar.get('totalContacts'));
        }

        // Update each account with the number of contacts
        List<Account> accountsToUpdate = new List<Account>();
        for (Id accId : accountIds) {
            Integer contactCount = contactCountMap.get(accId);
            if (contactCount != null) {
                accountsToUpdate.add(new Account(Id = accId, Number_Of_Contacts__c = contactCount));
            } else {
                accountsToUpdate.add(new Account(Id = accId, Number_Of_Contacts__c = 0));
            }
        }

        // Perform the update
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;
        }
    }
}
