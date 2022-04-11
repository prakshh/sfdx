import { LightningElement, wire } from 'lwc';
import getCarTypes from '@salesforce/apex/carSearchFormController.getCarTypes';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class CarSearchForm extends NavigationMixin(LightningElement) {
    carTypes;

    @wire(getCarTypes)  // wire, used to call the method
    wiredCarType({data, error}) {
        if(data) {
            this.carTypes = [{value:'', label:'All Types'}];
            data.forEach(element => {
                const carType = {};
                carType.label = element.Name;
                carType.value = element.Id;
                this.carTypes.push(carType);    // manipulating data and assigning new data to carTypes
            });
        } else if(error) {
            this.ShowToastEvent('ERROR', error.body.message, 'error');
        }
    }

    handleCarTypeChange(event) {
        const carTypeId = event.detail.value;

        const carTypeSeletionChangeEvent = new CustomEvent('carTypeId', {detail : carTypeId});
        this.dispatchEvent(carTypeSeletionChangeEvent);
    }

    createNewCarType() {
        this[NavigationMixin.Navigate]({
            type:'standard__objectPage',
            attributes:{
                objectApiName : 'Car_Type__c',
                actionName : 'new'
            }
        });
    }

    ShowToastEvent(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant,
        });
        this.dispatchEvent(evt);
    }
}