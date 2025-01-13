import { api, LightningElement } from 'lwc';

export default class ApiDecoratorExampleChildComponent extends LightningElement {
    @api childProperty1;
    @api childProperty2;
}