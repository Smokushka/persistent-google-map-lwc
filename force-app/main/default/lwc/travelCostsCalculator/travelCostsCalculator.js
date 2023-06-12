import { LightningElement } from 'lwc';
import getPredictionsFor from '@salesforce/apex/AddressPickerController.getPredictionsFor';
import getTripInformationFor from '@salesforce/apex/TravelCostsCalculatorController.getTripInformationFor';

export default class TravelCostsCalculator extends LightningElement {
    predictions;
    predictionsMap;

    searchKey;
    selectedPlaceId;

    tripInformation;
    isTripInfoPlaceholderVisible = true;
    isTripRoutePlaceholderVisible = true;
    isTripInfoSpinnerVisible = false;

    destination = '100 Harbour Street';
    destinationKey = 'ChIJA36bM9U0K4gR2eLOdsDHlU8';

    handleChange(event) {
        this.searchKey = event.detail.value;
        console.log( 'searchKey is', this.searchKey );

        getPredictionsFor( { addressInput : this.searchKey } ).then(result => {

            if (this.searchKey == null || this.searchKey == undefined || this.searchKey == '') {
                this.predictions = undefined;
            } else {
                console.log( 'result is', JSON.stringify( result ) );
    
                let tempPredictions = [];
                this.predictionsMap = new Map();
                    result.forEach( ( record ) => {
                        this.predictionsMap.set(record.place_id,record.description);
                        let tempRec = Object.assign( {}, record );      
                        tempRec.description = tempRec.description.replace( new RegExp( this.searchKey, 'i' ),( value ) => `<b>${value}</b>` );                    
                        tempPredictions.push( tempRec );
                        
                    });
                    this.predictions = tempPredictions;                
            }

        });
    }

    handleSelect(event) {
        let strIndex = event.currentTarget.dataset.id;
        console.log( 'strIndex is', strIndex );
        console.log(this.predictionsMap);
        this.searchKey = this.predictionsMap.get(strIndex);
        this.selectedPlaceId = strIndex;
        console.log(this.searchKey);
        this.predictions = null;
    }

    handleGetDirectionsClick() {
        this.isTripInfoPlaceholderVisible = false;
        this.isTripInfoSpinnerVisible = true;
        const origin = this.selectedPlaceId;
        const destination = this.destinationKey;

        getTripInformationFor({ origin : origin, destination : destination }).then(result => {
            console.log(result);
            this.tripInformation = result;
            this.isTripInfoSpinnerVisible = false;
        });


    }
}