public class AccountProcessor{

    @future
    public static void countContacts(List<Id> recordIds) {
        List<Account> updateaccounts = new List<Account>();
        
        List<Account> accounts = [Select Id, Number_of_Contacts__c, (select id,accountID from contacts) from Account Where Id IN :recordIds];
        
        if(accounts.size()>0){
            for(Account acc: accounts){
                List<Contact> lstContacts = new List<Contact>();
                lstContacts = acc.contacts;
                
                acc.Number_of_Contacts__c = lstContacts.size();
                updateaccounts.add(acc);
            }
        
            if(updateaccounts.size()>0){
                update updateaccounts;
            }
        }
        
    }
}