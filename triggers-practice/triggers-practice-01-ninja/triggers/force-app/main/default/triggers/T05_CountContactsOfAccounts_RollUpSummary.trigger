/*
 * Trigger to count number of contacts
 * associated with an account
 * and display the contacts count
 * on Account's custom field
*/

trigger T05_CountContactsOfAccounts_RollUpSummary on Contact (after insert, after update, after delete, after undelete) {
    Set<Id> accIds = new Set<Id>();
    if(trigger.isAfter && (trigger.isInsert || trigger.isUndelete)) {
        if(!trigger.new.isEmpty()) {
            for(Contact con : trigger.new) {
                if(con.AccountId != null) {
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    
    if(trigger.isAfter && trigger.isUpdate) {
        if(!trigger.new.isEmpty()) {
            for(Contact con : trigger.new) {
                if(con.AccountId != trigger.oldMap.get(con.Id).AccountId) {
                    if(trigger.oldMap.get(con.Id).AccountId != null) {
                        accIds.add(trigger.oldMap.get(con.Id).AccountId);
                    }
                    if(con.AccountId != null) {
                        accIds.add(con.AccountId);
                    }
                }
            }
        }
    }
    
    if(trigger.isAfter && trigger.isDelete) {
        if(!trigger.old.isEmpty()) {
            for(Contact con : trigger.old) {
                if(con.AccountId != null) {
                    accIds.add(con.AccountId);
                }
            }
        }
    }
    
    if(!accIds.isEmpty()) {
        List<Account> accList = [SELECT Id, Number_Of_Contacts__c, (SELECT Id FROM Contacts) FROM Account WHERE Id IN : accIds];
        List<Account> listToUpdateAccounts = new List<Account>();
        if(!accList.isEmpty()) {
            for(Account acc : accList) {
                acc.Number_Of_Contacts__c = acc.Contacts.size();
                listToUpdateAccounts.add(acc);
            }
        }
        if(!listToUpdateAccounts.isEmpty()) {
            update listToUpdateAccounts;
        }
    }
}