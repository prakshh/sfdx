/*
 Whenever a Contact's description is updated, then it's parent Account's description should also get updated by it
*/
trigger TestTrigger4 on Contact (after Update) {		// after - as we need to make changes in related record
    
    Set<Id> accIds = new Set<Id>();
    if(trigger.isAfter && trigger.isUpdate) {
        if(!trigger.new.isEmpty()) {
            for(Contact con : trigger.new) {
                //now, we need to fetch parent Account ID of the contact on which description is being updated by user
                //will fetch using SoQL as below
                //after fetching, we will store it in Set as above
                
                //will fetch only if contact's account Id is not null and if old value of contact's description is not equal to new value of contact's description
                if(con.AccountId != null && trigger.oldMap.get(con.Id).Description != con.Description) {
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    
    if(!accIds.isEmpty()) {
        //fetch AccountIds using SoQL as below
        Map<Id,Account> accMap = new map<Id,Account>([SELECT Id, Description FROM Account WHERE Id IN: accIds]);	// we have used map here because using Map makes it is easy to avoid SoQL query inside For Loop
        List<Account> listToUpdateAccounts = new List<Account>();
        if(!trigger.new.isEmpty()) {
            for(Contact cont : trigger.new) {
                Account acc = accMap.get(cont.AccountId);
                acc.Description = cont.Description;
                listToUpdateAccounts.add(acc);		// Bulkifying - add the accounts into a list, and then perform DML on list        
            }
        }
        
        if(!listToUpdateAccounts.isEmpty()) {
            update listToUpdateAccounts;
        }
    }
    
}