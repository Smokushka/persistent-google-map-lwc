String origin = 'ChIJyS-TaGAtK4gRibCSIksLcC4';
String destination = 'ChIJA36bM9U0K4gR2eLOdsDHlU8';

GoogleMapsService googleApi = new GoogleMapsService();

GoogleMapsService.DistanceMatrix destinationMatrix = googleApi.getDistanceMatrixFor(
    origin,
    destination
);

System.debug('======= DESTINATION MATRIX: ' + destinationMatrix);
