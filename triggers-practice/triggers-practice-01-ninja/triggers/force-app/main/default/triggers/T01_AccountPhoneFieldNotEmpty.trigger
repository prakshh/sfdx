/*
 * Trigger Sceneraio
 * 1. While inserting an account, if a user left the phone field empty, then an error should come stating 'You cannot insert account with phone field empty'.
*/ 
trigger T01_AccountPhoneFieldNotEmpty on Account (before insert) {
    if(trigger.isBefore && trigger.isInsert) {
        if(!trigger.new.isEmpty()) {
            for(Account acc: trigger.new) {
                if(acc.Phone == null) {
                    acc.Phone.addError('Account Phone should not be left null');
                }
            }
        }
    }

}



/*

-ninja 

1. intro

Apex trigger
when to use
types
before vs after trigger
when to use before and after trigger
best practices
syntax

1. what is Apex trigger?
- piece of code that executed before or after DML operations like insert, update, delete, undelete, upsert, merge
- enables to perform action before or after changes to Salesforce records such as insert, update, delete

2. when should we use triggers?
- when we want to perform operations like 
	1) modifying any records or related records
	2) restricting certain operations
- when point-n-click tools cannot solve the complex requirements

3. types of triggers
- before trigger and after trigger
- before trigger
	- executes before the record gets saved to database
	- used to update/validate record values before they get saved to database
- after trigger
	- executes after the record gets saved to database
	- used to affect changes in other records like updating child record,
	  and to access system-generated fields, like Id, CreatedDate

4. when to use before and after trigger?
- before trigger
	- used when user wants to update same record before saving
	- to validate record values before saving
- after trigger
	- used to affect changes in other (related) records
	- used when we need to access field values generated by system, such as Id, LastModifiedDate

5.  Best practices for writing triggers?
- i. One trigger per object
		- because in case of multiple triggers for 1 object, we do not have control which trigger will execute at first
- ii. Logic less trigger
		- we should avoid writing logic on trigger,
		because logic written inside trigger, cannot be exposed to other class, therefore, it decreases code re-usability and we won't be able to write test classes properly.
		- always try to have a trigger handler class to write trigger logic.  
- iii. Avoid calling Batch from Trigger
		- high chances to hit governor limit if we call batch from trigger
- iv. Avoid using DML and SOQL inside For loop 
		- to avoid governor limit
- v. Avoid hard-coding Ids\
		- because values can change, so it should be stored in variables, custom label or custom settings


6. syntax
- Trigger triggerName on objectName(Trigger Events) {
	// write your code here
}



*/