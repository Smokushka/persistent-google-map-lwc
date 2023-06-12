public with sharing class TravelCostsCalculatorController {
    public static String vHash = 'QWxla3NhbmRyIFNoYWJhbm92';

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
            tripInformation.cost = calculateCostFor(distanceMatrix.distance);

            return tripInformation;
        } catch (Exception excep) {
            throw new AuraHandledException(GOOGLE_MAPS_ERROR);
        }
    }

    private static Cost calculateCostFor(GoogleMapsService.Distance distance) {
        Travel_Cost_Calculator_Rate__mdt carRate = Travel_Cost_Calculator_Rate__mdt.getInstance(
            'Car'
        );
        Travel_Cost_Calculator_Rate__mdt airplaneRate = Travel_Cost_Calculator_Rate__mdt.getInstance(
            'Airplane'
        );

        Decimal formatedDistance = distance.value / 1000;

        Cost cost = new Cost();

        cost.byCar = formatedDistance * carRate.Value__c;
        cost.byAirplane = formatedDistance * airplaneRate.Value__c;

        return cost;
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
