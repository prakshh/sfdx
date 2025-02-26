trigger T03_UpdateChildByParent_AccPhone_To_ConPhone on Account (after update) {
    
    Map<Id,Account> accMap = new Map<Id,Account>();
    
    if(trigger.isAfter && trigger.isUpdate) {
        if(!trigger.new.isEmpty()) {
            for(Account acc: trigger.new) {
                if(trigger.oldMap.get(acc.Id).Phone != acc.Phone) {
                    accMap.put(acc.Id, acc);		// Here, we captured the IDs of those accounts whose Phone field has been updated
                }
            }
        }
    }
    
    // Now, we need to fetch the related contacts of those accounts whose Phone field has been updated using accMap
    
    List<Contact> conList = [SELECT Id, AccountId, Phone FROM Contact WHERE AccountId IN : accMap.keySet()];
    // ultimate aim is : con.Phone = acc.Phone
    List<Contact> listToUpdateContacts = new List<Contact>();
    
    if(!conList.isEmpty()) {
        for(Contact con: conList) {
            Account acc = accMap.get(con.AccountId);
            con.Phone = acc.Phone;
            // Now, we need to update Contacts, but using DML (update operation) inside for loop is not a best practice
            // So, use a new List to add the Contacts, and update the list separately
            listToUpdateContacts.add(con);
        }
    }
    
    if(!listToUpdateContacts.isEmpty()) {
        update listToUpdateContacts;
    }

}



/*

03-Update Child by Parent

isAfter, old, oldMap

isAfter - returns true if this trigger was fired After any record was saved
old - returns a list of old versions of sObject records
       - only available in update and delete triggers 
oldMap - returns a map of old versions of sObject records
             - only available in update and delete triggers 

*/