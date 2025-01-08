import { LightningElement } from 'lwc';
import getHighRevenueAccountRecordsUsingImperativeCall from '@salesforce/apex/AccountController.getHighRevenueAccountRecordsUsingImperativeCall';

export default class HighRevenueAccountUsingImperative extends LightningElement {
    accountsToDisplay = [];
    countOfRecords = 5;

    connectedCallback() {
        getHighRevenueAccountRecordsUsingImperativeCall( {count: this.countOfRecords} ).then(response => {
            console.log('Response using imperativeapproach', response);
            this.accountsToDisplay = response;
        }).catch(error => {
            console.error('Error', error);
        })
    }
}