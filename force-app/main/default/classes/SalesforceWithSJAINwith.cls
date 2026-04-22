public with sharing class SalesforceWithSJAINwith {
    public static List<Account> tryAFVibes(Set<Id> accountIds) {
        if (accountIds == null || accountIds.isEmpty()) {
            return new List<Account>();
        }
        return [SELECT Id, Name, Phone FROM Account WHERE Id IN :accountIds];
    }
}