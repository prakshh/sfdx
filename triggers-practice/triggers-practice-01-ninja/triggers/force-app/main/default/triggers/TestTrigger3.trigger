/*
 Scenario 3: Whenever Account’s Phone field is updated, 
			then all related Contact’s Phone field should also get updated with Parent Account’s Phone

    03-Update Child by Parent
    
    isAfter, old, oldMap
    
    isAfter - returns true if this trigger was fired After any record was saved
    old - returns a list of old versions of sObject records
           - only available in update and delete triggers 
    oldMap - returns a map of old versions of sObject records
                 - only available in update and delete triggers 

*/
trigger TestTrigger3 on Account (after Update) {
    
    // putting AccountId inside Map which will be used to update the child record (Contact's Phone) value
    // This map will have the value of those Account records on which Phone field is being updated by user
    Map<Id,Account> accMap = new Map<Id,Account>();	
    
    if(trigger.isAfter && trigger.isUpdate) {
        if(!trigger.new.isEmpty()) {
            for(Account acc : trigger.new) {
                if(trigger.oldMap.get(acc.Id).Phone != acc.Phone) { 	// comparing Account record's old Phone value with Account records's new Phone value
                    accMap.put(acc.Id,acc);
                }
            }
        }
    }
    
    // Fetch all the contacts related to the Account on which the user is updating the Phone field
    List<Contact> conList = [SELECT Id, AccountId, Phone from Contact where AccountId IN: accMap.keySet()];	// here, keySet() method will return all account records present in map (accMap)
    List<Contact> listToUpdateContacts = new List<Contact>();
    if(!conList.isEmpty()) {
        for(Contact con : conList) {
            con.Phone = accMap.get(con.AccountId).Phone;
            // now, as you can see, contact's Phone is being assigned value of Account's Phone with help of Account map
            // next step is to Update the assigned values in contact's Phone
            // Update can be done using DML operation, but it is not a best practice to use DML operation insid For Loop
            // Solution: add these contacts into a list, and then perform the DML operation on that List
            // This is called Bulkifying the code
            listToUpdateContacts.add(con);
        }
    }
    
    if(!listToUpdateContacts.isEmpty()) {
        update listToUpdateContacts;
    }

}