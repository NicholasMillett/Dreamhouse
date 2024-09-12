@isTest
public class ParkServiceMock implements WebServiceMock {

    public void doInvoke(
        Object stub, 
        Object request, 
        Map<String, Object> response, 
        String endpoint, 
        String soapAction, 
        String requestName, 
        String responseNS, 
        String responseName, 
        String responseType) {

        // Create a mock response with park names
        ParkService.byCountryResponse mockResponse = new ParkService.byCountryResponse();
        mockResponse.return_x = new String[]{'Yellowstone', 'Yosemite'};

        // Put the mock response in the response map
        response.put('response_x', mockResponse);
    }
}
