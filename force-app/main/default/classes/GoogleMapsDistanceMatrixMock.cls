@isTest
global class GoogleMapsDistanceMatrixMock implements HttpCalloutMock {
    global HTTPResponse respond(HTTPRequest req) {
        // Create a fake response
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(
            '{"destination_addresses" : [ "100 Harbour St, Toronto, ON M5J 0B5, Canada" ],"origin_addresses" : [ "Avonshire Condominiums, Toronto, ON M2N, Canada" ],"rows" : [{"elements" : [{"distance" : {"text" : "25.2 km","value" : 25233},"duration" : {"text" : "24 mins","value" : 1447},"status" : "OK"}]}],"status" : "OK"}'
        );
        res.setStatusCode(200);
        return res;
    }
}
