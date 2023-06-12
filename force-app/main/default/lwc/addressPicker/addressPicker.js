import { LightningElement,api } from 'lwc';
import getPredictionsFor from '@salesforce/apex/AddressPickerController.getPredictionsFor';


export default class AddressPicker extends LightningElement {
    @api label;

    predictions;
    predictionsMap;

    searchKey;
    selectedPlaceId;

    handleChange(event) {
        this.searchKey = event.detail.value;

        getPredictionsFor( { addressInput : this.searchKey } ).then(result => {

            if (this.searchKey == null || this.searchKey == undefined || this.searchKey == '') {
                this.predictions = undefined;
            } else {
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
        this.searchKey = this.predictionsMap.get(strIndex);
        this.selectedPlaceId = strIndex;
        this.predictions = null;

        const addressSelectEvent = new CustomEvent('addressselect', { detail : this.selectedPlaceId});

        this.dispatchEvent(addressSelectEvent);
    }

    @api
    clear() {
        this.searchKey = null;
    }

    @api
    validate() {
        var addressInput = this.template.querySelector('.address-input');
        addressInput.reportValidity();
        return addressInput.validity.valid;
       
    }

}