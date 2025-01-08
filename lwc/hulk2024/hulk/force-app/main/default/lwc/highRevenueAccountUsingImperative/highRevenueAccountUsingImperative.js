import { LightningElement } from 'lwc';
import getHighRevenueAccountRecordsUsingImperativeCall from '@salesforce/apex/AccountController.getHighRevenueAccountRecordsUsingImperativeCall';

export default class HighRevenueAccountUsingImperative extends LightningElement {
    accountsToDisplay = [];
    countOfRecords = 5;     // here, 5 is assigned a s default value of number of items to be displayed. But, in case of imperative call, whatever input value will be entered, that number of items will be displayed

    connectedCallback() {
        getHighRevenueAccountRecordsUsingImperativeCall( {count: this.countOfRecords} ).then(response => {
            console.log('Response using imperativeapproach', response);
            this.accountsToDisplay = response;
        }).catch(error => {
            console.error('Error', error);
        })
    }

    setCount(event) {
        console.log('Value', event.target.value);
        let inputValue = event.target.value;
        if(inputValue == '') return;
        this.countOfRecords = inputValue;
        getHighRevenueAccountRecordsUsingImperativeCall( {count: this.countOfRecords} ).then(response => {
            console.log('Response using imperative approach', response);
            this.accountsToDisplay = response;
        }).catch(error => {
            console.error('Error', error);
        })
    }
}