/*
Trigger to prevent duplication of account records based on name whenever a record is inserted or updated
*/
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