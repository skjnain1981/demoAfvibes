@isTest
public class TestOpportunityChangeTrigger {
    @isTest static void testCreateAndUpdateOpportunity () {
        
        Test.enableChangeDataCapture();
        Opportunity opp1 = new Opportunity();
        opp1.Name='Sell 100 Widgets';
        opp1.StageName='Prospecting';
        opp1.CloseDate=Date.today().addMonths(3);
        insert opp1;
        
        
        Test.getEventBus().deliver(); 
        
        Opportunity[] oppRecords = [SELECT Id,StageName FROM Opportunity];
        Opportunity opp = oppRecords[0];
        opp.StageName = 'Closed Won';
		update opp;
        
        Test.getEventBus().deliver(); 
        
        Task[] taskList = [SELECT Id,Subject FROM Task];
		System.assertEquals(1, taskList.size(), 'The change event trigger did not create the expected task.');
        
    }
}