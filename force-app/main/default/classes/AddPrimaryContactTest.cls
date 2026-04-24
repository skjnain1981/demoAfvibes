@isTest
public class AddPrimaryContactTest {
    @testSetup
    static void setup() {
        List<Account> accountlist = new List<Account>();
        // add a parent account
        
        // add 100 child accounts
        for (Integer i = 1; i <= 50; i++) {
            Account acc = new Account();
            acc.name='Test Account'+i;
            acc.BillingState = 'NY';
            accountlist.add(acc);
        }
        
        // add 100 child accounts
        for (Integer j = 1; j <= 50; j++) {
            Account acc = new Account();
            acc.name='Test Account'+j;
            acc.BillingState = 'CA';
            accountlist.add(acc);
        }
        
        insert accountlist;
    }
    static testmethod void testQueueable() {
        Contact c = new Contact();
        // Create our Queueable instance
        AddPrimaryContact updater = new AddPrimaryContact(c, 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(updater);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [select count() from account where BillingState = 'CA']);
    }
}