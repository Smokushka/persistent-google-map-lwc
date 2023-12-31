public with sharing class GoogleMapsService {
    private String URL = 'callout:Google_Maps';

    private final String AUTOCOMPLETE_PATH = '/maps/api/place/autocomplete/json';
    private final String KEY = 'key';
    private final String INPUT = 'input';

    private final String DISTANCE_MATRIX_PATH = '/maps/api/distancematrix/json';
    private final String ORIGINS = 'origins';
    private final String DESTINATIONS = 'destinations';
    private final String PREFIX = 'place_id:';

    private String API_KEY {
        get {
            External_Service_API_Key__mdt googleMapsPersistentKey = External_Service_API_Key__mdt.getInstance(
                'Google_Maps_Persistent'
            );
            return googleMapsPersistentKey.Value__c;
        }
    }

    public GoogleMapsService() {
    }

    public List<Prediction> getPredictionsFor(String addressInput) {
        List<Prediction> predictions = new List<Prediction>();

        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(
            this.URL +
                this.AUTOCOMPLETE_PATH +
                '?' +
                this.KEY +
                '=' +
                this.API_KEY +
                '&' +
                this.INPUT +
                '=' +
                EncodingUtil.urlEncode(addressInput, 'UTF-8')
        );
        request.setMethod('GET');

        HttpResponse res = http.send(request);

        if (res.getStatusCode() == 200) {
            Predictions body = (Predictions) JSON.deserialize(res.getBody(), Predictions.class);
            predictions = body.predictions;
        } else {
        }

        return predictions;
    }

    public DistanceMatrix getDistanceMatrixFor(String origin, String destination) {
        DistanceMatrix distanceMatrix = new DistanceMatrix();

        Http http = new Http();

        HttpRequest request = new HttpRequest();
        request.setEndpoint(
            this.URL +
                this.DISTANCE_MATRIX_PATH +
                '?' +
                this.KEY +
                '=' +
                this.API_KEY +
                '&' +
                this.ORIGINS +
                '=' +
                EncodingUtil.urlEncode((this.PREFIX + origin), 'UTF-8') +
                '&' +
                this.DESTINATIONS +
                '=' +
                EncodingUtil.urlEncode((this.PREFIX + destination), 'UTF-8')
        );
        request.setMethod('GET');

        HttpResponse res = http.send(request);

        if (res.getStatusCode() == 200) {
            DistanceMatrixWrapper body = (DistanceMatrixWrapper) JSON.deserialize(
                res.getBody(),
                DistanceMatrixWrapper.class
            );
            distanceMatrix = body.rows[0].elements[0];
        } else {
        }

        return distanceMatrix;
    }
    public class Predictions {
        public List<Prediction> predictions;
        public String status;
    }

    public class Prediction {
        @AuraEnabled
        public String description { get; set; }
        @AuraEnabled
        public String place_id { get; set; }
        @AuraEnabled
        public String reference { get; set; }
    }

    public class DistanceMatrixWrapper {
        public List<String> destination_addresses;
        public List<String> origin_addresses;
        public List<Row> rows;
        public String status;
    }

    public class Row {
        public List<DistanceMatrix> elements;
    }

    public class DistanceMatrix {
        @AuraEnabled
        public Distance distance;
        @AuraEnabled
        public Duration duration;
        @AuraEnabled
        public String status;
    }

    public class Distance {
        @AuraEnabled
        public String text;
        @AuraEnabled
        public Decimal value;
    }

    public class Duration {
        @AuraEnabled
        public String text;
        @AuraEnabled
        public Decimal value;
    }
}
