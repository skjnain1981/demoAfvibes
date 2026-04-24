@isTest
private class DailyLeadProcessorTest {
    // Dummy CRON expression: midnight on March 15.
    // Because this is a test, job executes
    // immediately after Test.stopTest().
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        
        List<lead> leadlist = new List<lead>();
        for(Integer i=0;i<=200;i++){
            lead l = new lead();
            l.firstname='test ';
            l.lastname=string.valueof(i);
            l.company='test company';
            leadlist.add(l);
        }
        insert leadlist;
        
        
        Test.startTest();
        
        String jobId = System.schedule('ScheduledApexTest',CRON_EXP,new DailyLeadProcessor());
        List<lead> beforeleadlist = [select id, LeadSource from lead where LeadSource='Dreamforce'];
        System.assertEquals(0, beforeleadlist.size(), 'Lead exist with LeadSource blank before job has run');
        
        Test.stopTest();
        
        
        List<lead> afterleadlist = [select id, LeadSource from lead where LeadSource='Dreamforce'];
        System.assertEquals(leadlist.size(),afterleadlist.size());
    }
}