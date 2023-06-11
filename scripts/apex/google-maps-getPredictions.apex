GoogleMapsService googleApi = new GoogleMapsService();

List<GoogleMapsService.Prediction> predictions = googleApi.getPredictionsFor('100 Harrison Garden');
System.debug(predictions);
