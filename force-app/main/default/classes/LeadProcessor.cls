public class LeadProcessor implements Database.Batchable<sObject> {
    
    public Database.QueryLocator start(Database.BatchableContext info){ 
        String query = 'select id, LeadSource from lead';
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext info, List<SObject> sobjectList){
        List<SObject> lstToUpdate = new list<SObject>();
        for(SObject obj : sobjectList){
            obj.put('LeadSource', 'Dreamforce');
            lstToUpdate.add(obj);
        }
        if(!lstToUpdate.isEmpty()){
            List<Database.SaveResult> srs = Database.update(lstToUpdate, false);
        }
    }
    
    public void finish(Database.BatchableContext BC){ 
        // execute any post-processing operations
    }
}