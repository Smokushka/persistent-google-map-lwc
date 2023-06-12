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
        if (this.isValid) {
            this.tripInformation = undefined;
            this.isTripInfoPlaceholderVisible = false;
            this.isTripInfoSpinnerVisible = true;
    
            getTripInformationFor({ origin : this.origin, destination : this.destination }).then(result => {
                this.tripInformation = result;
                this.isTripInfoSpinnerVisible = false;
            });
        }
    }

    handleNewSearchClick() {
        this.tripInformation = null;
        this.origin = null;
        this.destination = null;
        this.isTripInfoPlaceholderVisible = true;
        this.isTripInfoSpinnerVisible = false;
        this.template.querySelector('.destination-address-picker').clear();
        this.template.querySelector('.origin-address-picker').clear();
    }

    handleDestinationAddressSelect(event) {
        this.destination = event.detail;
    }

    handleOriginAddressSelect(event) {
        this.origin = event.detail;
    }

    get isValid() {
        const destinationIsValid = this.template.querySelector('.destination-address-picker').validate();
        const originIsValid = this.template.querySelector('.origin-address-picker').validate();

        if (destinationIsValid && originIsValid) {
            return true;
        }

        return false;
    }

}