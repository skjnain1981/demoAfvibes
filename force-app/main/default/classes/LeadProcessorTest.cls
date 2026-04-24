@isTest
public class LeadProcessorTest {
    
    static testmethod void testScenario1(){
        List<Lead> leadlist = new List<lead>();
        
        for(Integer i=1;i<=200;i++){
            Lead l = new Lead();
            l.firstName = 'test ';
            l.lastName = string.valueof(i);
            l.Company='test company';
            leadlist.add(l);
        }
        insert leadlist;
        
        
        Test.starttest();       
        LeadProcessor myBatch  = new LeadProcessor();
        Database.executeBatch(myBatch,200);
        Test.stoptest();
    }
}