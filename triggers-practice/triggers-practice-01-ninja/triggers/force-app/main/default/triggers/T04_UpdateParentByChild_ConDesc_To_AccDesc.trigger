/*
 04-Update Parent by Child - trigger Scenario - 4

 Whenever a Contact's description is updated, then it's parent Account's description should also get updated by it
*/


trigger T04_UpdateParentByChild_ConDesc_To_AccDesc on Contact (after update) {
    
    Set<Id> accIds = new Set<Id>();
    
    if(trigger.isAfter && trigger.isUpdate) {
        if(!trigger.new.isEmpty()) {
            for(Contact con: trigger.new) {
                if(con.AccountId != null && trigger.oldMap.get(con.Id).Description != con.Description) {
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    
    Map<Id,Account> accMap = new Map<Id,Account>([SELECT Id, Description FROM Account WHERE Id IN: accIds]);
    List<Account> listToUpdateAccounts = new List<Account>();
    if(!trigger.new.isEmpty()) {
        for(Contact cont: trigger.new) {
            Account acc = accMap.get(cont.AccountId);
            acc.Description = cont.Description;
            listToUpdateAccounts.add(acc);
        }
    }
    
    if(!listToUpdateAccounts.isEmpty()) {
        update listToUpdateAccounts;
    }

}