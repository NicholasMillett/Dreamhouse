public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        // Query to find contacts with matching last name and postal code
        List<Contact> contacts = [
            SELECT Id, Name
            FROM Contact
            WHERE LastName = :lastName
            AND MailingPostalCode = :postalCode
        ];
        
        // Return the list of contacts
        return contacts;
    }
}