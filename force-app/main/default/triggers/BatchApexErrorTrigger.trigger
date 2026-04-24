trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
	List<BatchLeadConvertErrors__c> listToInsert = new List<BatchLeadConvertErrors__c>();
    
    for (BatchApexErrorEvent b : Trigger.new){
        BatchLeadConvertErrors__c tmp = new BatchLeadConvertErrors__c();
        tmp.AsyncApexJobId__c = b.AsyncApexJobId;
        tmp.Records__c = b.JobScope;
        tmp.StackTrace__c = b.StackTrace;
        listToInsert.add(tmp);
    }
    
    insert listToInsert;
}