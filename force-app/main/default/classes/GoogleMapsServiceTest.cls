@isTest
private class GoogleMapsServiceTest {
    @isTest
    static void getPredictionsFor_Test() {
        Test.setMock(HttpCalloutMock.class, new GoogleMapsAutocompleteMock());

        String addressInput = '100 Harbour';

        List<GoogleMapsService.Prediction> predictions = new List<GoogleMapsService.Prediction>();

        Test.startTest();

        GoogleMapsService googleApi = new GoogleMapsService();
        predictions = googleApi.getPredictionsFor(addressInput);

        Test.stopTest();

        System.assertEquals(1, predictions.size(), 'Predictions Number Returned: ');
        System.assertEquals(
            'ChIJA36bM9U0K4gR2eLOdsDHlU8',
            predictions[0].place_id,
            'Place Ids Should Match: '
        );
    }
}
