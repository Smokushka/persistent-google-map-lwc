public with sharing class GoogleMapsService {
    private String URL = 'callout:Google_Maps';

    private final String AUTOCOMPLETE_PATH = '/maps/api/place/autocomplete/json';
    private final String KEY = 'key';
    private final String INPUT = 'input';
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

    public List<String> getPredictionsFor(String addressInput) {
        List<String> predictions = new List<String>();

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

        System.debug('=====GOOGLE MAPS API RESPONSE: ' + res);
        System.debug('=====RESPONSE BODY:' + res.getBody());

        return predictions;
    }
}
