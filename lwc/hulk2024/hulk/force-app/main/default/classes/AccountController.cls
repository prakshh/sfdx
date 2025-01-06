public with sharing class AccountController {
    @AuraEnabled
    public static List<Account> getHighRevenueAccountRecords(){
        try {
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}