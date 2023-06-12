@isTest
global class GoogleMapsAutocompleteMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(
            '{"predictions" : [{"description" : "100 Harbour Street, Toronto, ON, Canada","place_id" : "ChIJA36bM9U0K4gR2eLOdsDHlU8","reference" : "ChIJA36bM9U0K4gR2eLOdsDHlU8"}], "status" : "OK"}'
        );
        res.setStatusCode(200);
        return res;
    }
}
