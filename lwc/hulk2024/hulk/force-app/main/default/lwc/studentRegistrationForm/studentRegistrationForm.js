import { LightningElement, track } from 'lwc';

export default class StudentRegistrationForm extends LightningElement {    
    // primitive properties
    firstName = '';
    lastName = '';
    email = '';

    // non-primitive properties
    studentData = {};

    @track
    reactiveStudentData = {};

    handleFirstNameChange(event) {
        //this.firstName = event.target.value;
        //this.studentData.firstName = event.target.value;
            /*This doesn't display the input values because 2 conditions are met here
                1. non-tracked properties
                2. trying to access to nested properties within the array 
            */
        this.reactiveStudentData.firstName = event.target.value;
    }
    handleLastNameChange(event) {
        //this.lastName = event.target.value;
        //this.studentData.lastName = event.target.value;
        this.reactiveStudentData.lastName = event.target.value;
    }
    handleEmailChange(event) {
        //this.email = event.target.value;
        //this.studentData.email = event.target.value;
        this.reactiveStudentData.email = event.target.value;
    }
        
}

/*

The @track decorator in Lightning Web Components (LWC) makes a JavaScript property reactive. It ensures that changes to the property's value are tracked by the framework, and the component re-renders automatically when the property changes.

Key Points:

Used for private properties that require reactive updates in the component's UI.
No longer necessary for simple objects and arrays since LWC tracks their changes automatically (post Winter '21 release).

import { LightningElement, track } from 'lwc';

export default class TrackExample extends LightningElement {
    @track itemList = [{ id: 1, name: 'Item 1' }];

    addItem() {
        this.itemList.push({ id: 2, name: 'Item 2' }); // UI updates automatically
    }
}

--

But track decorator is needed for non-primitive types like object and array, right?

You're partially correct, but Salesforce updated the behavior of reactivity in Lightning Web Components. Let me clarify:

Starting from Winter '21 release, you no longer need the @track decorator for arrays and objects if you're directly mutating the property reference (i.e., reassigning the object or array). LWC now tracks reactivity for all properties of an object or array by default.

However, if you are updating nested properties within an object or array, reactivity is not automatically detected unless the property is decorated with @track.

-- 

Details on Reactivity in LWC:

1. Without @track: Direct mutations to the top-level reference of an array or object will trigger re-renders.
Example:

export default class Example extends LightningElement {
    itemList = [{ id: 1, name: 'Item 1' }];
    
    addItem() {
        this.itemList = [...this.itemList, { id: 2, name: 'Item 2' }]; // UI updates
    }
}

2. With @track: If you need to track changes to nested properties of objects within the array, you should use @track.
Example:

import { LightningElement, track } from 'lwc';

export default class Example extends LightningElement {
    @track itemList = [{ id: 1, name: 'Item 1' }];

    updateItem() {
        this.itemList[0].name = 'Updated Item'; // UI updates because of @track
    }
}

--

Key Takeaway:

Use @track only when dealing with nested property changes within objects or arrays.
For top-level changes, @track is not needed because LWC now tracks those automatically.

*/