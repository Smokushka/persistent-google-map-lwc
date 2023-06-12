import { LightningElement } from 'lwc';
import getTripInformationFor from '@salesforce/apex/TravelCostsCalculatorController.getTripInformationFor';

export default class TravelCostsCalculator extends LightningElement {

    tripInformation;
    isTripInfoPlaceholderVisible = true;
    isTripRoutePlaceholderVisible = true;
    isTripInfoSpinnerVisible = false;

    origin;
    destination;


    handleGetDirectionsClick() {
        this.tripInformation = undefined;
        this.isTripInfoPlaceholderVisible = false;
        this.isTripInfoSpinnerVisible = true;

        getTripInformationFor({ origin : this.origin, destination : this.destination }).then(result => {
            console.log(result);
            this.tripInformation = result;
            this.isTripInfoSpinnerVisible = false;
        });


    }

    handleDestinationAddressSelect(event) {
        this.destination = event.detail;
    }
    handleOriginAddressSelect(event) {
        this.origin = event.detail;
    }
}