import { LightningElement, wire } from 'lwc';
import getHighRevenueAccountRecords from '@salesforce/apex/AccountController.getHighRevenueAccountRecords';

export default class HighRevenueAccount extends LightningElement {
    accountsToDisplay = [];

    @wire(getHighRevenueAccountRecords)
    getAccountsHandler(response) {
        // {error: ..., data: ...}
        // case 1:- {error: undefined, data: ...}
        // case 1:- {error: ..., data: undefined}
        const {data, error} = response;     // destructuring (data = response.data; error = response.error;)
        if(error) {
            console.error(error);
            return;
        }
        if(data) {
            this.accountsToDisplay = data;
        }
        
    }
}

/*

Decorators in LWC
    @api:
        Exposes properties and methods to parent components, making them publicly accessible.

    @track:
        Makes object or array properties reactive, ensuring UI updates when their values change.

    @wire:
        Connects LWC components to backend data sources like Apex methods or Salesforce data.
        wire decorator implementation

Key points about Decorators:

        - @track does not make properties private or inaccessible — it controls reactivity. 
        - Properties and methods in LWC are inherently private unless exposed using @api.
        - @wire is explicitly used for connecting to backend services like Apex methods or Salesforce data, not just for display purposes.


Key Points About Reactivity in LWC:
        - Primitive properties are reactive by default.
        - Complex properties (objects/arrays) require explicit notification of changes (e.g., using @track or reassignment).
        - Reactivity enables LWC to efficiently update only the parts of the DOM affected by changes, improving performance.


Reactivity 

    - it refers to the ability of a system or framework to automatically update the UI whenever the underlying data changes. 
    - In context of LWC, reactivity ensures that when a property's value changes, the corresponding parts of the DOM are updated without requiring explicit DOM manipulation.

    How Reactivity Works in LWC:

        Reactive Properties:

            - By default, LWC monitors changes to primitive types like string, number, and boolean. When these properties change, the framework automatically re-renders the affected parts of the UI.
            - For non-primitive types (e.g., objects, arrays), you need to notify the framework explicitly about changes, unless you use a reactive pattern or decorators like @track.


to do

    1. LWC 
        -> highRevenueAccounts
            -> import 
                -> wire from lwc
                -> apex method from @salesforce/apex
            -> within LWC
                -> @wire(methodName, {param1: value1})
                -> here, param is not needed if apex method has no parameter
                -> @wire(methodName)
                    property
                        -> this property (variable) will be assigned with a value that is returned in the apex method
                -> @wire(methodName)
                    handler
                        -> this handler (method) will be handling the response that we will get after the apex method call
                -> best practice is to use handler (method) so that we can catch any possible error

    2. Apex 
        -> AccountController 
            -> getHighRevenueAccountRecords

    3. Lightning Component Tab

*/