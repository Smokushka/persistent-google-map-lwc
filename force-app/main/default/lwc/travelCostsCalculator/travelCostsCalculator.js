import { LightningElement } from 'lwc';
import getPredictionsFor from '@salesforce/apex/AddressPickerController.getPredictionsFor';

export default class TravelCostsCalculator extends LightningElement {
    predictions;

    searchKey;

    handleChange(event) {
        this.searchKey = event.detail.value;
        console.log( 'searchKey is', this.searchKey );

        getPredictionsFor( { addressInput : this.searchKey } ).then(result => {
            console.log( 'result is', JSON.stringify( result ) );

            let tempPredictions = [];
                result.forEach( ( record ) => {

                    let tempRec = Object.assign( {}, record );      
                    tempRec.description = tempRec.description.replace( new RegExp( this.searchKey, 'i' ),( value ) => `<b>${value}</b>` );                    
                    tempPredictions.push( tempRec );
                    
                });
                this.predictions = tempPredictions;
        });
    }

    handleSelect(event) {
        let strIndex = event.currentTarget.dataset.id;
        console.log( 'strIndex is', strIndex );
    }
}