public class ParkLocator {

    // Method to get park names by country
    public static String[] country(String country) {
        // Initialize the ParkService class
        ParkService.ParksImplPort service = new ParkService.ParksImplPort();

        // Call the byCountry method to get parks
        String[] parks = service.byCountry(country);

        // Return the park names as an array
        return parks != null ? parks : new String[0];
    }
}
