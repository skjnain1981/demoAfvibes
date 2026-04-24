public with sharing class ClaudecodeDemo {

    public static List<Account> getAccounts(Set<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return new List<Account>();
        }

        return [
            SELECT Id, Name, Type, Industry, Phone, BillingCity, BillingState
            FROM Account
            WHERE Id IN :accountIds
        ];
    }
}