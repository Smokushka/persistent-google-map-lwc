String origin = 'place_id:ChIJyS-TaGAtK4gRibCSIksLcC4';
String destination = 'place_id:ChIJA36bM9U0K4gR2eLOdsDHlU8';

GoogleMapsService googleApi = new GoogleMapsService();

GoogleMapsService.DistanceMatrix destinationMatrix = googleApi.getDistanceMatrix(
    origin,
    destination
);

System.debug('======= DESTINATION MATRIX: ' + destinationMatrix);
