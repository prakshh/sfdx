import { api, LightningElement } from 'lwc';

export default class ApiDecoratorExampleChildComponent extends LightningElement {
    @api childProperty1;
    @api childProperty2;

    // calling child from parent
    @api callChildMethod() {
        console.log('Child mehod got called');
        this.childProperty2 = '';
    }
}