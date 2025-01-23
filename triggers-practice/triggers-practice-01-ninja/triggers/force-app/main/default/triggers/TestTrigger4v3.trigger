/*
 Whenever a Contact's description is updated, then it's parent Account's description should also get updated by it
*/
trigger TestTrigger4v3 on Contact (after update) {
    Map<Id, Contact> conMap = new Map<Id, Contact>();
    if(trigger.isAfter && trigger.isUpdate) {
        if(!trigger.new.isEmpty()) {
            for(Contact con : trigger.new) {
                if(trigger.oldMap.get(con.Id).Description != con.Description) {
                    // conMap.put(con.Id, con);
                    conMap.put(con.AccountId, con);
                }
            }
        }
    }
    
    List<Account> accList = [SELECT Id, Description FROM Account WHERE Id IN : conMap.keySet()];
    List<Account> listToUpdateAccount = new List<Account>();
    if(!accList.isEmpty()) {
        for(Account acc : accList) {
            acc.Description = conMap.get(acc.Id).Description;
            listToUpdateAccount.add(acc);
        }
    }
    if(!listToUpdateAccount.isEmpty()) {
        update listToUpdateAccount;
    }
}