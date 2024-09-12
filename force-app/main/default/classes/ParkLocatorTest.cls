@isTest
public class ParkLocatorTest {

    @isTest
    static void testCountryMethod() {
        // Set up the mock response
        Test.setMock(WebServiceMock.class, new ParkServiceMock());

        // Call the method and verify the response
        String[] parks = ParkLocator.country('United States');
        System.assertEquals(2, parks.size(), 'Two parks should be returned');
        System.assertEquals('Yellowstone', parks[0], 'First park should be Yellowstone');
        System.assertEquals('Yosemite', parks[1], 'Second park should be Yosemite');
    }
}
