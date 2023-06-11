GoogleMapsService googleApi = new GoogleMapsService();

List<GoogleMapsService.Prediction> predictions = googleApi.getPredictionsFor('100 Harbour Street');
System.debug(predictions);
