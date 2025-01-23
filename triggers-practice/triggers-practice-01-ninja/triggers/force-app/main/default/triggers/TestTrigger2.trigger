/*
 * Scenario 2: When an Account record is inserted or updated, 
 * then the account billing address should automatically populate into account shipping address
*/
trigger TestTrigger2 on Account (before insert, before update) {
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        if(!trigger.new.isEmpty()) {
            for(Account acc : trigger.new) {
                if(acc.BillingStreet != null) {
                    acc.ShippingStreet = acc.BillingStreet;
                }
                if(acc.BillingCity != null) {
                    acc.ShippingCity = acc.BillingCity;
                }
                if(acc.BillingState != null) {
                    acc.ShippingState = acc.BillingState;
                }
                if(acc.BillingPostalCode != null) {
                    acc.ShippingPostalCode = acc.BillingPostalCode;
                }
                if(acc.BillingCountry != null) {
                    acc.ShippingCountry = acc.BillingCountry;
                }
            }
        }
    }

}


/*
  2. Trigger Context Variables with Scenario
    
    isBefore, isInsert, isUpdate, new
    
    isBefore - returns true if this trigger was fired Before any record was saved
    isInsert - returns true if this trigger was fired due to an Insert operation
    isUpdate - returns true if this trigger was fired due to an Update operation
    new - returns a list of new version of sObject records,
        - means, if your trigger is on Account object, then it will return list of Account records
    - if you are using before insert and before update, then it will return records that are being inserted or updated AND it holds the new value of records
    - also, trigger.new is available ONLY in insert, update and undelete operations
    (it is not possible to have a new version of record after deletion of it)

*/