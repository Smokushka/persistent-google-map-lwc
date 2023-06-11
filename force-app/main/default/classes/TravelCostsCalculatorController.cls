public with sharing class TravelCostsCalculatorController {
    private static final String GOOGLE_MAPS_ERROR = 'Google Maps API Error. Please Try Again';

    public TravelCostsCalculatorController() {
    }
    @AuraEnabled
    public static TripInformation getTripInformationFor(String origin, String destination) {
        try {
            TripInformation tripInformation = new TripInformation();

            GoogleMapsService googleApi = new GoogleMapsService();
            GoogleMapsService.DistanceMatrix distanceMatrix = googleApi.getDistanceMatrixFor(
                origin,
                destination
            );

            tripInformation.distance = distanceMatrix.distance;
            tripInformation.duration = distanceMatrix.duration;

            // tripInformation.cost.byCar = 5;
            // tripInformation.cost.byAirplane = 10;

            return tripInformation;
        } catch (Exception excep) {
            throw new AuraHandledException(GOOGLE_MAPS_ERROR);
        }
    }

    public class TripInformation {
        @AuraEnabled
        public GoogleMapsService.Distance distance;
        @AuraEnabled
        public GoogleMapsService.Duration duration;
        @AuraEnabled
        public Cost cost;
    }

    public class Cost {
        @AuraEnabled
        public Decimal byCar { get; set; }
        @AuraEnabled
        public Decimal byAirplane { get; set; }
    }
}
