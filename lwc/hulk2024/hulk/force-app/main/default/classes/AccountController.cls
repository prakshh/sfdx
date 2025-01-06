public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getHighRevenueAccountRecords(){
        try {
            // solving -> Validate CRUD permission before SOQL/DML operation (rule: Security-ApexCRUDViolation)apex pmdApexCRUDViolation
            // Check if the current user has read access to the Account object
            if (!Schema.sObjectType.Account.isAccessible()) {
                throw new AuraHandledException('Insufficient permissions to access Account records.');
            }
            // Query the records only if the user has read access
            return [SELECT Id, Name, AnnualRevenue FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT 5];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}

/*

@AuraEnabled
    - expose Apex methods and properties to Lightning components
    - or, enables communication between Apex and client-side components.

@AuraEnabled(cacheable=true) 
    - improve performance by avoiding unnecessary server calls.
    - can be used for read-only operations to benefit from client-side caching in LWC.

*/





/*public class AccountController {
    public static Account insertAccount(Account accountToInsert) {
        insert accountToInsert;
        return accountToInsert;
    }
    
    public static List<Account> insertAccounts(List<Account> accountsToInsert) {
        insert accountsToInsert;
        return accountsToInsert;
    }

}*/