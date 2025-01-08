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
    
    @AuraEnabled
    public static List<Account> getHighRevenueAccountRecordsUsingImperativeCall(Integer count) {
        try {
            return [SELECT id, Name, AnnualRevenue FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT : count];
        } catch(Exception e) {
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

Wire Service in LWC
    Definition: 
		A reactive mechanism to fetch data from Salesforce or invoke an Apex method automatically.
    Purpose: 
		Automatically binds data to a component property or invokes a method when dependencies change.
    Key Features:
        Supports @AuraEnabled(cacheable=true) for client-side caching.
        Automatically re-runs when reactive parameters change.
        Simplifies data fetching for read-only operations.

*/

/*

Imperative Call in LWC
    Definition: 
		Programmatic way to call Apex methods directly from JavaScript.
    Syntax: 
		Use import to include the Apex method, then invoke it using a promise (then/catch).
    Key Points:
        No need for @AuraEnabled(cacheable=true).
        Always fetches fresh data from the server.
        Supports both read and write operations.
        Allows dynamic parameters and fine-grained control over the call.
	code:
		import getAccountDetails from '@salesforce/apex/AccountController.getAccountDetails';
        getAccountDetails({ accountId: '001...' })
          .then(result => {
            console.log(result);
          })
          .catch(error => {
            console.error(error);
          });
        

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