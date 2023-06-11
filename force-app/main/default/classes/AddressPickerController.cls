public with sharing class AddressPickerController {
    private static final String GOOGLE_MAPS_ERROR = 'Google Maps API Error. Please Try Again';

    public AddressPickerController() {
    }
    @AuraEnabled
    public static List<GoogleMapsService.Prediction> getPredictionsFor(String addressInput) {
        try {
            GoogleMapsService googleApi = new GoogleMapsService();

            return googleApi.getPredictionsFor(addressInput);
        } catch (Exception excep) {
            throw new AuraHandledException(GOOGLE_MAPS_ERROR);
        }
    }
}
