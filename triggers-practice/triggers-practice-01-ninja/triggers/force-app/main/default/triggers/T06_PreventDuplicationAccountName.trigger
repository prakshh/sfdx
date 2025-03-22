/*
Trigger to prevent duplication of account records based on name whenever a record is inserted or updated
*/
trigger T06_PreventDuplicationAccountName on Account (before insert, before update) {
    
    Set<String> accNames = new Set<String>();

    for (Account acc : trigger.new) {
        // Avoid NullPointerException during insert
        if (trigger.isInsert || (trigger.isUpdate && acc.Name != trigger.oldMap.get(acc.Id).Name)) {
            accNames.add(acc.Name);
        }
    }

    if (!accNames.isEmpty()) {
        Map<String, Account> existingAccMap = new Map<String, Account>();
        for (Account acct : [SELECT Id, Name FROM Account WHERE Name IN : accNames]) {
            existingAccMap.put(acct.Name, acct);
        }

        for (Account acc : trigger.new) {
            // Prevent self-matching during update
            if (existingAccMap.containsKey(acc.Name) && (trigger.isInsert || acc.Id != existingAccMap.get(acc.Name).Id)) {
                acc.addError('Account name already exists');
            }
        }
    }
}


/*

Below code has some issues: It was showing duplication error message during contact's account name change, even if the account name is unique. 

In a before insert operation, trigger.oldMap does not exist because there are no previous records.

Accessing trigger.oldMap.get(acc.Id).Name on an insert will cause a NullPointerException.

*/


/*
// some mistakes

trigger T06_PreventDuplicationAccountName on Account (before insert, before update) {
    
    Set<String> accNames = new Set<String>();
    
    if(trigger.isBefore && (trigger.isInsert || trigger.isUpdate)) {
        if(!trigger.new.isEmpty()) {
            for(Account acc : trigger.new) {
                accNames.add(acc.Name);
            }
        }
    }
    
    List<Account> accList = [SELECT Id, Name FROM Account WHERE Name IN : accNames];
    Map<String, Account> existingAccMap = new Map<String, Account>();
    if(!accList.isEmpty()) {
        for(Account acct : accList) {
            existingAccMap.put(acct.Name, acct);
        }
        if(!trigger.new.isEmpty()) {
            for(Account accts : trigger.new) {
                if(existingAccMap.containsKey(accts.Name)) {
                    accts.addError('Account name already exists');
                }
            }
        }
    }
    
}

*/