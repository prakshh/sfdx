public with sharing class AccountController {
    @AuraEnabled(cacheable=true)
    public static List<Account> getHighRevenueAccountRecords(){
        try {
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