public class ContactAndLeadSearch {
    public static List<List<sObject>> searchContactsAndLeads(String name) {
        // Perform a SOSL search on Contact and Lead objects using the provided name
        List<List<sObject>> searchResults = [
            FIND :name IN Name FIELDS
            RETURNING Contact(Id, FirstName, LastName), Lead(Id, FirstName, LastName)
        ];
        
        // Return the list of results
        return searchResults;
    }
}