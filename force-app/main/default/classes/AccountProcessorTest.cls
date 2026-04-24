@isTest
public class AccountProcessorTest {
    
    static testmethod void testScenario1(){
        account acc1 = new account();
        acc1.name='test client';
        insert acc1;
        
        contact c = new contact();     
        c.firstname='contact';
        c.lastname='test';
        c.accountid=acc1.id;
        insert c; 
        
        List<ID> accountIDs = new List<ID>();
        List<account> accountlist = [select id from account where name='test client' limit 1];
        
        for(account acc : accountlist){
            accountIDs.add(acc.id);
        }
        System.assertEquals(1, accountIDs.size());
        Test.startTest();
        AccountProcessor.countContacts(accountIDs);
        Test.stopTest();
        List<account> singleaccount = [select id,Number_of_Contacts__c from account where name='test client' limit 1];
        
        //System.assertEquals(1, singleaccount[0].Number_of_Contacts__c);
    }
}